import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/screens/banner_detail.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Movie detail',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body:SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BannerDetail(
                fullBackdropPath: movie.fullBackdropPath,
                fullPosterPath: movie.fullPosterPath,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 5, horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    CircularPercentIndicator(
                      radius: 20.0,
                      animation: true,
                      animationDuration: 1200,
                      lineWidth: 5,
                      percent: movie.voteAverage / 10,
                      center: Text(
                        '${movie.voteAverage}',
                        style: TextStyle(fontSize: 15),
                      ),
                      circularStrokeCap: CircularStrokeCap.butt,
                      backgroundColor: Colors.grey,
                      progressColor: Colors.black,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),

              SizedBox(
                width: double.infinity,
                height: 80,
                child: Row(
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.commentDots ,
                            color: Colors.orange,
                          ),
                        ),
                        Text('Reviews', style: TextStyle(fontSize: 16))
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: double.infinity,
                      width: 1.5,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.grey),
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.circlePlay,
                            color: Colors.orange,
                          ),
                        ),
                        Text('Trailers', style: TextStyle(fontSize: 16))
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Genre',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          movie.genre,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Spacer(),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          'Release',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          movie.releaseDate ?? "No information",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Divider(thickness: 2),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  movie.overview,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
