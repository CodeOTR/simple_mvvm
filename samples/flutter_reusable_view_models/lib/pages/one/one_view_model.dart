import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reusable_view_models/pages/color_mixin.dart';
import 'package:flutter_reusable_view_models/pages/counter_view_model.dart';

class OneViewModelBuilder extends ViewModelBuilder<OneViewModel> {
  const OneViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => OneViewModel();
}

class OneViewModel extends CounterViewModel<OneViewModel> with ColorMixin {
  @override
  void initState() {
    super.initState();
    setState(() {
      setColor(Colors.green);
    });
  }

  static OneViewModel of_(BuildContext context) => getModel<OneViewModel>(context);
}
