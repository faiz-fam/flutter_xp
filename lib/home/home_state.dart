import '../data/model/movies_response.dart';

sealed class HomeState {}

class Loading extends HomeState {}

class Error extends HomeState {
  String? errorMsg;

  Error(this.errorMsg);
}

class Success extends HomeState {
  List<Movie?>? data;

  Success({required this.data});
}

// Action states
sealed class HomeViewActionState extends HomeState {}

class ShowNativeToast extends HomeViewActionState {
  String? msg;

  ShowNativeToast(this.msg);
}
