import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatefulWidget {
  final Widget? leading;
  final String hintText;
  final Decoration? decoration;
  final bool cancelable;
  final bool enabled;
  final ValueChanged? onValueChanged;

  const SearchBar({
    Key? key,
    this.leading,
    this.hintText = '搜索',
    this.decoration,
    this.cancelable = true,
    this.enabled = true,
    this.onValueChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget leading = widget.leading != null ? widget.leading! : SizedBox();
    Widget trailing = widget.cancelable ? IconButton(
      icon: new Icon(Icons.cancel),
      color: Colors.grey,
      iconSize: 20,
      onPressed: () {
        controller.clear();
        widget.onValueChanged?.call('');
      },
    ) : SizedBox();
    var border = OutlineInputBorder(
      borderSide: BorderSide(style: BorderStyle.none),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        height: 40,
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
                  enabled: widget.enabled,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      fontSize: 30.sp,
                    ),
                    enabledBorder: border,
                    focusedBorder: border,
                    disabledBorder: border,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    widget.onValueChanged?.call(value);
                  },
                ),
              ),
            ),
            SizedBox(width: 5,),
            trailing,
          ],
        ),
      ),
    );
  }
}