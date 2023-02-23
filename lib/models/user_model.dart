import 'package:meta/meta.dart';

class User {
  final String name;
  final String profileImageUrl;
  final String path;
  final int id;

  const User({
    required this.name,
    required this.profileImageUrl,
    required this.path,
    required this.id,
  });
}
