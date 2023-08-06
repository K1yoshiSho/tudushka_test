import 'package:flutter/material.dart';
import 'package:tudushka/src/common/components/drop_down.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class FilterDropDown extends StatelessWidget {
  final Function(String?) onChanged;
  final String? dropDownValue;
  final String hintText;
  final List<String> options;
  const FilterDropDown(
      {super.key, required this.onChanged, required this.dropDownValue, required this.hintText, required this.options});

  @override
  Widget build(BuildContext context) {
    return CustomDropDown<String>(
      options: options,
      onChanged: (value) => onChanged(value),
      disabled: false,
      dropDownValue: dropDownValue,
      disabledTextStyle: AppTextStyle.labelLarge400(context).copyWith(
        color: AppColors.gray800,
        fontSize: 14,
      ),
      height: 55,
      textStyle: AppTextStyle.bodyMedium400(context).copyWith(
        overflow: TextOverflow.ellipsis,
      ),
      hintText: hintText,
      icon: const Icon(
        Icons.expand_more_rounded,
        color: AppColors.gray800,
        size: 18,
      ),
      elevation: 0,
      borderColor: AppColors.gray200,
      borderWidth: 1.5,
      borderRadius: 12,
      margin: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
      hidesUnderline: true,
    );
  }
}
