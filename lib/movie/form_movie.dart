import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

class formMovie extends StatefulWidget {
  const formMovie({super.key});

  @override
  State<formMovie> createState() => _formMovieState();
}

class _formMovieState extends State<formMovie> {
  final _formKey = GlobalKey<FormState>();
  List<Map<dynamic, dynamic>> categories = [
    {'id': 'd2v19lc0l9xcc9b', 'name': 'Action'},
    {'id': 's9lea178tit607k', 'name': 'Comedy'},
    {'id': '4ci4imbfszeat7d', 'name': 'Drama'},
  ];
  String _title = '';
  String _category = '';
  // FileImage _image = const FileImage('');
  String _color = '';
  String? _selectedCategoryId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Movie'),
      ),
      body: Form(
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
            // DropdownButton<String>(
            //   value: _selectedCategoryId,
            //   items: categories.map((category) {
            //     return DropdownMenuItem(
            //       value: category.id,
            //       child: Text(category.name),
            //     );
            //   }).toList(),
            //   onChanged: (newCategoryId) {
            //     setState(() {
            //       _selectedCategoryId = newCategoryId;
            //     });
            //   },
            // ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a category';
                }
                return null;
              },
              onSaved: (value) => _category = value!,
            ),
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
                    print(_category);
                    print(_color);
                    createMovie(
                        title: _title, color: _color, category: _category);
                  }
                },
                child: const Text('Create Movie'))
          ],
        ),
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
