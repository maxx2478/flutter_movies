import 'package:flutter/material.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:get_it/get_it.dart';

class MovieTile extends StatelessWidget {
  final GetIt getIt = GetIt.instance;

  late final double height;
  late final double width;
  late final Movie movie;

  MovieTile({required this.height, required this.width, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [moviePosterWidget(movie.posterPath), movieInfoWidget()],
      ),
    );
  }

  Widget moviePosterWidget(String posterPath) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(posterPath))),
    );
  }

  movieInfoWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),

      height: height,
      width: width * 0.65,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(

            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.48,
                child: Text(
                  movie.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                movie.rating.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              '${movie.language.toUpperCase()} | R: ${movie.rating} | ${movie.releaseDate}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 10),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
            child: Text(
              '${movie.description}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
