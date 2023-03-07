import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/story_player_bloc.dart';
import '../screens/story_screen.dart';
import '/models/user_model.dart';
import '/models/story_model.dart';

class StoryGroupCard extends StatelessWidget {
  final User user;
  final List<Story> storyList;

  StoryGroupCard({
    required this.user,
    required this.storyList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (_) => StoryPlayerBloc(
                            userId: user.id,
                          ),
                          child: StoryScreen(
                            stories: storyList,
                            user: user,
                            currentIndex: 0,
                          ),
                        )),
              );
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              child: CircleAvatar(
                radius: 28,
                backgroundImage: user.profileImageUrl.isNotEmpty
                    ? NetworkImage(user.profileImageUrl)
                    : AssetImage('assets/images/${user.path}') as ImageProvider,
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            user.name,
            style: const TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
