import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tudushka/src/features/home/resource/home_repository.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepositoryImp _homeRepositoryImp = HomeRepositoryImp();
  HomeBloc() : super(HomeInitial()) {
    on<GetTodos>(_homeRepositoryImp.getTodos);
    on<GetSingleTodo>(_homeRepositoryImp.getSingleTodo);
  }
}
