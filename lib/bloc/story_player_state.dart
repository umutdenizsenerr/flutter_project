import 'package:equatable/equatable.dart';
import '../models/story_model.dart';
import '../models/user_model.dart';

class StoryPlayerState extends Equatable {
  StoryPlayerState({
    required this.currentStories,
    required this.currentUser,
    required this.currentIndex,
    required this.isSwiped,
    required this.isEnded,
  });
  final List<Story> currentStories;
  final User currentUser;
  final int currentIndex;
  final bool isSwiped;
  final bool isEnded;

  StoryPlayerState copyWith({
    List<Story>? currentStories,
    User? currentUser,
    int? currentIndex,
    bool? isSwiped,
    bool? isEnded,
  }) =>
      StoryPlayerState(
        currentStories: currentStories ?? [...this.currentStories],
        currentUser: currentUser ?? this.currentUser,
        currentIndex: currentIndex ?? this.currentIndex,
        isSwiped: isSwiped ?? this.isSwiped,
        isEnded: isEnded ?? this.isEnded,
      );
  @override
  List<Object?> get props =>
      [currentStories, currentUser, currentIndex, isSwiped, isEnded];
}
