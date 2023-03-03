import '../models/story_model.dart';
import '../models/user_model.dart';
import '../screens/story_screen.dart';

class StoryPlayerState {
  final List<Story> currentStories;
  final User currentUser;
  final int currentIndex;
  StoryPlayerState({
    this.currentStories = const [],
    this.currentUser = const User(
      id: 0,
      name: '',
      profileImageUrl: '',
      path: '',
    ),
    this.currentIndex = 0,
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
