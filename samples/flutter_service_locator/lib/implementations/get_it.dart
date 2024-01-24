import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_service_locator/main.dart';
import 'package:flutter_service_locator/services/user_service.dart';
import 'package:flutter_service_locator/widgets/get_it_name.dart';

class GetItView extends StatelessWidget {
  const GetItView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetItViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
            appBar: AppBar(title: const Text('Get It')),
            body: Center(
              child: Column(
                children: [
                  const GetItName(),
                  TextButton(
                    child: const Text('Set Name'),
                    onPressed: () {
                      if (getIt.get<UserService>().first.value == 'Bob') {
                        getIt.get<UserService>().setFirst('Alice');
                      } else {
                        getIt.get<UserService>().setFirst('Bob');
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

class GetItViewModelBuilder extends ViewModelBuilder<GetItViewModel> {
  const GetItViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => GetItViewModel();
}

class GetItViewModel extends ViewModel<GetItViewModel> {
  static GetItViewModel of_(BuildContext context) => getModel<GetItViewModel>(context);
}
