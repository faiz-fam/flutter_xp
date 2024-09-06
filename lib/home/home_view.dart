import 'dart:convert';

import 'package:fam_flutter_xp/data/api/tmdb_api.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../data/model/movies_response.dart';
import '../details/details_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  List<Movie?>? movies;

  @override
  void initState() {
    super.initState();
    // This gets called when widget state is initialised
    // could be initial triggering point of bloc's (viewmodel) first action
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "FamFlutter XP",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: const Color(0xff121212),
        ),
        backgroundColor: const Color(0xff121212),
        body: movieListView());
  }

  Widget movieListView() {
    if (movies == null || movies!.isEmpty) {
      return Center(
        child: Container(
          color: const Color(0xff121212),
          child: const CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      );
    } else {
      return Container(
        color: const Color(0xff121212),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 16,
              childAspectRatio: 0.7),
          itemCount: movies!.length,
          itemBuilder: (BuildContext context, int index) {
            String posterURL =
                "https://image.tmdb.org/t/p/w342/${movies![index]?.posterPath}";
            String? movieTitle = movies![index]?.title;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsView(
                            movieTitle: movieTitle,
                            moviePosterUrl: posterURL)));
              },
              child: Hero(
                tag: posterURL,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(fit: BoxFit.fill, posterURL),
                ),
              ),
            );
          },
        ),
      );
    }
  }

  getMovies() async {
    var movies = await TMDbAPI().fetchTrendingMovies();
    loadData(movies);
  }

  void loadData(List<Movie?>? movies) {
    setState(() {
      this.movies = movies;
    });
  }
}
