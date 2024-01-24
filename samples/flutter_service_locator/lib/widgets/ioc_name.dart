import 'package:flutter/material.dart';
import 'package:flutter_service_locator/main.dart';
import 'package:flutter_service_locator/services/user_service.dart';

class IocName extends StatelessWidget {
  const IocName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: serviceLocator<UserService>().first,
      builder: (context, value, child) {
        return Center(
          child: Text('Hello, $value (ioc_container)'),
        );
      },
    );
  }
}
