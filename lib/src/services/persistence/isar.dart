import 'package:isar/isar.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';

abstract class IsarRepository {
  Future<Isar> init();
  Future<void> deleteAll();
  Future<void> deleteAtId({required int id});
  Future<void> insertTodo({required Todo todo});
  Future<List<Todo>> getAllTodos();
  Future<Todo?> getSingleTodo({required int id});
  Future<bool> editTodo({required Todo todo});
}

class IsarService implements IsarRepository {
  @override
  Future<Isar> init() async {
    final isar = await initIsar();
    return isar;
  }

  @override
  Future<void> deleteAll() async {
    final isar = await IsarService().init();
    await isar.writeTxn(() async {
      await isar.todos.filter().titleIsNotNull().deleteAll();
    }).then((value) {
      isar.close();
    });
  }

  @override
  Future<void> deleteAtId({required int id}) async {
    final isar = await IsarService().init();
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    }).then((value) {
      isar.close();
    });
  }

  @override
  Future<void> insertTodo({required Todo todo}) async {
    final isar = await IsarService().init();
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    }).then((value) {
      isar.close();
    });
  }

  @override
  Future<List<Todo>> getAllTodos({bool? reverse, int? category}) async {
    final List<Todo> todos = [];
    final isar = await IsarService().init();
    await isar.writeTxn(() async {
      if (reverse != null && reverse == true) {
        todos.addAll(await isar.todos.where().sortByCreatedAtDesc().findAll());
      } else {
        if (category != null) {
          todos.addAll(await isar.todos.filter().categoryEqualTo(category).findAll());
        } else {
          todos.addAll(await isar.todos.where().findAll());
        }
      }
    }).then((value) {
      isar.close();
      return todos;
    });
    return todos;
  }

  @override
  Future<Todo?> getSingleTodo({required int id}) async {
    Todo? todo;

    final isar = await IsarService().init();
    await isar.writeTxn(() async {
      todo = await isar.todos.where().isarIdEqualTo(id).findFirst();
    }).then((value) {
      isar.close();
      return todo;
    });
    return todo;
  }

  @override
  Future<bool> editTodo({required Todo todo}) async {
    final isar = await IsarService().init();
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    }).then((value) {
      isar.close();
      return true;
    });
    return false;
  }
}

@override
Future<Isar> initIsar() async {
  final isar = await Isar.open(
    [TodoSchema],
    directory: (await getApplicationDocumentsDirectory()).path,
  );
  return isar;
}
