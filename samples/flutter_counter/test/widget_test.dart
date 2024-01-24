import 'package:flutter/material.dart';
import 'package:flutter_counter/counter_view.dart';
import 'package:flutter_counter/counter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CounterViewModel smoke test', (WidgetTester tester) async {
    // Setup - Arrange
    await tester.pumpWidget(
        MaterialApp(builder: (context, child) => const CounterView()));
    final CounterViewModel model =
        tester.state(find.byType(CounterViewModelBuilder));

    // Action - Act
    model.increment();

    // Result - Assert
    expect(model.counter, 1);

    model.decrement();
    expect(model.counter, 0);
  });

  testWidgets('CounterViewModel UI test', (WidgetTester tester) async {
    // Setup - Arrange
    await tester.pumpWidget(
        MaterialApp(builder: (context, child) => const CounterView()));
    final CounterViewModel model =
        tester.state(find.byType(CounterViewModelBuilder));

    model.setState(() => model.counter = 7);

    await tester.pump();

    // finders
    final counterFinder = find.text('Counter');
    final incrementFinder = find.byIcon(Icons.add);
    final decrementFinder = find.byIcon(Icons.remove);
    final countFinder = find.text('7');

    expect(counterFinder, findsOneWidget);
    expect(incrementFinder, findsOneWidget);
    expect(decrementFinder, findsOneWidget);
    expect(countFinder, findsOneWidget);
  });
}
