import 'package:flutter/material.dart';
import 'two_view_model.dart';

class TwoView extends StatelessWidget {
  const TwoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TwoViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
          backgroundColor: model.color.value,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Counter: ${model.counter.value}'),
                ElevatedButton(
                  onPressed: model.increment,
                  child: const Text('Increment'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
