import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tudushka/src/features/home/presentation/screens/log/base_card.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

class TalkerMonitorCardW extends StatelessWidget {
  const TalkerMonitorCardW({
    Key? key,
    required this.logs,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    required this.color,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final List<TalkerDataInterface> logs;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TalkerBaseCardW(
        color: color,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: color,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: AppTextStyle.bodyMedium400(context),
                          ),
                        if (subtitleWidget != null) subtitleWidget!
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null) Icon(Icons.arrow_forward_ios_rounded, color: color),
          ],
        ),
      ),
    );
  }
}
