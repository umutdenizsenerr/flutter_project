import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/story_group_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram Story Player',
          style: TextStyle(
              fontFamily: 'Satisfy', color: Colors.black, fontSize: 24.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.heart),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.facebookMessenger),
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: stories
                .map(
                  (storyGroup) => StoryGroupCard(
                    user: storyGroup.user,
                    storyList: storyGroup.storyList,
                  ),
                )
                .toList()),
      ),
    );
  }
}
