import 'package:flutter/material.dart';
import 'package:flutter_counter/data_view.dart';
import 'package:flutter_counter/data_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DataViewModel smoke test', (WidgetTester tester) async {
    // Setup - Arrange
    await tester
        .pumpWidget(MaterialApp(builder: (context, child) => const DataView()));
    final DataViewModel model = tester.state(find.byType(DataViewModelBuilder));

    expect(model.name, null);

    await tester.pumpAndSettle(const Duration(seconds: 60));

    expect(model.name, 'Falco');
  });
}
