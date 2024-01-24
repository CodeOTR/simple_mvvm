import 'package:flutter/material.dart';
import 'package:flutter_counter/services/authentication_service.dart';
import 'package:flutter_counter/ui/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Service Demo',
      home: AuthenticationViewModelBuilder(
        builder: (context, model) {
          return const HomeView();
        },
      ),
    );
  }
}
