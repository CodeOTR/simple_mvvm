import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_service_locator/main.dart';
import 'package:flutter_service_locator/services/user_service.dart';
import 'package:flutter_service_locator/widgets/ioc_name.dart';

class IocContainerView extends StatelessWidget {
  const IocContainerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IocContainerViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
            appBar: AppBar(title: const Text('Ioc Container')),
            body: Center(
              child: Column(
                children: [
                  const IocName(),
                  TextButton(
                    child: const Text('Set Name'),
                    onPressed: () {
                      if (serviceLocator<UserService>().first.value == 'Bob') {
                        serviceLocator<UserService>().setFirst('Alice');
                      } else {
                        serviceLocator<UserService>().setFirst('Bob');
                      }
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class IocContainerViewModelBuilder extends ViewModelBuilder<IocContainerViewModel> {
  const IocContainerViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => IocContainerViewModel();
}

class IocContainerViewModel extends ViewModel<IocContainerViewModel> {
  static IocContainerViewModel of_(BuildContext context) => getModel<IocContainerViewModel>(context);
}
