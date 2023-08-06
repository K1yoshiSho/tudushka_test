import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tudushka/src/common/components/create_todo.dart';
import 'package:tudushka/src/features/home/bloc/home_bloc.dart';
import 'package:tudushka/src/features/home/presentation/components/detailed_todo_card.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';

import 'package:tudushka/src/services/persistence/isar.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class DetailedTodoScreen extends StatefulWidget {
  final Todo todo;
  final Function() onDelete;

  static const String name = 'Detailed todo';
  static const String routeName = 'todo';

  static const String paramTodo = 'todo';
  static const String paramOnDelete = 'onDelete';

  const DetailedTodoScreen({super.key, required this.onDelete, required this.todo});

  @override
  State<DetailedTodoScreen> createState() => _DetailedTodoScreenState();
}

class _DetailedTodoScreenState extends State<DetailedTodoScreen> {
  final HomeBloc _homeBloc = HomeBloc();
  @override
  void initState() {
    _homeBloc.add(GetSingleTodo(
      widget.todo.isarId,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit_rounded, color: AppColors.accent500),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: CreateTodoSheet(
                          onEdit: true,
                          todo: widget.todo,
                          title: "Изменить заметку",
                          onEditFunction: () {
                            _homeBloc.add(GetSingleTodo(
                              widget.todo.isarId,
                            ));
                          },
                        ),
                      );
                    },
                  ).then((value) => _homeBloc.add(GetSingleTodo(widget.todo.isarId)));
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.dangerColor,
                ),
                onPressed: () {
                  IsarService()
                      .deleteAtId(
                    id: widget.todo.isarId,
                  )
                      .then((value) {
                    widget.onDelete();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is SignleTodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is HomeError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      state.message,
                      maxLines: 5,
                      style: AppTextStyle.bodyMedium500(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is SingleTodoLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DetailedTodoCard(
                  todo: state.todo!,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
