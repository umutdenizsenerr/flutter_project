import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/bloc/story_player_event.dart';
import '../bloc/story_player_bloc.dart';
import '../bloc/story_player_state.dart';
import '../models/user_model.dart';

class UserInfo extends StatelessWidget {
  final User user;

  const UserInfo({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: user.profileImageUrl.isNotEmpty
              ? NetworkImage(user.profileImageUrl)
              : AssetImage('assets/images/${user.path}') as ImageProvider,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        BlocBuilder<StoryPlayerBloc, StoryPlayerState>(
          builder: (context, state) {
            return Container(
              child: IconButton(
                iconSize: 50,
                icon: const Icon(
                  Icons.close,
                  size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  BlocProvider.of<StoryPlayerBloc>(context)
                      .add(CloseStoryEvent());
                },
              ),
            );
          },
        )
      ],
    );
  }
}
