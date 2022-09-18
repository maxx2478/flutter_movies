import 'package:dio/dio.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/services/http_service.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late HTTPService httpService;

  MovieService() {
    httpService = getIt.get<HTTPService>();
  }

  //future -> we will it in future
  Future<List<Movie>?> getPopularMovies({required int page}) async {
    Response? response = await httpService.get('/movie/popular', query: {
      'page': page,
    });

    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't load the data");
    }
  }

  Future<List<Movie>?> getUpcomingMovies({required int page}) async {
    Response? response = await httpService.get('/movie/upcoming', query: {
      'page': page,
    });

    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't load the data");
    }
  }

  Future<List<Movie>?> searchMovies(String searchText,
      {required int page}) async {
    Response? response = await httpService.get('/search/movie', query: {
      'query': searchText
    });

    if (response?.statusCode == 200) {
      Map data = response?.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      print(response?.toString());
      throw Exception("Couldn't find any suitable matches");
    }
  }
}
