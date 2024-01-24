import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reusable_view_models/pages/color_mixin.dart';
import 'package:flutter_reusable_view_models/pages/counter_view_model.dart';

class TwoViewModelBuilder extends ViewModelBuilder<TwoViewModel> {
  const TwoViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => TwoViewModel();
}

class TwoViewModel extends CounterViewModel<TwoViewModel> with ColorMixin {
  static TwoViewModel of_(BuildContext context) => getModel<TwoViewModel>(context);
}
