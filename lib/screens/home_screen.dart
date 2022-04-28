import 'package:flutter/material.dart';
import 'package:flutter_movie_app/providers/movies_provider.dart';
import 'package:flutter_movie_app/widgets/movie_horizontal_slider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movie_app/models/movie.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Provider
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Popular',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieVerticalSlider(
              movies: moviesProvider.lstPopularMovies,
              onNextPage: () => {
                moviesProvider.getOnDisplayPopularMovies(),
              }, //populars
            ),
          ],
        ),
      )
    );
  }
}