import 'dart:async';

import 'package:fam_flutter_xp/data/api/tmdb_api.dart';
import 'package:fam_flutter_xp/data/model/movies_response.dart';
import 'package:fam_flutter_xp/home/home_event.dart';
import 'package:fam_flutter_xp/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// - Traditional way of calling parent's constructor
// HomeBloc(HomeState initialState) : super(initialState)
//----------------------------------------------------------
// - Short Dart way of calling the same
// HomeBloc(super.initialState);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // Bloc constructor
  HomeBloc() : super(Loading()) {
    // Passed initial ui state i.e. HomeState
    on<InitialFetchEvent>(_getMoviesData);
    on<ShowNativeToastClickEvent>(_onShowNativeToastClick);
  }

  Future<void> _getMoviesData(
      InitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(Loading());
    await Future.delayed(const Duration(seconds: 5));
    List<Movie?>? movies = await TMDbAPI().fetchTrendingMovies();
    emit(Success(data: movies));
  }

  _onShowNativeToastClick(
      ShowNativeToastClickEvent event, Emitter<HomeState> emit) {
    emit(ShowNativeToast(event.msg));
  }
}
