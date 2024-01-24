import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reusable_view_models/pages/two/two_view.dart';
import 'one_view_model.dart';

class OneView extends StatelessWidget {
  const OneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OneViewModelBuilder(
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
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TwoView()),
                );
              },
              child: const Icon(Icons.arrow_forward),
            ));
      },
    );
  }
}
