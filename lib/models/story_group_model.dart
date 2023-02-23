import '/models/story_model.dart';
import '/models/user_model.dart';

class StoryGroup {
  List<Story> storyList;
  final User user;
  int currentIndex = 0;

  StoryGroup({
    required this.storyList,
    required this.user,
    required this.currentIndex,
  });
}
