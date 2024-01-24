import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';

class AuthenticationViewModelBuilder extends ViewModelBuilder<AuthenticationViewModel> {
  const AuthenticationViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => AuthenticationViewModel();
}

class AuthenticationViewModel extends ViewModel<AuthenticationViewModel> {
  ValueNotifier<bool> loggedIn = ValueNotifier(false);

  void setLoggedIn(bool val) => loggedIn.value = val;

  ValueNotifier<String?> name = ValueNotifier(null);

  void setName(String? val) => name.value = val;

  String? email;

  void setEmail(String val) => setState(() => email = val);

  static AuthenticationViewModel of_(BuildContext context) => getModel<AuthenticationViewModel>(context);
}
