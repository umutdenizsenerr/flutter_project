import '../models/story_model.dart';
import '../models/user_model.dart';

class StoryPlayerState {
  final List<Story> currentStories;
  final User currentUser;
  final int currentIndex;
  StoryPlayerState({
    required this.currentStories,
    required this.currentUser,
    required this.currentIndex,
  });

  StoryPlayerState copyWith({
    List<Story>? currentStories,
    User? currentUser,
    int? currentIndex,
  }) =>
      StoryPlayerState(
        currentStories: currentStories ?? this.currentStories,
        currentUser: currentUser ?? this.currentUser,
        currentIndex: currentIndex ?? this.currentIndex,
      );
}
