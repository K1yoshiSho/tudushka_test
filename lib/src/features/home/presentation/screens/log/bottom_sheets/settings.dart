// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:tudushka/src/common/components/app_bottomsheet.dart';
import 'package:tudushka/src/features/home/presentation/screens/log/settings_card.dart';

class TalkerSettingsBottomSheetW extends StatefulWidget {
  const TalkerSettingsBottomSheetW({
    Key? key,
    required this.talkerScreenTheme,
    required this.talker,
  }) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final ValueNotifier<Talker> talker;

  @override
  State<TalkerSettingsBottomSheetW> createState() => _TalkerSettingsBottomSheetWState();
}

class _TalkerSettingsBottomSheetWState extends State<TalkerSettingsBottomSheetW> {
  @override
  void initState() {
    widget.talker.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settings = [
      TalkerSettingsCardW(
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Логирование',
        enabled: widget.talker.value.settings.enabled,
        onChanged: (enabled) {
          (enabled ? widget.talker.value.enable : widget.talker.value.disable).call();
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCardW(
        canEdit: widget.talker.value.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Логировать в консоли',
        enabled: widget.talker.value.settings.useConsoleLogs,
        onChanged: (enabled) {
          widget.talker.value.configure(
            settings: widget.talker.value.settings.copyWith(
              useConsoleLogs: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCardW(
        canEdit: widget.talker.value.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Использовать историю',
        enabled: widget.talker.value.settings.useHistory,
        onChanged: (enabled) {
          widget.talker.value.configure(
            settings: widget.talker.value.settings.copyWith(
              useHistory: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
    ];

    return AppBottomSheet(
      title: 'Настройки',
      body: Column(
        children: [
          ...settings.map((e) => SizedBox(child: e)),
        ],
      ),
    );
  }
}
