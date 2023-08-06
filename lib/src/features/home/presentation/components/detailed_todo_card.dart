import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tudushka/src/common/utils/utils.dart';
import 'package:tudushka/src/services/persistence/collections/todo.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class DetailedTodoCard extends StatelessWidget {
  final Todo todo;
  const DetailedTodoCard({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: getColorFromCategory(id: todo.category!),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Категория: «${getCategoryNameFromId(id: todo.category ?? 0)}»",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodyMedium500(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Заголовок: ${todo.title!}",
              style: AppTextStyle.bodyMedium500(context),
            ),
            const SizedBox(height: 8),
            Text(
              "Описание: ${todo.description ?? "Нет описания"}",
              style: AppTextStyle.labelLarge400(context),
            ),
            if (todo.deadline != null)
              Column(
                children: [
                  const SizedBox(height: 8),
                  Text(
                    "Сроки: ${DateFormat('dd.MM.yyyy HH:mm').format(todo.deadline!)}",
                    style: AppTextStyle.labelLarge400(context),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
