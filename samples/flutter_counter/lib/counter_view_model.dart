import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';

class CounterViewModelBuilder extends ViewModelBuilder<CounterViewModel> {
  const CounterViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => CounterViewModel();
}

class CounterViewModel extends ViewModel<CounterViewModel> {
  int counter = 0;

  ValueNotifier<int> secretCounter = ValueNotifier(0);

  void incrementSecretCounter() {
    secretCounter.value = secretCounter.value + 1;
  }

  void decrementSecretCounter() {
    secretCounter.value = secretCounter.value - 1;
  }

  void increment() {
    setState(() => counter = counter + 1);
  }

  void decrement() {
    setState(() => counter = counter - 1);
  }

  static CounterViewModel of_(BuildContext context) => getModel<CounterViewModel>(context);
}
