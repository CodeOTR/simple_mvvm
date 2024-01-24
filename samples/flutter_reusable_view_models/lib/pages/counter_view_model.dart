import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/foundation.dart';

class CounterViewModel<T> extends ViewModel<T> {
  ValueNotifier<int> counter = ValueNotifier(0);

  void increment() {
    setState(() {
      counter.value = counter.value + 1;
    });
  }
}
