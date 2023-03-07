import 'package:equatable/equatable.dart';

abstract class StoryPlayerEvent extends Equatable {
  const StoryPlayerEvent();
  @override
  List<Object?> get props => [];
}

class GoToPreviousStoryEvent extends StoryPlayerEvent {}

class GoToNextStoryEvent extends StoryPlayerEvent {}

class GoToPreviousStoryPageEvent extends StoryPlayerEvent {}

class GoToNextStoryPageEvent extends StoryPlayerEvent {}

class CloseStoryEvent extends StoryPlayerEvent {}
