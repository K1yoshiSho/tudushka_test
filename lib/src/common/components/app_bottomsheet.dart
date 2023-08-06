import 'package:flutter/material.dart';
import 'package:tudushka/src/common/components/bottomsheet_header.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

/// `AppBottomSheet` is a custom BottomSheet with customizable fields.
class AppBottomSheet extends StatelessWidget {
  final Widget body;
  final String title;
  final double? height;

  const AppBottomSheet({
    super.key,
    required this.body,
    this.height,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Material(
      color: Colors.transparent,
      elevation: 5.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: height ?? screenSize.height * 0.55,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 12),
              child: BottomSheetHeaderContainer(),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0, top: 10.0, end: 16.0, bottom: 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: AppTextStyle.bodyMedium600(context).copyWith(
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.cancel_outlined,
                      size: 20,
                      color: AppColors.gray600,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0, top: 4.0, end: 16.0, bottom: 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Divider(
                    color: AppColors.gray200,
                    height: 1.0,
                    thickness: 2,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return body;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
