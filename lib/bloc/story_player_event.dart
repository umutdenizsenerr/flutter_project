abstract class StoryPlayerEvent {
  const StoryPlayerEvent();
}

class AnimationCompletedEvent extends StoryPlayerEvent {}

class GoToPreviousStoryEvent extends StoryPlayerEvent {}

class GoToNextStoryEvent extends StoryPlayerEvent {}

class GoToPreviousStoryPageEvent extends StoryPlayerEvent {}
