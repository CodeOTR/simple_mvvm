import 'package:flutter/material.dart';
import 'package:flutter_reusable_view_models/pages/one/one_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OneView(),
    );
  }
}
