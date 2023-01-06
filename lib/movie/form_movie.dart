import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_list/category_model.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class formMovie extends StatefulWidget {
  const formMovie({super.key});

  @override
  State<formMovie> createState() => _formMovieState();
}

class _formMovieState extends State<formMovie> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  // FileImage _image = const FileImage('');
  String _color = '';
  String _selectedCategoryId = '';

  late Future<List<CategoryMovies>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Movie'),
      ),
      body: FutureBuilder<List<CategoryMovies>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) => _title = value!,
                  ),
                  DropdownButton<String>(
                    value: _selectedCategoryId == ''
                        ? snapshot.data?.first.id
                        : _selectedCategoryId,
                    items: snapshot.data?.map((category) {
                      return DropdownMenuItem(
                        value: category.id,
                        child: Text(category.catName),
                      );
                    }).toList(),
                    onChanged: (newCategoryId) {
                      setState(() {
                        _selectedCategoryId = newCategoryId!;
                      });
                    },
                  ),
                  // TextFormField(
                  //   decoration: const InputDecoration(
                  //     labelText: 'Category',
                  //   ),
                  //   validator: (value) {
                  //     if (value?.isEmpty ?? true) {
                  //       return 'Please enter a category';
                  //     }
                  //     return null;
                  //   },
                  //   onSaved: (value) => _category = value!,
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     labelText: 'Image',
                  //   ),
                  // ),
                  TextFormField(
                    // keyboardType: ,
                    decoration: const InputDecoration(
                      labelText: 'Color',
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a color';
                      }
                      return null;
                    },
                    onSaved: (value) => _color = value!,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? true) {
                          _formKey.currentState?.save();
                          print(_title);
                          print(_selectedCategoryId);
                          print(_color);
                          createMovie(
                              title: _title,
                              color: _color,
                              category: _selectedCategoryId);
                        }
                      },
                      child: const Text('Create Movie'))
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}

createMovie(
    {required String title,
    required String color,
    required String category}) async {
  final pb = PocketBase('http://127.0.0.1:8090');
  print('Creating movie');
  print(category);
  List<String> cat = [];
  cat.add(category);
  print(cat);
  // example create body
  final record = await pb
      .collection('movies')
      .create(body: {'category': cat, 'title': title, 'color': color}
          // , files: [
          //   http.MultipartFile.fromString(
          //     'document',
          //     'example content 1...',
          //     filename: image.toString(),
          //   ),
          // ]
          );
  print(record);
}

Future<List<CategoryMovies>> getCategory() async {
  final pb = PocketBase('http://127.0.0.1:8090');

  // fetch a paginated records list
  final resultList = await pb.collection('category').getFullList(
        batch: 200,
        sort: '-created',
      );

  return resultList.map((e) => CategoryMovies.fromJson(e)).toList();
}
