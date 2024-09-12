sealed class HomeEvent {}

class InitialFetchEvent extends HomeEvent {}

class ShowNativeToastClickEvent extends HomeEvent {
  String? msg;

  ShowNativeToastClickEvent(this.msg);
}
