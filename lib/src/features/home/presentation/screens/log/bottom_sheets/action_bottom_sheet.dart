import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tudushka/src/common/components/app_bottomsheet.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class TalkerActionsBottomSheetW extends StatelessWidget {
  const TalkerActionsBottomSheetW({
    Key? key,
    required this.talkerScreenTheme,
    required this.actions,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;
  final List actions;

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      title: 'Фильтр',
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...actions
                .map(
                  (e) => _ActionTile(
                    talkerScreenTheme: talkerScreenTheme,
                    action: e,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    Key? key,
    required this.action,
    required this.talkerScreenTheme,
  }) : super(key: key);

  final TalkerActionItem action;
  final TalkerScreenTheme talkerScreenTheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.transparent,
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
          onTap: () {
            Navigator.pop(context);
            action.onTap();
          },
          title: Text(
            action.title,
            style: AppTextStyle.bodyMedium500(context),
          ),
          leading: Icon(action.icon, color: talkerScreenTheme.textColor),
        ),
      ),
    );
  }
}

class TalkerActionItem {
  const TalkerActionItem({
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
}
