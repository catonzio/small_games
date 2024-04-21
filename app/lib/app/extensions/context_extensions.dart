import 'package:flutter/material.dart';

extension ContextExts on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}
