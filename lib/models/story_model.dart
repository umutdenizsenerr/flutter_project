import 'package:flutter/material.dart';

enum MediaType { image, video }

class Story {
  final String url;
  final String path;
  final MediaType media;
  final Duration? duration;

  const Story({
    required this.url,
    required this.path,
    required this.media,
    this.duration,
  });
}
