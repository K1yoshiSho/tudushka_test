import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tudushka/src/common/utils/utils.dart';
import 'package:tudushka/src/features/home/bloc/home_bloc.dart';
import 'package:tudushka/src/features/home/presentation/screens/detail_todo/detailed_todo.dart';
import 'package:tudushka/src/router/router.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';
import 'package:tudushka/src/services/persistence/isar.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todo,
    required HomeBloc homeBloc,
  }) : _homeBloc = homeBloc;

  final Todo todo;
  final HomeBloc _homeBloc;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 12, top: 4, bottom: 4, right: 0),
          title: Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: getColorFromCategory(id: todo.category!),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  todo.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.bodyMedium500(context),
                ),
              ),
            ],
          ),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Описание: ${(todo.description!.isNotEmpty) ? todo.description! : "Нет описания"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.labelMedium400(context),
                    ),
                  ),
                ],
              ),
              if (todo.deadline != null)
                Row(
                  children: [
                    Text(
                      "Сроки: ${DateFormat('dd.MM.yyyy HH:mm').format(todo.deadline!)}",
                      style: AppTextStyle.labelMedium400(context),
                    ),
                  ],
                ),
              const Divider(
                color: AppColors.gray200,
                height: 20,
                endIndent: 150,
                thickness: 1,
              ),
              Row(
                children: [
                  Text(
                    "Дата создания: ${DateFormat('dd.MM.yyyy HH:mm').format(todo.createdAt!)}",
                    style: AppTextStyle.labelMedium400(context),
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.dangerColor,
            ),
            onPressed: () {
              IsarService()
                  .deleteAtId(
                    id: todo.isarId,
                  )
                  .then((value) => _homeBloc.add(GetTodos()));
            },
          ),
          dense: true,
          onTap: () {
            context.pushNamed(DetailedTodoScreen.name, extra: {
              DetailedTodoScreen.paramTodo: todo,
              DetailedTodoScreen.paramOnDelete: () {
                _homeBloc.add(GetTodos());
              },
            }).then((value) => _homeBloc.add(GetTodos()));
          },
        ),
      ),
    );
  }
}
