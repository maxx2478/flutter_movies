import 'package:flutter_movies/models/search_cats.dart';

import 'movie.dart';

class MainPageData {
  late final List<Movie> movies;
  late final int page;
  late final String searchCategory;
  late final String searchText;

  MainPageData({required this.movies,
    required this.page,
    required this.searchCategory,
    required this.searchText});

  MainPageData.initial()
      : movies = [],
        page = 1,
        searchCategory = SearchCats.popular,
        searchText = "";

  MainPageData copyWith({List<Movie>? movies, int? page, String? searchCategory,
      String? searchText}) {
    return MainPageData(movies: movies?? this.movies,
        page: page?? this.page,
        searchCategory: searchCategory?? this.searchCategory,
        searchText: searchText?? this.searchText);

  }

}
