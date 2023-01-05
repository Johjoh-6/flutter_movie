import 'package:flutter/material.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:movie_list/movie/card_movie.dart';
import 'package:movie_list/movie/form_movie.dart';
import 'package:movie_list/movie/movie_type.dart';
import 'package:pocketbase/pocketbase.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RenderList();
  }
}

Future<List<Movies>> _getMovies() async {
  final pb = PocketBase('http://127.0.0.1:8090');
  // fetch a paginated records list
  final resultList = await pb
      .collection('movies')
      .getFullList(batch: 200, sort: '-created', expand: 'category');
  print(resultList);
  return resultList.map((e) => Movies.fromJson(e)).toList();
}

class RenderList extends StatefulWidget {
  const RenderList({super.key});

  @override
  State<RenderList> createState() => _RenderListState();
}

class _RenderListState extends State<RenderList> {
  // List<Movies> _movies(BuildContext context) {
  // return [
  //   Movies(
  //       title: 'Movie 1',
  //       color: Colors.red,
  //       image: Image.network('https://picsum.photos/250?image=1'),
  //       tag: ['action']),
  //   Movies(
  //       title: 'Movie 2',
  //       color: Colors.green,
  //       image: Image.network('https://picsum.photos/250?image=2'),
  //       tag: ['action']),
  //   Movies(
  //       title: 'Movie 3',
  //       color: Colors.blue,
  //       image: Image.network('https://picsum.photos/250?image=3'),
  //       tag: ['drama']),
  //   Movies(
  //       title: 'Movie 4',
  //       color: Colors.yellow,
  //       image: Image.network('https://picsum.photos/250?image=4'),
  //       tag: ['drama', 'comedy']),
  //   Movies(
  //       title: 'Movie 5',
  //       color: Colors.orange,
  //       image: Image.network('https://picsum.photos/250?image=5'),
  //       tag: ['action', 'comedy']),
  //   Movies(
  //       title: 'Movie 6',
  //       color: Colors.purple,
  //       image: Image.network('https://picsum.photos/250?image=6'),
  //       tag: ['comedy']),
  //   Movies(
  //       title: 'Movie 7',
  //       color: Colors.pink,
  //       image: Image.network('https://picsum.photos/250?image=7'),
  //       tag: ['comedy']),
  //   Movies(
  //       title: 'Movie 8',
  //       color: Colors.brown,
  //       image: Image.network('https://picsum.photos/250?image=8'),
  //       tag: ['action', 'comedy']),
  //   Movies(
  //       title: 'Movie 9',
  //       color: Colors.grey,
  //       image: Image.network('https://picsum.photos/250?image=9'),
  //       tag: ['drama', 'comedy']),
  //   Movies(
  //       title: 'Movie 10',
  //       color: Colors.teal,
  //       image: Image.network('https://picsum.photos/250?image=10'),
  //       tag: ['action', 'drama']),
  //   Movies(
  //       title: 'Movie 11',
  //       color: Colors.cyan,
  //       image: Image.network('https://picsum.photos/250?image=11'),
  //       tag: ['action']),
  //   Movies(
  //       title: 'Movie 12',
  //       color: Colors.indigo,
  //       image: Image.network('https://picsum.photos/250?image=12'),
  //       tag: ['drama', 'comedy']),
  // ];
  // }
  late Future<List<Movies>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = _getMovies();
  }

  final data = AuthStore();
  final String title = 'Movie list';
  String searchMovie = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          setState(() => searchMovie = text);
        },
        appBarBuilder: (context) {
          return AppBar(
            title: Text(title),
            actions: const [
              AppBarSearchButton(),
            ],
          );
        },
      ),
      body: FutureBuilder<List<Movies>>(
        future: _movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildGridView(snapshot.data!);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const formMovie()));
          }),
    );
  }

  Widget _buildGridView(List<Movies> movies) {
    return GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1,
      children: movies
          .where((Movies movie) =>
              movie.title.toLowerCase().contains(searchMovie) ||
              movie.category.contains(searchMovie))
          .toList()
          .map((movie) {
        return CardMovie(
          movie: movie,
        );
      }).toList(),
    );
  }
}
