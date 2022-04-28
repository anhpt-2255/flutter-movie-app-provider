import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/movie.dart';

class MovieVerticalSlider extends StatefulWidget {

  final List<Movie> movies;
  final Function onNextPage;

  const MovieVerticalSlider({
    required this.movies,
    required this.onNextPage,
  });

  @override
  _MovieHorizontalSliderState createState() => _MovieHorizontalSliderState();
}

class _MovieHorizontalSliderState extends State<MovieVerticalSlider> {

  bool _getMoreData = false;
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final int pixelPosition = scrollController.position.pixels.toInt();
      final int maxScroll     = scrollController.position.maxScrollExtent.toInt();
      final int result = (maxScroll~/2).toInt();

      if(pixelPosition == result) {
        _getMoreData = true;
        if(_getMoreData) {
          this.widget.onNextPage();
        }
      }else {
        _getMoreData = false;
        if(!_getMoreData && pixelPosition == maxScroll) {
          this.widget.onNextPage();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height ,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: this.widget.movies.length,
              itemBuilder: ( _, int index) => _MovieCard(
                this.widget.movies[index]
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {

  final Movie movie;

  const _MovieCard(
    this.movie,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 185,
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal:10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Row(
              children: [
                SizedBox(width: 15),
                FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterPath),
                  fit: BoxFit.fill,
                  width: 120,
                  height: 180,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(fontSize: 22),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10),
                      Text(
                        movie.overview,
                        maxLines: 8,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}