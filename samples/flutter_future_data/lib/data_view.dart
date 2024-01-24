import 'package:flutter/material.dart';
import 'data_view_model.dart';

class DataView extends StatelessWidget {
  const DataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
          body: Center(
            child: Builder(
              builder: (context) {
                switch (model.isLoading) {
                  case true:
                    return const CircularProgressIndicator();
                  default:
                    return Text(model.name ?? 'No name');
                }
              },
            ),
          ),
        );
      },
    );
  }
}
