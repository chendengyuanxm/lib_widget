import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_widget/src/widget_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget title;
  final List<Widget>? actions;
  final VoidCallback? onClickBack;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.onClickBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      title: title,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.only(left: 0),
        child: leading ?? IconButton(
          onPressed: () {
            if (onClickBack != null) {
              onClickBack?.call();
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: Icon(Icons.chevron_left_sharp, size: 30,),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(widgetConfig?.toolBarHeight ?? kToolbarHeight);
}
