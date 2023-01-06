import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class CategoryMovies {
  CategoryMovies({
    required this.id,
    required this.catName,
  });

  final String id;
  final String catName;

  factory CategoryMovies.fromJson(RecordModel json) => CategoryMovies(
        id: json.id,
        catName: json.getStringValue('catName'),
      );
}
