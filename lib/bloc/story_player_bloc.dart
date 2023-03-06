import 'package:flutter_bloc/flutter_bloc.dart';
import 'story_player_event.dart';
import 'story_player_state.dart';
import '../data.dart';

class StoryPlayerBloc extends Bloc<StoryPlayerEvent, StoryPlayerState> {
  StoryPlayerBloc({required int userId})
      : super(StoryPlayerState(
            currentStories: stories[userId - 1].storyList,
            currentUser: stories[userId - 1].user,
            currentIndex: stories[userId - 1].currentIndex,
            isSwiped: false,
            isEnded: false)) {
    on<GoToPreviousStoryEvent>(_onStoryScreenGoToPreviousStory);
    on<GoToPreviousStoryPageEvent>(_onStoryScreenGoToPreviousStoryPage);
    on<GoToNextStoryEvent>(_onStoryScreenGoToNextStory);
    on<GoToNextStoryPageEvent>(_onStoryScreenGoToNextStoryPage);
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
      isSwiped: true,
    ));
    // emit(state.copyWith(
    //   currentIndex:
    //       state.currentIndex > 0 ? state.currentIndex - 1 : state.currentIndex,
    // ));

    // print(state.currentIndex);
  }

  void _onStoryScreenGoToPreviousStory(
    GoToPreviousStoryEvent event,
    Emitter<StoryPlayerState> emit,
  ) {
    if (state.currentIndex != 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    } else {
      stories[state.currentUser.id - 1].currentIndex = state.currentIndex;
      if (state.currentUser.id - 1 > 0) {
        emit(state.copyWith(
          currentIndex: stories[state.currentUser.id - 2].currentIndex,
          currentStories: stories[state.currentUser.id - 2].storyList,
          currentUser: stories[state.currentUser.id - 2].user,
          isSwiped: true,
        ));
      } else {
        emit(state.copyWith(
          isEnded: true,
        ));
      }
    }
  }

  void _onStoryScreenGoToNextStory(
    GoToNextStoryEvent event,
    Emitter<StoryPlayerState> emit,
  ) {
    if (state.currentIndex < state.currentStories.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    } else {
      stories[state.currentUser.id - 1].currentIndex = state.currentIndex;

      if (state.currentUser.id != stories.length) {
        emit(state.copyWith(
          currentIndex: stories[state.currentUser.id].currentIndex,
          currentStories: stories[state.currentUser.id].storyList,
          currentUser: stories[state.currentUser.id].user,
          isSwiped: true,
        ));
      } else {
        emit(state.copyWith(
          isEnded: true,
        ));
      }
    }
  }

  void _onStoryScreenGoToNextStoryPage(
    GoToNextStoryPageEvent event,
    Emitter<StoryPlayerState> emit,
  ) {
    stories[state.currentUser.id - 1].currentIndex = state.currentIndex;
    emit(state.copyWith(
      currentIndex: stories[state.currentUser.id].currentIndex,
      currentStories: stories[state.currentUser.id].storyList,
      currentUser: stories[state.currentUser.id].user,
      isSwiped: true,
    ));
    // print('sa');
    // print(state.currentUser.id);
  }
}
