import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../screens/story_screen.dart';
import 'story_player_event.dart';
import 'story_player_state.dart';
import '../data.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';

class StoryPlayerBloc extends Bloc<StoryPlayerEvent, StoryPlayerState> {
  StoryPlayerBloc({required int userId})
      : super(StoryPlayerState(
            currentStories: stories[userId - 1].storyList,
            currentUser: stories[userId - 1].user,
            currentIndex: stories[userId - 1].currentIndex)) {
    on<AnimationCompletedEvent>(_onStoryScreenAnimationCompleted);
    on<GoToPreviousStoryEvent>(_onStoryScreenGoToPreviousStory);
    on<GoToPreviousStoryPageEvent>(_onStoryScreenGoToPreviousStoryPage);
    on<GoToNextStoryEvent>(_onStoryScreenGoToNextStory);
  }

  void _onStoryScreenAnimationCompleted(
    AnimationCompletedEvent event,
    Emitter<StoryPlayerState> emit,
  ) {
    emit(state.copyWith(
      currentIndex: state.currentIndex < state.currentStories.length - 1
          ? state.currentIndex + 1
          : 0,
    ));
  }

  void _onStoryScreenGoToPreviousStory(
    GoToPreviousStoryEvent event,
    Emitter<StoryPlayerState> emit,
  ) {
    emit(state.copyWith(
      currentIndex:
          state.currentIndex > 0 ? state.currentIndex - 1 : state.currentIndex,
    ));
    print(state.currentIndex);
  }

  void _onStoryScreenGoToPreviousStoryPage(
    GoToPreviousStoryPageEvent event,
    Emitter<StoryPlayerState> emit,
  ) {
    stories[state.currentUser.id - 1].currentIndex = state.currentIndex;

    emit(state.copyWith(
      currentIndex: stories[state.currentUser.id - 2].currentIndex,
      currentStories: stories[state.currentUser.id - 2].storyList,
      currentUser: stories[state.currentUser.id - 2].user,
    ));
  }

  void _onStoryScreenGoToNextStory(
    GoToNextStoryEvent event,
    Emitter<StoryPlayerState> emit,
  ) {
    emit(state.copyWith(
      currentIndex: state.currentIndex < state.currentStories.length - 1
          ? state.currentIndex + 1
          : state.currentIndex,
    ));
  }
}
