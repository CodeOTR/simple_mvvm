import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/services/authentication_service.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationViewModel authModel = getModel<AuthenticationViewModel>(context);
    return LoginViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
          body: Center(
            child: Text(authModel.loggedIn.value.toString()),
          ),
          floatingActionButton: const AuthButton(),
        );
      },
    );
  }
}

class LoginViewModelBuilder extends ViewModelBuilder<LoginViewModel> {
  const LoginViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => LoginViewModel();
}

class LoginViewModel extends ViewModel<LoginViewModel> {
  static LoginViewModel of_(BuildContext context) => getModel<LoginViewModel>(context);
}

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      AuthenticationViewModel authModel = AuthenticationViewModel.of_(context);
      authModel.setLoggedIn(!authModel.loggedIn.value);
    });
  }
}
