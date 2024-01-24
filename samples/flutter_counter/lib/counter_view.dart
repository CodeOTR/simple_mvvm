import 'package:flutter/material.dart';
import 'package:flutter_counter/counter_view_model.dart';

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterViewModelBuilder(
      builder: (context, model) {
        debugPrint('building');
        return Scaffold(
          appBar: AppBar(title: const Text('Counter')),
          body: Center(
              child: ValueListenableBuilder(
                  valueListenable: model.secretCounter,
                  builder: (context, value, child) {
                    return Text('$value');
                  })),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                key: const Key('increment'),
                child: const Icon(Icons.add),
                onPressed: () =>
                    CounterViewModel.of_(context).incrementSecretCounter(),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                key: const Key('decrement'),
                child: const Icon(Icons.remove),
                onPressed: () =>
                    CounterViewModel.of_(context).decrementSecretCounter(),
              ),
            ],
          ),
        );
      },
    );
  }
}
