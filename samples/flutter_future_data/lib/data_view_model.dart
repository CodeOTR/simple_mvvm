import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';

class DataViewModelBuilder extends ViewModelBuilder<DataViewModel> {
  const DataViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => DataViewModel();
}

class DataViewModel extends ViewModel<DataViewModel> {
  String? name;

  @override
  void initState() {
    getName().then((value) {
      // Call setState after the Future completes
      setState(() => name = value);
    });
    super.initState();
  }

  Future<String> getName() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 3));
    setLoading(false);
    return 'Falco';
  }

  static DataViewModel of_(BuildContext context) => getModel<DataViewModel>(context);
}
