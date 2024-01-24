import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';

mixin ColorMixin<T> on ViewModel<T> {
  ValueNotifier<Color> color = ValueNotifier(Colors.blue);

  void setColor(Color val) {
    color.value = val;
  }
}
