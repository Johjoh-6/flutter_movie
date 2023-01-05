import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_list/movie/movie_type.dart';

class CardMovie extends StatelessWidget {
  final Movies movie;
  const CardMovie({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(movie.title),
                ),
                body: Center(
                    child: Column(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: movie.image.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(movie.title,
                      style: TextStyle(
                          fontSize: 40,
                          color: movie.color,
                          fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: movie.category
                        .map((tag) => Chip(
                              label: Text(tag),
                            ))
                        .toList(),
                  ),
                ])),
              );
            },
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: movie.image.image,
                  fit: BoxFit.cover,
                )),
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(movie.title,
                        style: TextStyle(fontSize: 20, color: movie.color)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: movie.category
                          .map((tag) => Container(
                                margin: const EdgeInsets.only(right: 3),
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(tag,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black)),
                              ))
                          .toList(),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
