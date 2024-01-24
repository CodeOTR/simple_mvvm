import 'package:flutter/material.dart';
import 'package:flutter_service_locator/main.dart';
import 'package:flutter_service_locator/services/user_service.dart';

class GetItName extends StatelessWidget {
  const GetItName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: getIt<UserService>().first,
      builder: (context, value, child) {
        return Center(
          child: Text('Hello, $value (get_it)'),
        );
      },
    );
  }
}
