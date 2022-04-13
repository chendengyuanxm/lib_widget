import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleChoiceGroup<T> extends StatefulWidget {
  final List<T> items;
  final double spacing;
  final T value;
  final IndexedWidgetBuilder? builder;
  final ValueChanged? valueChanged;
  final bool expanded;
  final Axis direction;

  const SingleChoiceGroup({
    Key? key,
    required this.items,
    required this.value,
    this.spacing = 10,
    this.valueChanged,
    this.builder,
    this.expanded = false,
    this.direction = Axis.horizontal,
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
    if (widget.direction == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: _buildChoicesItem(widget.direction),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildChoicesItem(widget.direction),
      );
    }
  }

  List<Widget> _buildChoicesItem(Axis direction) {
    int index = 0;
    EdgeInsets padding;
    if (direction == Axis.horizontal) {
      padding = EdgeInsets.only(right: widget.spacing);
    } else {
      padding = EdgeInsets.only(bottom: widget.spacing);
    }
    return widget.items.map((e) {
      Widget item;
      if (widget.builder != null) {
        item = widget.builder!(context, index ++);
      } else {
        item = _buildDefaultItem(e);
      }
      return Flexible(
        flex: widget.expanded ? 1 : 0,
        fit: FlexFit.tight,
        child: Padding(
          padding: padding,
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
    }).toList();
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
