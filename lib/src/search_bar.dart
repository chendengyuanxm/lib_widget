import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final String hintText;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Decoration? decoration;
  final double? height;
  final bool cancelable;
  final bool enabled;
  final ValueChanged? onValueChanged;
  final ValueChanged? onSubmitted;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  const SearchBar({
    Key? key,
    this.leading,
    this.trailing,
    this.hintText = '搜索',
    this.textStyle,
    this.hintTextStyle,
    this.decoration,
    this.height,
    this.cancelable = true,
    this.enabled = true,
    this.onValueChanged,
    this.onSubmitted,
    this.textEditingController,
    this.focusNode,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.textEditingController ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Widget leading = widget.leading != null ? widget.leading! : SizedBox();
    Widget trailing = widget.trailing ?? (widget.cancelable ? IconButton(
      icon: new Icon(Icons.cancel),
      color: Colors.grey,
      iconSize: 20,
      onPressed: () {
        controller.clear();
        widget.onValueChanged?.call('');
      },
    ) : SizedBox());
    var border = OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.none),
    );
    return Container(
      height: widget.height ?? 100.h,
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: widget.decoration ?? BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leading,
          SizedBox(width: 5,),
          Expanded(
            child: Container(
              child: TextField(
                focusNode: widget.focusNode,
                enabled: widget.enabled,
                controller: controller,
                style: widget.textStyle,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: widget.hintTextStyle,
                  enabledBorder: border,
                  focusedBorder: border,
                  disabledBorder: border,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  widget.onValueChanged?.call(value);
                },
                onSubmitted: (value) {
                  widget.onSubmitted?.call(value);
                },
              ),
            ),
          ),
          SizedBox(width: 5,),
          trailing,
        ],
      ),
    );
  }
}