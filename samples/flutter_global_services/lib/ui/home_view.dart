import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/services/authentication_service.dart';
import 'package:flutter_counter/ui/login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationViewModel authModel = getModel<AuthenticationViewModel>(context);
    return HomeViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
          body: Center(
            child: ListenableBuilder(
              listenable: Listenable.merge([authModel.loggedIn, authModel.name]),
              builder: (context, child) {
                return Text(authModel.loggedIn.value.toString());
              },
            ),
          ),
          floatingActionButton: const AuthButton(),
        );
      },
    );
  }
}

class HomeViewModelBuilder extends ViewModelBuilder<HomeViewModel> {
  const HomeViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => HomeViewModel();
}

class HomeViewModel extends ViewModel<HomeViewModel> {
  static HomeViewModel of_(BuildContext context) => getModel<HomeViewModel>(context);
}
