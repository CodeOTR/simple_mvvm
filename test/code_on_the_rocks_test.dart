import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      counter--;
    });
  }

  static CounterViewModel of_(BuildContext context) => getModel<CounterViewModel>(context);
}

class CounterView extends StatelessWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CounterViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
            body: Center(
          child: Text('Counter'),
        ));
      },
    );
  }
}

void main() {
  group('Counter', () {
    testWidgets('CounterViewModel smoke test', (WidgetTester tester) async {
      // Setup - Arrange
      await tester.pumpWidget(MaterialApp(builder: (context, child) => const CounterView()));
      final CounterViewModel model = tester.state(find.byType(CounterViewModelBuilder));

      // Action - Act
      model.increment();

      // Result - Assert
      expect(model.counter, 1);

      model.decrement();
      expect(model.counter, 0);
    });

    testWidgets('ViewModel loading test', (WidgetTester tester) async {
      // Setup - Arrange
      await tester.pumpWidget(MaterialApp(builder: (context, child) => const CounterView()));
      final CounterViewModel model = tester.state(find.byType(CounterViewModelBuilder));

      expect(model.isLoading, false);
      model.setLoading(true);
      expect(model.isLoading, true);
      model.setLoading(false);
      expect(model.isLoading, false);
    });

    testWidgets('InheritedWidget getter test', (WidgetTester tester) async {
      // Setup - Arrange
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => CounterViewModelBuilder(
            builder: (context, model) {
              expect(getModel<CounterViewModel>(context).runtimeType, CounterViewModel);
              expect(CounterViewModel().of(context), model);

              return Scaffold(
                  body: Center(
                child: Text('Counter'),
              ));
            },
          ),
        ),
      );
    });
  });

  group('ViewModelProvider', () {
    test('InheritedWidget should always update', () {
      ViewModelProvider<CounterViewModel> provider = ViewModelProvider(
        state: CounterViewModel(),
        child: Text('Test'),
      );

      expect(provider.updateShouldNotify(provider), true);
    });
  });
}
