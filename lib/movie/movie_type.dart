import 'package:flutter/material.dart';

class Movies {
  Movies({
    required this.title,
    required this.color,
    required this.image,
    required this.tag,
  });

  final String title;
  final Color color;
  final Image image;
  final List tag;
}
