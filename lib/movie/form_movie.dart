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
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
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
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: 'Image',
            //   ),
            // ),
            TextFormField(
              // keyboardType: ,
              decoration: InputDecoration(
                labelText: 'Color',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  createMovie(_title, _color, [_category]);
                },
                child: const Text('Create Movie'))
          ],
        ),
      ),
    );
  }
}

createMovie(String title, String color, List<String> category) async {
  final pb = PocketBase('http://127.0.0.1:8090');

  // example create body
  final record = await pb.collection('movies').create(body: {
    "category": [category],
    "title": title,
    "color": color
  }
      // , files: [
      //   http.MultipartFile.fromString(
      //     'document',
      //     'example content 1...',
      //     filename: image.toString(),
      //   ),
      // ]
      );
  return record;
}
