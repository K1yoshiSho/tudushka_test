import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tudushka/src/features/home/bloc/home_bloc.dart';
import 'package:tudushka/src/services/get_it.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';
import 'package:tudushka/src/services/persistence/isar.dart';

/// [HomeRepository] - This class contains methods for getting todos.
abstract class HomeRepository {
  /// [getTodos] - This method used for get all todos.
  getTodos(GetTodos event, Emitter<HomeState> emit);

  /// [getSingleTodo] - This method used for get single todo.
  getSingleTodo(GetSingleTodo event, Emitter<HomeState> emit);
}

class HomeRepositoryImp implements HomeRepository {
  @override
  Future<void> getTodos(GetTodos event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());

      List<Todo> todos = [];

      if (event.reverse != null && event.reverse == true) {
        todos.addAll(await IsarService().getAllTodos(reverse: event.reverse));
      } else {
        if (event.category != null && event.category != -1) {
          todos.addAll(await IsarService().getAllTodos(category: event.category));
        } else {
          todos.addAll(await IsarService().getAllTodos());
        }
      }

      emit(HomeLoaded(todos));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(HomeError(e.toString()));
    }
  }

  @override
  Future<void> getSingleTodo(GetSingleTodo event, Emitter<HomeState> emit) async {
    try {
      emit(SignleTodoLoading());

      Todo? todo;
      todo = await IsarService().getSingleTodo(id: event.id);

      emit(SingleTodoLoaded(todo: todo));
    } catch (e, st) {
      getIt<Talker>().handle(e, st);
      emit(HomeError(e.toString()));
    }
  }
}
