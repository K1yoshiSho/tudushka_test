part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class SignleTodoLoading extends HomeState {
  SignleTodoLoading();
}

class HomeLoaded extends HomeState {
  final List<Todo> todos;

  HomeLoaded(this.todos);
}

class SingleTodoLoaded extends HomeState {
  final Todo? todo;

  SingleTodoLoaded({required this.todo});
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
