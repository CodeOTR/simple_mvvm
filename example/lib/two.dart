import 'package:flutter/material.dart';
import 'package:simple_mvvm/simple_mvvm.dart';

class ScreenTwoView extends StatelessWidget {
  const ScreenTwoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTwoViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
          appBar: AppBar(title: const Text("Screen Two")),
          body: Center(
            child: Column(
              children: [
                const Text("Screen Two Counter:"),
                Text(model.counter.value.toString()),
                ModelWidget<ScreenTwoViewModel>(
                  builder: (context, model) {
                    return Text(model.counter.value.toString());
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      ScreenTwoViewModel().of(context).incrementCounter();
                    },
                    child: const Text('Increment Counter'))
              ],
            ),
          ),
        );
      },
    );
  }
}

class ScreenTwoViewModelBuilder extends ViewModelBuilder<ScreenTwoViewModel> {
  const ScreenTwoViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => ScreenTwoViewModel();
}

class ScreenTwoViewModel extends ViewModel<ScreenTwoViewModel> {
  ValueNotifier<int> counter = ValueNotifier(0);

  void incrementCounter() {
    setState(() {
      counter.value = counter.value + 1;
    });
  }

  @override
  void dispose() {
    debugPrint('Dispose screen two');
    super.dispose();
  }
}
