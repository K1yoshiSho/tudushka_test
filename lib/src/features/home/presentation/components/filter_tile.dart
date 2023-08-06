import 'package:flutter/material.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class FilterTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  final IconData icon;
  const FilterTile({super.key, required this.onTap, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: AppColors.gray300),
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        selected: false,
        dense: true,
        splashColor: AppColors.splashColor,
        onTap: () => onTap(),
        title: Text(
          title,
          style: AppTextStyle.bodyMedium500(context),
        ),
        leading: Icon(icon),
      ),
    );
  }
}
