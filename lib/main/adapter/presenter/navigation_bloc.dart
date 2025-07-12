import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationItem> {
  NavigationBloc() : super(NavigationItem.basicConfiguration) {
    on<NavigationChangedEvent>((event, emit) => emit(event.item));
  }
}

sealed class NavigationEvent {}

class NavigationChangedEvent extends NavigationEvent {
  final NavigationItem item;

  NavigationChangedEvent(this.item);
}

enum NavigationItem {
  basicConfiguration,
  modConfiguration,
  serverProperties,
  about,
}
