import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';
import '../data.dart';
import 'package:cube_transition/cube_transition.dart';
import '../widgets/animated_bar.dart';
import '../widgets/user_info.dart';

class StoryScreen extends StatefulWidget {
  List<Story> stories;
  List<Story> prevStories;
  List<Story> nextStories;
  User user;
  int currentIndex;

  StoryScreen({
    super.key,
    required this.stories,
    required this.prevStories,
    required this.nextStories,
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
        setState(() {
          if (widget.currentIndex < widget.stories.length - 1) {
            widget.currentIndex++;
            _loadStory(story: widget.stories[widget.currentIndex]);
          }
        });
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
    final Story story = widget.stories[widget.currentIndex];

    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, story),
        onPanUpdate: (details) {
          // Swiping in right direction.
          if (details.delta.dx > 0) {
            _goPrevStory(true);
          }

          // Swiping in left direction.
          if (details.delta.dx < 0) {
            _goNextStory(true);
          }
        },
        onTapUp: (details) => _onTapUp(story),
        child: Stack(children: <Widget>[
          PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (context, index) {
                switch (story.media) {
                  case MediaType.image:
                    return story.url.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: story.url,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/${story.path}',
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
                    }
                }
                return const SizedBox.shrink();
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
                            currentIndex: widget.currentIndex,
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
        ]),
      ),
    );
  }

  void _goPrevStory(isSwiped) {
    setState(() {
      if (widget.currentIndex >= 1 && !isSwiped) {
        widget.currentIndex--;
        _loadStory(story: widget.stories[widget.currentIndex]);
      } else {
        _loadStory(story: widget.stories[widget.currentIndex]);

        if (widget.user.id > 1) {
          stories[widget.user.id - 1].currentIndex = widget.currentIndex;

          Navigator.of(context).push(
            CubePageRoute(
              enterPage: StoryScreen(
                stories: widget.prevStories,
                prevStories: widget.user.id < 3
                    ? []
                    : stories[widget.user.id - 3].storyList,
                nextStories: widget.stories,
                user: stories[widget.user.id - 2].user,
                currentIndex: stories[widget.user.id - 2].currentIndex,
              ),
              // exitPage: this,
              duration: const Duration(milliseconds: 400),
            ),
          );
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      }
    });
  }

  void _goNextStory(isSwiped) {
    setState(() {
      if (widget.currentIndex < widget.stories.length - 1 && !isSwiped) {
        widget.currentIndex++;
        _loadStory(story: widget.stories[widget.currentIndex]);
      } else {
        //go to next story group
        _loadStory(story: widget.stories[widget.currentIndex]);
        if (widget.user.id != stories.length) {
          stories[widget.user.id - 1].currentIndex = widget.currentIndex;
          Navigator.of(context).push(
            CubePageRoute(
              enterPage: StoryScreen(
                stories: widget.nextStories,
                prevStories: widget.stories,
                nextStories: widget.user.id == stories.length - 1
                    ? []
                    : stories[widget.user.id + 1].storyList,
                user: stories[widget.user.id].user,
                currentIndex: stories[widget.user.id].currentIndex,
              ),
              // exitPage: this,
              duration: const Duration(milliseconds: 400),
            ),
          );
        } else {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      }
    });
  }

  void _onTapDown(TapDownDetails details, Story story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 4) {
      _goPrevStory(false);
    } else if (dx > 3 * screenWidth / 4) {
      _goNextStory(false);
    } else {
      if (story.media == MediaType.video) {
        _videoPlayerController.pause();
        _animationController.stop();
      } else {
        _animationController.stop();
      }
    }
  }

  void _onTapUp(Story story) {
    if (story.media == MediaType.video) {
      _videoPlayerController.play();
    }
    _animationController.forward();
  }

  void _loadStory({required Story story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
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
    if (animateToPage) {
      _pageController.animateToPage(
        widget.currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }
}
