part of 'home_bloc.dart';

abstract class HomeEvent {}

class GetTodos extends HomeEvent {
  final bool? reverse;
  final int? category;
  GetTodos({
    this.reverse,
    this.category,
  });
}

class GetSingleTodo extends HomeEvent {
  final int id;
  GetSingleTodo(this.id);
}
