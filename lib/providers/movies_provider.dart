import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/genre_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/models/genre.dart';
import 'package:flutter_movie_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl  = 'api.themoviedb.org';
  String _apiKey   = '73da5365805b1e9d24ce772c8f0ec067';
  String _language = 'en-US';

  List<Movie> lstPopularMovies = [];
  List<Genre> lstGenre= [];
  int _popularPage = 0;

  MoviesProvider() {
    this.getOnDisplayPopularMovies();
  }

  Future<String> _getJsonData(String segmentUrl, [int page=1]) async {
    final url = Uri.https(this._baseUrl, segmentUrl, {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '$page',
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayPopularMovies() async {

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    this.lstPopularMovies = [...lstPopularMovies, ...popularResponse.results];
    await getMovieGenres();
    for(var i = 0; i < lstPopularMovies.length; i++){
      for(var j = 0; j < lstPopularMovies[i].genreIds.length; j++){
        Genre? movieGenre = lstGenre.firstWhere((element) => element.id == lstPopularMovies[i].genreIds[j], orElse: ()=> new Genre(id: 0,name: ""));
        if (movieGenre.id > 0) {
          lstPopularMovies[i].genre += movieGenre.name + ", ";
        }
      }
      if (lstPopularMovies[i].genre.length > 0) {
        lstPopularMovies[i].genre = lstPopularMovies[i].genre.substring(0, lstPopularMovies[i].genre.length - 2);
      }
    }

    notifyListeners();
  }
  
  getMovieGenres() async{
    final jsonData = await this._getJsonData('3/genre/movie/list');
    final genreResponse = GenreResponse.fromJson(jsonData);
    this.lstGenre = genreResponse.genres;
  }
}