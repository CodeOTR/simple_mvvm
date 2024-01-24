library simple_mvvm;

import 'package:flutter/material.dart';

/// A builder signature that returns a Widget and provides its children with a ViewModel
typedef _ModelBuilder<TViewModel> = Widget Function(BuildContext context, TViewModel model);

/// A ViewModelBuilder is a StatefulWidget that builds a ViewModel of type T
/// This is the widget you will add to your widget tree
abstract class ViewModelBuilder<TViewModel> extends StatefulWidget {
  const ViewModelBuilder({Key? key, required this.builder}) : super(key: key);
  final _ModelBuilder<TViewModel> builder;
}

/// Get the nearest ViewModel of type T
/// This is a convenience method that can be used to get the ViewModel from a BuildContext
T getModel<T>(BuildContext context) {
  try {
    return (context.dependOnInheritedWidgetOfExactType<ViewModelProvider<ViewModel<T>>>()!.state) as T;
  } catch (e) {
    throw Exception(
        "Could not find ViewModel of type $T above this widget. Make sure you have added a matching ViewModelBuilder to the widget tree.");
  }
}

/// A ViewModel is a State object that can be used to store data and update the UI
/// When the ViewModel calls setState, the UI will be updated
abstract class ViewModel<T> extends State<ViewModelBuilder<T>> {
  /// Class method to get the nearest ViewModel of type T
  T of(BuildContext context) => getModel<T>(context);

  /// A ValueNotifier that can be used to update the UI
  ValueNotifier<bool> loading = ValueNotifier(false);

  /// Get the loading state of the ViewModel
  bool get isLoading => loading.value;

  /// Set the loading state of the ViewModel
  /// Useful for showing a loading indicator
  void setLoading(bool val) {
    setState(() {
      loading.value = val;
    });
  }

  Future<void> runWhileLoading(callback, {ValueNotifier<bool>? loader, bool showSnackBar = false}) async {
    try {
      updateLoader(true, loader);
      await callback();
    } catch (e) {
      debugPrint(e.toString());
      if (showSnackBar) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      updateLoader(false, loader);
    }
  }

  void updateLoader(bool value, ValueNotifier<bool>? loader) {
    if (loader != null) {
      loader.value = value;
    } else {
      setLoading(value);
    }
  }

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider(
      state: this,
      child: Builder(
        builder: (context) {
          return widget.builder(context, this as T);
        },
      ),
    );
  }
}

/// A ModelWidget is a StatelessWidget that provides its children with a ViewModel
class ModelWidget<TViewModel extends ViewModel> extends StatelessWidget {
  const ModelWidget({Key? key, required this.builder}) : super(key: key);
  final _ModelBuilder<TViewModel> builder;

  @override
  Widget build(BuildContext context) {
    debugPrint('TViewModel.runtimeType: ' + TViewModel.toString());

    assert(TViewModel.toString() != 'ViewModel<dynamic>',
        'You must provide a specific ViewModel type to ModelWidget. For example: ModelWidget<HomeViewModel>');

    return Builder(
      builder: (context) {
        return builder(context, getModel<TViewModel>(context));
      },
    );
  }
}

/// A ViewModelProvider is an InheritedWidget that provides its children with a ViewModel
/// It is returned by the ViewModel's build method and should not be edited
class ViewModelProvider<TViewModel extends ViewModel> extends InheritedWidget {
  const ViewModelProvider({Key? key, required Widget child, required this.state}) : super(key: key, child: child);
  final TViewModel state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
