import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_movies/controllers/main_page_data_controller.dart';
import 'package:flutter_movies/models/main_page_data.dart';
import 'package:flutter_movies/models/movie.dart';
import 'package:flutter_movies/models/search_cats.dart';
import 'package:flutter_movies/widgets/movie_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController>(
        (ref) => MainPageDataController());

/*class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}*/

class HomePage extends ConsumerWidget {
  late double rootHeight;
  late double rootWidth;

  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;

  late TextEditingController _searchTextController;
  String dropdownValue = "Popular";

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    rootHeight = MediaQuery.of(context).size.height;
    rootWidth = MediaQuery.of(context).size.width;



    _mainPageDataController = watch(mainPageDataControllerProvider);
    _mainPageData = watch(mainPageDataControllerProvider.state);


    _searchTextController = TextEditingController();



    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: rootHeight,
        width: rootWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [_backgroundWidget(), foregroundWidget()],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: rootHeight,
      width: rootWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
              fit: BoxFit.cover,
              image:
                  NetworkImage('https://wallpaperaccess.com/full/187161.jpg'))),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)))),
    );
  }

  Widget foregroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, rootHeight * 0.02, 0, 0),
      width: rootWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Container(
            height: rootHeight * 0.83,
            child: _movieListWidget(),
          )
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 25, 10, 10),
      height: rootHeight * 0.07,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_searchFieldWidget(), _categoriesWidget()],
      ),
    );
  }

  Widget _searchFieldWidget() {
    return SizedBox(
      width: rootWidth * 0.55,
      height: rootHeight * 0.05,
      child: TextField(
        controller: _searchTextController,
        onSubmitted: (input) {},
        style: const TextStyle(color: Colors.white),
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: 7),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white24,
            ),
            hintStyle: TextStyle(color: Colors.white54),
            filled: false,
            hintText: "Search"),
      ),
    );
  }

  Widget _categoriesWidget() {
    var filters = ['Popular', 'Upcoming', 'None'];

    return DropdownButton(
      items: filters.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(color: Colors.white24),
          ),
        );
      }).toList(),
      dropdownColor: Colors.black38,
      value: dropdownValue,
      icon: const Padding(
        padding: EdgeInsets.all(6.0),
        child: Icon(
          Icons.menu,
          color: Colors.white24,
        ),
      ),
      underline: Container(
        height: 0.5,
        color: Colors.white24,
      ),
      onChanged: (value) {

        dropdownValue = value as String;

      },
    );
  }

  Widget _movieListWidget() {
    final List<Movie> _movies = _mainPageData.movies;

    /*for (var i = 0; i < 20; i++) {
      _movies.add(Movie(
          name: "Hare Krsna",
          language: "En",
          isAdult: false,
          description: "Hare Krsna Hare Krsna",
          posterPath:
              "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/covid-19-corona-virus-prevention-poster-design-template-7eafeb97181606ad03bbe2e56324593c_screen.jpg?ts=1637005703",
          backdropPath: "dsgfrg",
          rating: 7.86,
          releaseDate: "2020"));
    }*/

    if (_movies.isNotEmpty) {
      return ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (BuildContext context, int count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: rootHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {
                  print(count.toString());
                },
                child: MovieTile(
                  movie: _movies[count],
                  height: rootHeight * 0.20,
                  width: rootWidth,
                ),
              ),
            );
          });
    } else {
      return const Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ));
    }
  }
}
