import 'package:flutter/material.dart';
import 'package:flutter_service_locator/implementations/get_it.dart';
import 'package:flutter_service_locator/implementations/ioc_container.dart';
import 'package:flutter_service_locator/services/user_service.dart';
import 'package:flutter_service_locator/widgets/ioc_name.dart';
import 'package:get_it/get_it.dart';
import 'package:ioc_container/ioc_container.dart';

import 'widgets/get_it_name.dart';

// get_it
final getIt = GetIt.instance;

// ioc_container
late final IocContainer serviceLocator;
final iocBuilder = IocContainerBuilder()..addSingletonService(UserService());

void main() {
  getIt.registerSingleton<UserService>(UserService());
  serviceLocator = iocBuilder.toContainer();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
            body: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetItName(),
                  IocName(),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    label: const Text('ioc_container'),
                    heroTag: 'ioc_container',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const IocContainerView()));
                    },
                  ),
                  const SizedBox.square(dimension: 16),
                  FloatingActionButton.extended(
                    label: const Text('get_it'),
                    heroTag: 'get_it',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GetItView()));
                    },
                  ),
                ],
              ),
            ));
      }),
    );
  }
}
