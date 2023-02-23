# Instagram Story Player

This Flutter application is a simple version of Instagram story player that allows users to view and swipe through stories, pause and resume playback, and navigate between story groups.

## Features

- **Cubic transition among story groups:** The app uses a cubic transition animation when the user swipes left or right to switch between story groups.

- **Pause and resume playback:** When the user rests and holds on the screen, the story playback is paused. When they lift their finger, the playback continues.

- **Navigate between stories:** Users can tap left or right to go to the previous or next story in the current story group.

- **Support for images and videos:** The app can display both images and videos as stories, which are downloaded from the internet.

- **Duration control:** Images have a duration of 5 seconds, while the duration of videos is determined by their content length. Each story has a progress bar on top of the screen that reflects its duration.

- **Resume from where you left off:** When the user swipes between story groups, the app remembers the last story they viewed in each group and resumes playback from that point.

## Usage

1. Clone this repository to your local machine.
2. Open the project in your preferred IDE (such as Android Studio or Visual Studio Code).
3. Run the app on an emulator or physical device using the `flutter run` command in the terminal.

## Dependencies

This app uses the following dependencies:

- `flutter_launcher_icons: ^0.11.0`: A package that provides utilities to generate custom app icons for both Android and iOS.
- `font_awesome_flutter: ^10.4.0`: A package that provides a collection of customizable icons that can be used in Flutter apps.
- `cached_network_image: ^3.2.3`: A package that provides image loading and caching functionality for images loaded from the internet.
- `video_player: ^2.5.1`: A Flutter plugin that provides video playback functionality.
- `cube_transition: "^1.0.0"`: A 3D Cube transition for PageView and PageRoute.
