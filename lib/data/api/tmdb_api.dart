
import 'dart:convert';
import 'dart:io';

import 'package:fam_flutter_xp/data/model/movies_response.dart';
import 'package:http/http.dart' as http;
class TMDbAPI {
  String apiKey = "108032cb03f88ea772a16969778071ae";

  String accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMDgwMzJjYjAzZjg4ZWE3NzJhMTY5Njk3NzgwNzFhZSIsIm5iZiI6MTcyNTEwMjQyNy44NDc5MDcsInN1YiI6IjYxMDhjYmY4Zjk2YTM5MDAzMDMxYzg2YSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Dqs43ZBf1AF69gMuZAZsGj1jIWMUNmSkhqzovfn0ZZ8";

// https://api.themoviedb.org/3/trending/movie/{time_window}
// path: time_window | values: day/week
// query param: language | value: en-US
// addHeader("Authorization", "Bearer eyJhbGciOiJIU"


  var httpClient = http.Client();

  Future<List<Movie?>?> fetchTrendingMovies() async {
    String url =
        "https://api.themoviedb.org/3/trending/movie/week?language=en-US&api_key=108032cb03f88ea772a16969778071ae";

    Uri uri = Uri.parse(url);
    var response = await httpClient.get(uri);
    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var moviesResponse = MoviesResponse.fromJson(jsonData);
      return moviesResponse.results;
    } else {
      // exceptions
    }
  }
}


//     const val TMDB_POSTER_IMAGE_BASE_URL_W342 =
//         "https://image.tmdb.org/t/p/w342/"
//     const val TMDB_IMAGE_BASE_URL_W500 =
//         "https://image.tmdb.org/t/p/w500/" // poster_path = 8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg   || w342
//     const val TMDB_IMAGE_BASE_URL_W780 = "https://image.tmdb.org/t/p/w780/"