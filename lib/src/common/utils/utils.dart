import 'package:flutter/material.dart';

getColorFromCategory({required int id}) {
  return switch (id) {
    1 => Colors.red,
    2 => Colors.orange,
    _ => Colors.grey,
  };
}

getCategoryFromString({required String category}) {
  return switch (category) {
    "Важные" => 1,
    "Срочные" => 2,
    "Все" => -1,
    _ => 0,
  };
}

getCategoryNameFromId({required int id}) {
  return switch (id) {
    1 => "Важные",
    2 => "Срочные",
    -1 => "Все",
    _ => "Обычные",
  };
}
