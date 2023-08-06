import 'package:flutter/material.dart';
import 'package:tudushka/src/common/components/textfield_outlined.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';
import 'package:tudushka/src/theme/app_theme.dart';

class DeadlinePicker extends StatelessWidget {
  final double? width;
  final TextEditingController controller;
  final Function() onRemove;
  final bool isRequired;
  final DateTime? initialDate;
  final Function() ifSelectedNull;
  final Function(DateTime) ifSelected;
  const DeadlinePicker({
    super.key,
    this.width,
    required this.controller,
    required this.onRemove,
    this.isRequired = false,
    this.initialDate,
    required this.ifSelectedNull,
    required this.ifSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.sizeOf(context).width * 0.6,
      child: OutlinedTextfield(
        hintText: "Выберите срок${isRequired ? " *" : ""}",
        textController: controller,
        readOnly: true,
        suffixIcon: (controller.text.isEmpty)
            ? const Icon(
                Icons.expand_more_rounded,
                color: AppColors.gray800,
                size: 18,
              )
            : IconButton(
                splashRadius: 20,
                style: AppStyles.iconButtonStyle,
                iconSize: 20,
                onPressed: () {
                  onRemove();
                },
                icon: const Icon(
                  Icons.cancel_outlined,
                  color: AppColors.gray600,
                  size: 19,
                ),
              ),
        validator: (value) {
          if (value!.isEmpty && isRequired) {
            return "Пожалуйста, выберите срок";
          }
          return null;
        },
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            initialEntryMode: DatePickerEntryMode.calendar,
            lastDate: DateTime.now().add(const Duration(days: 365 * 150)),
          ).then((dateValue) async {
            if (dateValue == null) {
            } else {
              await showTimePicker(
                context: context,
                initialEntryMode: TimePickerEntryMode.dialOnly,
                initialTime: TimeOfDay(hour: dateValue.hour, minute: dateValue.minute),
                builder: (context, child) {
                  return TimePickerTheme(
                    data: LightTheme.timePickerTheme.copyWith(
                      backgroundColor: AppColors.gray100,
                      elevation: 0,
                      dialBackgroundColor: Colors.white,
                    ),
                    child: child ?? const SizedBox(),
                  );
                },
              ).then(
                (timeValue) {
                  if (timeValue != null) {
                    ifSelected(DateTime(
                      dateValue.year,
                      dateValue.month,
                      dateValue.day,
                      timeValue.hour,
                      timeValue.minute,
                    ));
                    // setState(() {
                    // _createEventModel.deadlineDate = DateTime(
                    //   dateValue.year,
                    //   dateValue.month,
                    //   dateValue.day,
                    //   timeValue.hour,
                    //   timeValue.minute,
                    // );
                    //   _createEventModel.deadlineController.text = DateFormat('dd.MM.yyyy HH:mm').format(DateTime(
                    //     dateValue.year,
                    //     dateValue.month,
                    //     dateValue.day,
                    //     timeValue.hour,
                    //     timeValue.minute,
                    //   ));
                    // });
                  } else {
                    ifSelectedNull();
                    return null;
                  }
                },
              );
            }
          });
        },
        prefixIcon: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.calendar_today_outlined,
            size: 18,
          ),
        ),
      ),
    );
  }
}
