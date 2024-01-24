import 'package:flutter/material.dart';
import 'package:flutter_reusable_view_models/pages/one/one_view.dart';
import 'package:flutter_reusable_view_models/pages/one/one_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget Tests', () {
    setUpAll(() {});

    testWidgets('Counter can be incremented', (tester) async {
      // Setup - Arrange
      await tester.pumpWidget(const TestingWrapper(OneView()));
      final OneViewModel model = tester.state(find.byType(OneViewModelBuilder));

      // Act
      model.increment();

      // Result - Assert
      expect(model.counter.value, 1);
    });

    tearDown(() {});
  });
}

class TestingWrapper extends StatelessWidget {
  const TestingWrapper(
    this.child, {
    super.key,
    this.size = const Size(1080, 1920),
  });

  final Widget child;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      home: MediaQuery(
        data: MediaQueryData(size: size),
        child: Material(child: child),
      ),
    );
  }
}
