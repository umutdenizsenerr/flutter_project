import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../bloc/story_player_state.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';
import '../data.dart';
import 'package:cube_transition/cube_transition.dart';
import '../widgets/animated_bar.dart';
import '../widgets/user_info.dart';
import '../bloc/story_player_bloc.dart';
import '../bloc/story_player_event.dart';

class StoryScreen extends StatefulWidget {
  List<Story> stories;
  User user;
  int currentIndex;

  StoryScreen({
    super.key,
    required this.stories,
    required this.user,
    required this.currentIndex,
  });

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    for (int i = 0; i < widget.stories.length; i++) {
      if (widget.stories[i].media == MediaType.video) {
        _videoPlayerController = widget.stories[i].url.isNotEmpty
            ? VideoPlayerController.network(widget.stories[i].url)
            : VideoPlayerController.asset(
                'assets/videos/${widget.stories[i].path}');
      }
    }

    _videoPlayerController.initialize().then((value) => setState(() {}));
    _animationController = AnimationController(
      vsync: this,
    );
    _animationController.duration = const Duration(seconds: 5);

    _animationController.forward();

    _videoPlayerController.play();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();

        // _loadStory(state);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {
            BlocProvider.of<StoryPlayerBloc>(context)
                .add(GoToPreviousStoryPageEvent());
          }

          // Swiping in left direction.
          if (details.delta.dx < 0) {
            BlocProvider.of<StoryPlayerBloc>(context)
                .add(GoToNextStoryPageEvent());
          }
        },
        onTapUp: (details) => _onTapUp(),
        child: BlocConsumer<StoryPlayerBloc, StoryPlayerState>(
          listener: (context, state) {
            _loadStory(blocState: state);
          },
          builder: (context, state) {
            return Stack(children: <Widget>[
              PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.stories.length,
                  itemBuilder: (context, index) {
                    Story currentStory =
                        state.currentStories[state.currentIndex];
                    switch (currentStory.media) {
                      case MediaType.image:
                        return currentStory.url.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: currentStory.url,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/${currentStory.path}',
                                fit: BoxFit.cover,
                              );
                      case MediaType.video:
                        if (_videoPlayerController.value.isInitialized) {
                          return FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoPlayerController.value.size.width,
                              height: _videoPlayerController.value.size.height,
                              child: VideoPlayer(_videoPlayerController),
                            ),
                          );
                        } else {
                          return const FittedBox(
                            fit: BoxFit.cover,
                            child: CircularProgressIndicator(),
                          );
                        }
                    }
                  }),
              Positioned(
                  top: 40.0,
                  left: 10.0,
                  right: 10.0,
                  child: Row(
                    children: widget.stories
                        .asMap()
                        .map((i, e) => MapEntry(
                              i,
                              AnimatedBar(
                                animController: _animationController,
                                position: i,
                                currentIndex: state.currentIndex,
                              ),
                            ))
                        .values
                        .toList(),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.5,
                  vertical: 50.0,
                ),
                child: UserInfo(user: widget.user),
              ),
            ]);
          },
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 4) {
      BlocProvider.of<StoryPlayerBloc>(context).add(GoToPreviousStoryEvent());
    } else if (dx > 3 * screenWidth / 4) {
      BlocProvider.of<StoryPlayerBloc>(context).add(GoToNextStoryEvent());
    } else {
      _videoPlayerController.pause();
      _animationController.stop();
    }
  }

  void _onTapUp() {
    _videoPlayerController.play();
    _animationController.forward();
  }

  void _loadStory({
    required blocState,
    bool animateToPage = true,
  }) {
    Story story = blocState.currentStories[blocState.currentIndex];
    _animationController.stop();
    _animationController.reset();
    if (blocState.isSwiped) {
      Navigator.of(context).push(
        CubePageRoute(
          enterPage: BlocProvider(
              create: (_) => StoryPlayerBloc(userId: blocState.currentUser.id),
              child: StoryScreen(
                stories: blocState.currentStories,
                user: blocState.currentUser,
                currentIndex: blocState.currentIndex,
              )),
          duration: const Duration(milliseconds: 400),
        ),
      );
    } else if (blocState.isEnded) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      switch (story.media) {
        case MediaType.image:
          _animationController.duration = const Duration(seconds: 5);
          _animationController.forward();
          break;
        case MediaType.video:
          _videoPlayerController.dispose();
          _videoPlayerController = story.url.isNotEmpty
              ? VideoPlayerController.network(story.url)
              : VideoPlayerController.asset('assets/videos/${story.path}');
          _videoPlayerController.initialize().then((_) {
            setState(() {});
            if (_videoPlayerController.value.isInitialized) {
              _animationController.duration =
                  _videoPlayerController.value.duration;
              _videoPlayerController.play();
              _animationController.forward();
            }
          });

          break;
      }
    }
    if (animateToPage) {
      _pageController.animateToPage(
        widget.currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}
