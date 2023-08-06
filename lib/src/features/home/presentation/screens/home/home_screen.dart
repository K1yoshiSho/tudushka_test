import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tudushka/src/common/components/app_bottomsheet.dart';
import 'package:tudushka/src/common/components/create_todo.dart';
import 'package:tudushka/src/common/utils/utils.dart';
import 'package:tudushka/src/features/home/bloc/home_bloc.dart';
import 'package:tudushka/src/features/home/presentation/components/filter_drop_down.dart';
import 'package:tudushka/src/features/home/presentation/components/filter_tile.dart';
import 'package:tudushka/src/features/home/presentation/components/todo_card.dart';
import 'package:tudushka/src/features/home/presentation/screens/home/model_home.dart';
import 'package:tudushka/src/features/home/presentation/screens/log/talker_screen.dart';
import 'package:tudushka/src/services/app_model.dart';
import 'package:tudushka/src/services/get_it.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';
import 'package:tudushka/src/services/persistence/isar.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String name = 'Home';
  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeScreenModel _homeScreenModel;

  @override
  void initState() {
    _homeScreenModel = createModel(context, () => HomeScreenModel());
    FlutterNativeSplash.remove();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _homeScreenModel.homeBloc.add(
        GetTodos(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Tudushka'),
        leading: IconButton(
          icon: const Icon(Icons.monitor_heart_rounded, color: AppColors.accent500),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TudushkaLogScreen(
                  talker: getIt<Talker>(),
                  appBarTitle: "Tudushka logs",
                  theme: const TalkerScreenTheme(
                    backgroundColor: AppColors.accent100,
                    textColor: AppColors.abyssColor,
                  ),
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.accent500),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, state) {
                      return AppBottomSheet(
                        title: 'Фильтр',
                        body: Column(
                          children: [
                            const SizedBox(height: 16),
                            FilterTile(
                              title: 'Изменить порядок',
                              onTap: () {
                                Navigator.pop(context);
                                if (_homeScreenModel.isReversed) {
                                  _homeScreenModel.homeBloc.add(GetTodos());
                                } else {
                                  _homeScreenModel.homeBloc.add(GetTodos(reverse: true));
                                }
                                setState(() {
                                  _homeScreenModel.isReversed = !_homeScreenModel.isReversed;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            FilterDropDown(
                              options: const ['Важные', 'Срочные', 'Обычные', 'Все'],
                              dropDownValue: _homeScreenModel.filterCategory,
                              hintText: "Выберите категорию",
                              onChanged: (val) {
                                setState(() {
                                  _homeScreenModel.filterCategory = val ?? "";
                                });
                                state.call(() {});
                                Navigator.pop(context);
                                _homeScreenModel.homeBloc
                                    .add(GetTodos(category: getCategoryFromString(category: val ?? "")));
                              },
                            ),
                            const SizedBox(height: 16),
                            FilterTile(
                              title: 'Очистить заметки',
                              onTap: () {
                                Navigator.pop(context);
                                IsarService().deleteAll();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          BlocBuilder<HomeBloc, HomeState>(
            bloc: _homeScreenModel.homeBloc,
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeLoaded) {
                return Expanded(
                  child: Visibility(
                    replacement: const Center(child: Text("Нет заметок")),
                    visible: state.todos.isNotEmpty,
                    child: ListView.builder(
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) {
                        final Todo todo = state.todos[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                          child: TodoCard(todo: todo, homeBloc: _homeScreenModel.homeBloc),
                        );
                      },
                    ),
                  ),
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

              return const Center(
                child: Text('Нет заметок'),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: CreateTodoSheet(
                  onEdit: false,
                  todo: null,
                  title: 'Создать заметку',
                  onEditFunction: () {},
                ),
              );
            },
          ).then((value) => _homeScreenModel.homeBloc.add(GetTodos()));
        },
        tooltip: 'Создать заметку',
        child: const Icon(Icons.add),
      ),
    );
  }
}
