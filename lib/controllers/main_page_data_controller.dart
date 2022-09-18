import 'package:flutter_movies/models/main_page_data.dart';
import 'package:flutter_movies/models/movie.dart';
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
    try{
      List<Movie>? movies = [];
      movies = await movieService.getPopularMovies(page: state.page);
    }
    catch(e){
    }
  }


}
