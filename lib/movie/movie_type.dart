import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class Movies {
  Movies({
    required this.title,
    required this.color,
    required this.image,
    required this.category,
  });

  final String title;
  final Color color;
  final Image image;
  final List category;

  factory Movies.fromJson(RecordModel json) => Movies(
        title: json.getStringValue('title'),
        color: Color(
            int.parse(json.getStringValue('color').substring(1, 7), radix: 16) +
                0xFF000000),
        image: json.getStringValue('image') == ''
            ? Image.network('https://picsum.photos/250?image=9')
            : Image.network(
                'http://127.0.0.1:8090/api/files/${json.collectionId}/${json.id}/${json.getStringValue('image')}'),
        category: List<String>.from(
            json.expand['category']!.map((x) => x.getStringValue('catName'))),
      );
}
