import '/models/story_group_model.dart';
import '/models/story_model.dart';
import '/models/user_model.dart';

final List<StoryGroup> stories = [
  StoryGroup(
      currentIndex: 0,
      storyList: [
        const Story(
            url: 'https://loremflickr.com/g/1080/1920/paris',
            media: MediaType.image,
            duration: Duration(seconds: 10),
            path: ''),
        const Story(
            url: '',
            media: MediaType.image,
            duration: Duration(seconds: 13),
            path: 'mushroom.jpg'),
        const Story(url: '', media: MediaType.video, path: 'seven_segment.mp4'),
      ],
      user: const User(
          name: 'udsumut',
          profileImageUrl: '',
          path: 'umut_profile.jpeg',
          id: 1)),
  StoryGroup(
      currentIndex: 0,
      storyList: [
        const Story(
            url: 'https://loremflickr.com/g/1080/1920/rio',
            media: MediaType.image,
            duration: Duration(seconds: 5),
            path: ''),
        const Story(
            url:
                'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
            media: MediaType.video,
            path: ''),
        const Story(
            url: '',
            media: MediaType.image,
            duration: Duration(seconds: 5),
            path: 'parti.jpeg'),
        const Story(
            url: '',
            media: MediaType.image,
            duration: Duration(seconds: 8),
            path: 'istanbul.jpeg'),
      ],
      user: const User(
          name: 'burcegulten', profileImageUrl: '', path: 'burce.jpeg', id: 2)),
  StoryGroup(
      currentIndex: 0,
      storyList: [
        const Story(
            url:
                'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
            media: MediaType.image,
            duration: Duration(seconds: 10),
            path: ''),
        const Story(url: '', media: MediaType.video, path: 'kadebostany.mp4'),
        const Story(
            url:
                'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
            media: MediaType.image,
            duration: Duration(seconds: 5),
            path: ''),
      ],
      user: const User(
          name: 'ecemgunes',
          path: '',
          profileImageUrl: 'https://i.pravatar.cc/150?img=2',
          id: 3)),
  StoryGroup(
      currentIndex: 0,
      storyList: [
        const Story(
            url: 'https://picsum.photos/seed/picsum/1080/1920',
            media: MediaType.image,
            duration: Duration(seconds: 7),
            path: ''),
        const Story(
            url:
                'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
            media: MediaType.video,
            path: ''),
      ],
      user: const User(
          name: 'arascakir',
          path: '',
          profileImageUrl: 'https://i.pravatar.cc/150?img=3',
          id: 4)),
  StoryGroup(
      currentIndex: 0,
      storyList: [
        const Story(
            url: '',
            media: MediaType.image,
            duration: Duration(seconds: 13),
            path: 'boun_gate.jpeg'),
        const Story(
            url: '',
            media: MediaType.image,
            duration: Duration(seconds: 13),
            path: 'oldudeniz.jpeg'),
        const Story(
            url:
                'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
            media: MediaType.video,
            duration: Duration(seconds: 13),
            path: ''),
      ],
      user: const User(
          name: 'aliozturk',
          path: '',
          profileImageUrl: 'https://i.pravatar.cc/150?img=6',
          id: 5))
];
