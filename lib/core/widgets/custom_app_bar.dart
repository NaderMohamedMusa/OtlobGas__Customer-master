import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'back_button_widget.dart';
import 'notification_button_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final double toolbarHeight;
  final Widget title;
  final bool centerTitle;
  final List<Widget>? actions;
  final List<Widget>? tabs;
  final Widget? bottomWidget;
  final Widget? leading;

  CustomAppBar({
    Key? key,
    required this.title,
    this.bottomWidget,
    this.centerTitle = false,
    this.actions,
    this.tabs,
    this.toolbarHeight = kToolbarHeight,
    this.leading,
  })  : preferredSize = Size.fromHeight(toolbarHeight),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<Widget> customActions = <Widget>[
      const NotificationButton(),
      const SizedBox(width: 10),
      const BackButtonWidget(),
      const SizedBox(width: 10),
    ];
    return AppBar(
      toolbarHeight: toolbarHeight,
      title: title,
      centerTitle: centerTitle,
      actions: actions ?? customActions,
      leading: leading ?? const SizedBox(),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Material(
          color: Colors.white,
          child: bottomWidget ??
              (tabs == null
                  ? null
                  : TabBar(
                      automaticIndicatorColorAdjustment: true,
                      unselectedLabelStyle:
                          Theme.of(context).textTheme.headlineMedium,
                      labelStyle: Theme.of(context).textTheme.headlineMedium,
                      unselectedLabelColor: Colors.grey,
                      labelColor: AppColors.mainApp,
                      indicatorColor: AppColors.mainApp,
                      tabs: tabs!,
                    )),
        ),
      ),
    );
  }
}
