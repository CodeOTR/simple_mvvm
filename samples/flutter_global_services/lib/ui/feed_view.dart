import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/services/authentication_service.dart';
import 'package:flutter_counter/ui/login_view.dart';

class FeedView extends StatelessWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationViewModel authModel = getModel<AuthenticationViewModel>(context);
    return FeedViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
          body: Center(
            child: Text(authModel.loggedIn.value.toString()),
          ),
          floatingActionButton: AuthButton(),
        );
      },
    );
  }
}

class FeedViewModelBuilder extends ViewModelBuilder<FeedViewModel> {
  const FeedViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => FeedViewModel();
}

class FeedViewModel extends ViewModel<FeedViewModel> {
  static FeedViewModel of_(BuildContext context) => getModel<FeedViewModel>(context);
}
