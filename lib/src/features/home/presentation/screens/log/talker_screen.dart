// ignore_for_file: implementation_imports, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talker_flutter/src/controller/talker_view_controller.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:tudushka/src/common/components/textfield_outlined.dart';
import 'package:tudushka/src/features/home/presentation/screens/log/bottom_sheets/action_bottom_sheet.dart';
import 'package:tudushka/src/features/home/presentation/screens/log/bottom_sheets/settings.dart';
import 'package:tudushka/src/features/home/presentation/screens/log/data_card.dart';
import 'package:tudushka/src/features/home/presentation/screens/log/talker_monitor.dart';
import 'package:tudushka/src/theme/app_colors.dart';
import 'package:tudushka/src/theme/app_text_style.dart';

/// UI view for output of all Talker logs and errors
class TudushkaLogScreen extends StatefulWidget {
  const TudushkaLogScreen({
    Key? key,
    required this.talker,
    this.appBarTitle = 'Talker',
    this.theme = const TalkerScreenTheme(),
    this.itemsBuilder,
  }) : super(key: key);

  /// Talker implementation
  final Talker talker;

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme theme;

  /// Screen [AppBar] title
  final String appBarTitle;

  /// Optional Builder to customize
  /// log items cards in list
  final TalkerDataBuilder? itemsBuilder;

  @override
  State<TudushkaLogScreen> createState() => _WorkspaceTalkerScreenState();
}

class _WorkspaceTalkerScreenState extends State<TudushkaLogScreen> {
  final _controller = TalkerViewController();
  final _titilesController = GroupButtonController();

  @override
  Widget build(BuildContext context) {
    final talkerScreenTheme = widget.theme;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            floatingActionButton: FloatingActionButton(
              backgroundColor: theme.primaryColor,
              onPressed: () => _showActionsBottomSheet(context),
              child: const Icon(Icons.menu_rounded),
            ),
            body: TalkerBuilder(
              talker: widget.talker,
              builder: (context, data) {
                final filtredElements = data.where((e) => _controller.filter.filter(e)).toList();
                final titles = data.map((e) => e.title).toList();
                final unicTitles = titles.toSet().toList();
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: talkerScreenTheme.backgroundColor,
                      elevation: 0,
                      pinned: true,
                      floating: true,
                      expandedHeight: 180,
                      collapsedHeight: 60,
                      toolbarHeight: 55,
                      leading: IconButton(
                        splashRadius: 18, // Configures the radius of the splash effect.
                        style: AppStyles.iconButtonStyle, // Applies custom styling to the icon button.
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: AppColors
                                .abyssColor), // Sets a custom back arrow icon with a dynamic color based on the current theme.
                        onPressed: () {
                          Navigator.pop(
                              context); // Pops the current route off the navigator stack when back button is pressed.
                        },
                      ),
                      actions: [
                        UnconstrainedBox(
                          child: _MonitorButton(
                            talker: widget.talker,
                            onPressed: () => _openTalkerMonitor(context),
                          ),
                        ),
                        UnconstrainedBox(
                          child: IconButton(
                            style: AppStyles.iconButtonStyle, // Applies custom styling to the icon button.,
                            onPressed: () => _openTalkerSettings(
                              context,
                              talkerScreenTheme,
                            ),
                            icon: const Icon(Icons.settings_rounded),
                          ),
                        ),
                        UnconstrainedBox(
                          child: IconButton(
                            style: AppStyles.iconButtonStyle, // Applies custom styling to the icon button.,
                            onPressed: () => _showActionsBottomSheet(context),
                            icon: const Icon(Icons.menu_rounded),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      title: Text(
                        widget.appBarTitle,
                        style: AppTextStyle.bodyMedium500(context),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: ListView(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      GroupButton(
                                        controller: _titilesController,
                                        isRadio: false,
                                        buttonBuilder: (selected, value, context) {
                                          final count = titles.where((e) => e == value).length;
                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: selected ? AppColors.primaryColor : Colors.transparent,
                                              border: Border.all(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "$value ($count)",
                                                  style: AppTextStyle.labelMedium400(context).copyWith(
                                                    color: !selected ? AppColors.abyssColor : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        onSelected: (_, i, selected) {
                                          _onToggleTitle(unicTitles[i], selected);
                                        },
                                        buttons: unicTitles,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: OutlinedTextfield(
                                    onChanged: _controller.updateFilterSearchQuery,
                                    hintText: "Поиск",
                                    labelText: "",
                                    textController: null,
                                    radius: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 0)),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final data = _getListItem(filtredElements, i);
                          if (widget.itemsBuilder != null) {
                            return widget.itemsBuilder!.call(context, data);
                          }
                          return LogDataCard(
                            data: data,
                            onTap: () => _copyTalkerDataItemText(data),
                            expanded: _controller.expandedLogs,
                          );
                        },
                        childCount: filtredElements.length,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _onToggleTitle(String title, bool selected) {
    if (selected) {
      _controller.addFilterTitle(title);
    } else {
      _controller.removeFilterTitle(title);
    }
  }

  TalkerDataInterface _getListItem(
    List<TalkerDataInterface> filtredElements,
    int i,
  ) {
    final data = filtredElements[_controller.isLogOrderReversed ? filtredElements.length - 1 - i : i];
    return data;
  }

  void _openTalkerSettings(BuildContext context, TalkerScreenTheme theme) {
    final talker = ValueNotifier(widget.talker);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return TalkerSettingsBottomSheetW(
          talkerScreenTheme: theme,
          talker: talker,
        );
      },
    );
  }

  void _openTalkerMonitor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerMonitorW(
          theme: widget.theme,
          talker: widget.talker,
        ),
      ),
    );
  }

  Future<void> _showActionsBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TalkerActionsBottomSheetW(
          actions: [
            TalkerActionItem(
              onTap: _controller.toggleLogOrder,
              title: 'Изменить порядок',
              icon: Icons.swap_vert,
            ),
            TalkerActionItem(
              onTap: () => _copyAllLogs(context),
              title: 'Скопировать все логи',
              icon: Icons.copy,
            ),
            TalkerActionItem(
              onTap: _toggleLogsExpanded,
              title: _controller.expandedLogs ? 'Свернуть логи' : 'Развернуть логи',
              icon: _controller.expandedLogs ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            ),
            TalkerActionItem(
              onTap: _cleanHistory,
              title: 'Очистить историю логов',
              icon: Icons.delete_outline,
            ),
            TalkerActionItem(
              onTap: _shareLogsInFile,
              title: 'Поделиться файлов логов',
              icon: Icons.ios_share_outlined,
            ),
          ],
          talkerScreenTheme: widget.theme,
        );
      },
    );
  }

  Future<void> _shareLogsInFile() async {
    final path = await _controller.saveLogsInFile(
      widget.talker.history.text,
    );
    // ignore: deprecated_member_use
    await Share.shareFilesWithResult([path]);
  }

  void _copyTalkerDataItemText(TalkerDataInterface data) {
    final text = data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  void _cleanHistory() {
    widget.talker.cleanHistory();
    _controller.update();
  }

  void _toggleLogsExpanded() {
    _controller.expandedLogs = !_controller.expandedLogs;
  }

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.talker.history.text));
    _showSnackBar(context, 'All logs copied in buffer');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}

class _MonitorButton extends StatelessWidget {
  const _MonitorButton({
    Key? key,
    required this.talker,
    required this.onPressed,
  }) : super(key: key);

  final Talker talker;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TalkerBuilder(
      talker: talker,
      builder: (context, data) {
        final haveErrors = data.where((e) => e is TalkerError || e is TalkerException).isNotEmpty;
        return Stack(
          children: [
            Center(
              child: IconButton(
                style: AppStyles.iconButtonStyle, // Applies custom styling to the icon button.,
                onPressed: onPressed,
                icon: const Icon(Icons.monitor_heart_outlined),
              ),
            ),
            if (haveErrors)
              Positioned(
                right: 6,
                top: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  height: 7,
                  width: 7,
                ),
              ),
          ],
        );
      },
    );
  }
}
