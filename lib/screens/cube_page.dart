import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../bloc/story_player_state.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';
import 'package:cube_transition/cube_transition.dart';
import '../widgets/animated_bar.dart';
import '../widgets/user_info.dart';
import '../bloc/story_player_bloc.dart';
import '../bloc/story_player_event.dart';
import 'dart:math' as math;

class CubePageRoute<T> extends PageRoute<T> {
  final Widget enterPage;

  CubePageRoute({required this.enterPage});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return Stack(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.005)
            ..rotateY(-math.pi / 2 * animation.value),
          child: child,
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.005)
            ..rotateY(-math.pi / 2 * (1 - animation.value)),
          child: enterPage,
        ),
      ],
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return enterPage;
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);
}
