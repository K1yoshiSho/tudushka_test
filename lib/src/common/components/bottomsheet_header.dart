

import 'package:flutter/material.dart';
import 'package:tudushka/src/theme/app_colors.dart';

/// `BottomSheetHeaderContainer` - This widget is used to display the header of the bottom sheet.

class BottomSheetHeaderContainer extends StatelessWidget {
  const BottomSheetHeaderContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 4.0,
      decoration: BoxDecoration(
        color: AppColors.gray300,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
