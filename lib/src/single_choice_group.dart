import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleChoiceGroup<T> extends StatefulWidget {
  final List<T> items;
  final double spacing;
  final T value;
  final IndexedWidgetBuilder? builder;
  final ValueChanged? valueChanged;
  final bool expanded;

  const SingleChoiceGroup({
    Key? key,
    required this.items,
    required this.value,
    this.spacing = 10,
    this.valueChanged,
    this.builder,
    this.expanded = false,
  }) : super(key: key);

  @override
  _SingleChoiceGroupState createState() => _SingleChoiceGroupState();
}

class _SingleChoiceGroupState extends State<SingleChoiceGroup> {
  var _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: widget.items.map((e) {
        Widget item;
        if (widget.builder != null) {
          item = widget.builder!(context, index ++);
        } else {
          item = _buildDefaultItem(e);
        }
        return Flexible(
          flex: widget.expanded ? 1 : 0,
          child: Padding(
            padding: EdgeInsets.only(right: widget.spacing),
            child: GestureDetector(
              onTap: () {
                _value = e;
                if (widget.valueChanged != null) {
                  widget.valueChanged?.call(e);
                }
                setState(() {
                });
              },
              child: item,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDefaultItem(var e) {
    bool selected = _value == e;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left:30.w, right:30.w, top:15.h, bottom:15.h),
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).primaryColor : null,
        borderRadius:  BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Text(e, style: TextStyle(
        color: selected ? Colors.white : Colors.black54,
        fontSize: 26.sp,
      ),),
    );
  }
}
