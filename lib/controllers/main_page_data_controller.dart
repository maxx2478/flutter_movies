import 'package:flutter/foundation.dart';
import 'package:flutter_movies/models/main_page_data.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/models/search_cats.dart';
import 'package:flutter_movies/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  //create constructor with state (optional (inside square bracket))
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final MovieService movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie>? movies = [];

      if (state.searchText.isEmpty) {
        if (state.searchCategory == SearchCats.popular) {
          movies = await movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCats.upcoming) {
          movies = await movieService.getUpcomingMovies(page: state.page);
        } else if (state.searchCategory == SearchCats.none) {
          movies = [];
        }
      } else {
        //perform search
        movies = await movieService.searchMovies(state.searchText, page: state.page);
      }

      state = state.copyWith(
        movies: [...state.movies, ...?movies],
        page: state.page + 1,
      );
    } catch (e) {}
  }

  void updateSearchCategory(String category) {
    try {
      state = state.copyWith(
          movies: [], page: 1, searchCategory: category, searchText: "");
      getMovies();
    } catch (e) {}
  }

  void searchMovies(String searchText1) {
    try {
      state = state.copyWith(
          movies: [],
          page: 1,
          searchCategory: SearchCats.none,
          searchText: searchText1);
      getMovies();
    } catch (e) {}
  }
}
