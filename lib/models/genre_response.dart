// To parse this JSON data, do
// final popularResponse = popularResponseFromMap(jsonString);

import 'dart:convert';
import 'package:flutter_movie_app/models/genre.dart';

class GenreResponse {
  GenreResponse({
      required this.genres,
    });

    List<Genre> genres;

    factory GenreResponse.fromJson(String str) => GenreResponse.fromMap(json.decode(str));

    factory GenreResponse.fromMap(Map<String, dynamic> json) => GenreResponse(
      genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
    );
}

