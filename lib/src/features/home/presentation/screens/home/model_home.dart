// ignore_for_file: unused_field, cancel_subscriptions, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:tudushka/src/features/home/bloc/home_bloc.dart';
import 'package:tudushka/src/services/app_model.dart';

/// [HomeScreenModel] - model for `HomeScreen`, where init and dispose fields.
class HomeScreenModel extends AppModel {
  late final HomeBloc homeBloc;
  bool isReversed = false;
  String filterCategory = "Все";
  @override
  void initState(BuildContext context) {
    homeBloc = HomeBloc();
  }

  @override
  void dispose() {
    homeBloc.close();
  }
}
