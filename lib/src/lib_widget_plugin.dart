import 'package:flutter/material.dart';

import 'widget_config.dart';

/// @author: Devin
/// @date: 2021/10/27 15:26
/// @description:
class LibWidgetPlugin {
  LibWidgetPlugin._();

  static init({
    required IWidgetConfig config,
  }) {
    /// 初始化core config
    widgetConfig = config;
  }
}
