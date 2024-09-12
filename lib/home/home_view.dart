import 'dart:convert';

import 'package:fam_flutter_xp/data/api/tmdb_api.dart';
import 'package:fam_flutter_xp/home/home_block.dart';
import 'package:fam_flutter_xp/home/home_event.dart';
import 'package:fam_flutter_xp/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  // static var platform = const MethodChannel("fam_app_channel");

  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    // This gets called when widget state is initialised
    // could be initial triggering point of bloc's (viewmodel) first action
    homeBloc.add(InitialFetchEvent());
    // homeBloc.add(ShowNativeToastClickEvent("Native Toast using Flutter Platform Channel"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      backgroundColor: const Color(0xff121212),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        buildWhen: (previous, current) {
          return current is! HomeViewActionState;
        },
        listenWhen: (previous, current) {
          return current is HomeViewActionState;
        },
        builder: (context, state) {
          return switch(state) {
            Loading() => renderLoadingUI(),
            Error() => renderErrorUI(state.errorMsg),
            Success() => renderContent(state.data),
            _ => renderErrorUI("Unexpected: builder's default case")
          };
        },
        listener: (context, state) {
          if (state is HomeViewActionState) {
            switch (state) {
              case ShowNativeToast():
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.msg ?? "Null msg")),
                );
            }
          }
        },
      ),
    );
  }

  Widget renderLoadingUI() {
    return Center(
      child: Container(
        color: const Color(0xff121212),
        child: const CircularProgressIndicator(
          color: Colors.amber,
        ),
      ),
    );
  }

  Widget renderContent(List<Movie?>? movies) {
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
              "https://image.tmdb.org/t/p/w342/${movies[index]?.posterPath}";
          String? movieTitle = movies[index]?.title;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsView(
                    movieTitle: movieTitle,
                    moviePosterUrl: posterURL,
                  ),
                ),
              );
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

  Widget renderErrorUI(String? errorMsg) {
    return Center(
      child: Text(
        errorMsg ?? "Something went wrong",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      title: Center(
        child: GestureDetector(
          onTap: () {
            homeBloc.add(ShowNativeToastClickEvent("Native Toast using Flutter platform channel (Pigeon)"));
          },
          child: const Text(
            "FamFlutter XP",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: const Color(0xff121212),
    );
  }

// getMovies() async {
//   var movies = await TMDbAPI().fetchTrendingMovies();
//
//   setState(() {
//     this.movies = movies;
//   });
// }

// Widget movieListView() {
//   if (movies == null || movies!.isEmpty) {
//     return Center(
//       child: Container(
//         color: const Color(0xff121212),
//         child: const CircularProgressIndicator(
//           color: Colors.amber,
//         ),
//       ),
//     );
//   } else {
//     return Container(
//       color: const Color(0xff121212),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 18,
//             mainAxisSpacing: 16,
//             childAspectRatio: 0.7),
//         itemCount: movies!.length,
//         itemBuilder: (BuildContext context, int index) {
//           String posterURL =
//               "https://image.tmdb.org/t/p/w342/${movies![index]?.posterPath}";
//           String? movieTitle = movies![index]?.title;
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => DetailsView(
//                           movieTitle: movieTitle,
//                           moviePosterUrl: posterURL)));
//             },
//             child: Hero(
//               tag: posterURL,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.network(fit: BoxFit.fill, posterURL),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
}
