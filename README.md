![Simple MVVM](https://github.com/CodeOTR/simple_mvvm/raw/main/assets/social_card.png)

<p align="center">                    
<a href="https://img.shields.io/badge/License-MIT-green"><img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>
<a href="https://pub.dev/packages/simple_mvvm"><img src="https://img.shields.io/pub/v/simple_mvvm?label=pub&color=orange" alt="pub version"></a>      
<a href="https://twitter.com/CodeOnTheRocks_">
    <img src="https://img.shields.io/twitter/follow/CodeOnTheRocks_?style=social">
  </a>
</p>


<p align="center">
  <a href="https://codeontherocks.dev/">Simple MVVM</a> •
  <a href="https://github.com/CodeOTR/simple_mvvm/tree/main/samples">Sample Apps</a> •
  <a href="https://pub.dev/packages/simple_mvvm/install">Pub.dev</a>
</p>

---

A bold and balanced state management library that pairs MVVM structures with the simplicity of InheritedWidget 🐦🍹

## Overview

The Simple MVVM library provides a simple set of widgets to help you pass state data to a subtree.
1. `ViewModel` - A [State](https://api.flutter.dev/flutter/widgets/State-class.html) object that introduces an InheritedWidget to the widget tree.
2. `ViewModelBuilder` - A [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) that you will include in your widget
3. `ViewModelProvider` - (Behind the scenes) An [InheritedWidget](https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html) that provides the `ViewModel` to its children

When building with simple_mvvm, you only need to worry about the `ViewModel` and `ViewModelBuilder`. The `ViewModelProvider` is created for you.

![Simple MVVM widget diagram](https://github.com/CodeOTR/simple_mvvm/raw/main/assets/simple_mvvm_diagram.png)

The benefit to this approach is that _all_ children within the subtree can access the `ViewModel` - that's just how InheritedWidgets work.

Depending on your app's needs, you can place a `ViewModelBuilder` as high up in your app's widget tree as you'd like, making this a convenient way to
pass services, constants, etc to your entire application.

## Benefits

### 💙 Pure Flutter

`ViewModelProviders` are `InheritedWidgets`, meaning you can access them the using methods built into the Flutter framework. Since the `ViewModel` is
a
property on the `ViewModelProvider`, you can access it using
the [dependOnInheritedWidgetOfExactType](https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html) context method.
This package sets that up for you so can just do this:

```dart

HomeViewModel model = HomeViewModel().of(context);
```

### 🍋 Easy Model Usage

The `ViewModelProvider` _provides_ your model to its children through its builder property so most of the time you won't need to add code to access
the
model.

```dart
return Scaffold(
body: HomeViewModelBuilder(
builder: (context, model) {
return ... // Use the model to render your UI
},
)
);
```

### 🔥 No Bloat

This entire library is 60 lines of dart code with no external dependencies.

## Setup

**Step 1**:

Create a ViewModel. The ViewModel is a [State](https://api.flutter.dev/flutter/widgets/State-class.html) object that introduces an InheritedWidget to
the widget tree. This is where your business logic will live.

```dart
class HomeViewModel extends ViewModel<HomeViewModel> {

  // For convenience, you can add a static .of_ getter. This is optional
  static HomeViewModel of_(BuildContext context) => getModel<HomeViewModel>(context);

  // Here is where you will add your business logic and state properties
  // Notice that you have access to setState here
  ValueNotifier<int> counter = ValueNotifier(0);

  void incrementCounter() {
    setState(() {
      counter.value++;
    });
  }
}
```

**Step 2**:

Create a `ViewModelBuilder`. The `ViewModelBuilder` is a [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html) that you
will
include in your widget tree. `ViewModelBuilder` creates the `ViewModel` from above.

```dart
 class HomeViewModelBuilder extends ViewModelBuilder<HomeViewModel> {
  const HomeViewModelBuilder({
    super.key,
    required super.builder,
  });

  // Override createState to create the specific ViewModel from above
  @override
  State<StatefulWidget> createState() => HomeViewModel();
}
 ```

## Usage

Once you have your `ViewModel` and `ViewModelBuilder`, add the `ViewModelBuilder` to your widget tree:

```dart
return Scaffold(
body: HomeViewModelBuilder(
builder: (context, model) {
return Text('Test')
},
)
);
```

Now you have several ways to access the ViewModel.

### 1. Use the provided "model" object:

```dart
return Scaffold(
body: HomeViewModelBuilder(
builder: (context, model) {
return Text(model.title); // Add a title String to your ViewModel
},
)
);
```

### 2. Use the getModel\<T\> helper function:

Under the hood, the `getModel` function uses `dependOnInheritedWidgetOfExactType` to get the type you specify in the generic parameter T.

```dart
return Scaffold(
body: HomeViewModelBuilder(
builder: (context, model) {
return Text(getModel<HomeViewModel>(context).title); // Add a title String to your ViewModel
},
)
,
);
```

### 3. Use the ModelWidget:

```dart
ModelWidget<ScreenTwoViewModel>
(
builder: (context, model) {
return Text(model.counter.value.toString());
},
)
,
```

### 4. Use the .of(context) method:

Each `ViewModel` has a built in .of() method. This is useful if you break your widget tree up and need to access the model in a different widget:

```dart
return Scaffold(
body: HomeViewModelBuilder(
builder: (context, model) {
return Text(HomeViewModel().of(context).title); // Add a title String to your ViewModel
},
)
,
);
```

The .of(context) method only works on an instance of your `ViewModel`
since [static members can't reference type parameters of a class](https://dart.dev/tools/diagnostic-messages?utm_source=dartdev&utm_medium=redir&utm_id=diagcode&utm_content=type_parameter_referenced_by_static#type_parameter_referenced_by_static).
If you want to save yourself the time it takes to type the extra parenthesis, add a separate method directly in your `View Model` (classes can't have
instance and static methods with the same name, hence the ".of_" vs ".of"):

```dart
class HomeViewModel extends ViewModel<HomeViewModel> {

  // Add this
  static HomeViewModel of_(BuildContext context) => getModel<HomeViewModel>(context);
}
```

To update your UI after a change in the `ViewModel`, you have two options.

1. Call `setState` to rebuild the entire widget tree inside your `ViewModelBuilder`
2. Use a combination of ValueNotifiers and ValueListenableBuilders to selectively rebuild parts of the UI

You can see examples of each of these approaches in the example directory.

## Advanced Usage

### Initialize and Dispose

Since the ViewModel object extends the State class, you can simply override [initState](https://api.flutter.dev/flutter/widgets/State/initState.html)
and [dispose](https://api.flutter.dev/flutter/widgets/State/dispose.html) to run code when the ViewModel is added and removed from the widget tree,
respectively:

```dart
class HomeViewModel extends ViewModel<HomeViewModel> {

  @override
  void initState() {
    debugPrint('Initialize');
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('Dispose');
    super.dispose();
  }
}
```

### Set Loading

ViewModels include a single ValueNotifier that can be used to mark it as "loading":

```dart

ValueNotifier<bool> loading = ValueNotifier(false);

bool get isLoading => loading.value;

void setLoading(bool val) {
  setState(() {
    loading.value = val;
  });
}
```

For example, you can call `model.setLoading(true)` when the ViewModel needs to load asynchronous data. When the data is loaded,
call `model.setLoading(false)`. In your UI, you can show a spinner if the loading value is true using the model directly. _Whenever the loading value
is changed, the entire UI inside the ViewModelBuilder will be rebuilt._

```dart
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewModelBuilder(
      builder: (context, model) {
        return Scaffold(
          appBar: AppBar(title: Text(model.title)),
          body: Stack(
            children: [
              Text('Hello World!')
              if (model.isLoading) const ColoredBox(color: Colors.black12, child: Center(child: CircularProgressIndicator()))
            ],
          ),
        );
      },
    );
  }
}
```

### Reuse ViewModels
#### Extend a ViewModel
To share logic between multiple ViewModels, create a separate ViewModel with the shared logic. Be sure to include the generic type T in the ViewModel class definition.

```dart
import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/foundation.dart';

class CounterViewModel<T> extends ViewModel<T> {
  ValueNotifier<int> counter = ValueNotifier(0);

  void increment() {
    setState(() {
      counter.value = counter.value + 1;
    });
  }
}
```

Then, extend the ViewModel in your other ViewModels. Pass the ViewModel type as the generic type T.

```dart
class OneViewModel extends CounterViewModel<OneViewModel> {
  static OneViewModel of_(BuildContext context) => getModel<OneViewModel>(context);
}
```

This approach is useful when the shared logic is simple and is only used in a few ViewModels.

#### ViewModel Mixins
If you want more granular control over the which shared logic each ViewModel can use, Mixins are a better approach. Create a mixin for each piece of shared logic (again, remember to include the generic type T in the mixin class definition):

```dart
mixin ColorMixin<T> on ViewModel<T>{
  ValueNotifier<Color> color = ValueNotifier(Colors.blue);
  
  void setColor(Color val){
    color.value = val;
  }
}
```

Then, extend the ViewModel and include the mixins you want to use.

```dart
class TwoViewModel extends CounterViewModel<TwoViewModel> with ColorMixin{
  static TwoViewModel of_(BuildContext context) => getModel<TwoViewModel>(context);
}
```

### Global Services

The CotR classes are meant to be used at the view level but there are situations where you need a service to be accessed throughout your entire app. 

For example, an authentication service that manages the user's information and authentication state can be utilized by your LoginView, HomeView, and FeedView for different reasons:


![Global service](https://github.com/CodeOTR/simple_mvvm/raw/main/assets/simple_mvvm_global.png)


You can implement this design using the simple_mvvm package by creating a new `ViewModel`/`ViewModelBuilder` and placing it at the root of your app's widget tree.

#### ViewModel

```dart
class AuthenticationViewModel extends ViewModel<AuthenticationViewModel> {
  bool loggedIn = false;
  String? name;
  String? email;

  void setLoggedIn(bool val) {
    setState(() => loggedIn = val);
  }

  void setName(String val) {
    setState(() => name = val);
  }

  void setEmail(String val) {
    setState(() => email = val);
  }

  static AuthenticationViewModel of_(BuildContext context) => getModel<AuthenticationViewModel>(context);
}
```

### ViewModelBuilder

```dart
class AuthenticationViewModelBuilder extends ViewModelBuilder<AuthenticationViewModel> {
  const AuthenticationViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => AuthenticationViewModel();
}
```
 Then you can add the new `ViewModelBuilder` at the root of your app:
 ```dart
 class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Service Demo',
      home: AuthenticationViewModelBuilder(builder: (context, model) {
        return const HomeView();
      }),
    );
  }
}
 ```

 Now, anywhere in your app you can access the AuthenticationViewModel ("service") like any other InheritedWidget:

 ```
 AuthenticationViewModel authModel = getModel<AuthenticationViewModel>(context);
 ```

## Testing
### Test a ViewModelBuilder

ViewModelBuilders are StatefulWidgets which means they need to be tested using the WidgetTester. They can be tested like any other widget as shown here.

```dart
  testWidgets('CounterViewModel UI test', (WidgetTester tester) async {
    // Setup - Arrange
    await tester.pumpWidget(MaterialApp(builder: (context, child) => const CounterView()));
    final CounterViewModel model = tester.state(find.byType(CounterViewModelBuilder));

    // finders
    final counterFinder = find.text('Counter');
    final incrementFinder = find.byIcon(Icons.add);
    final decrementFinder = find.byIcon(Icons.remove);

    expect(counterFinder, findsOneWidget);
    expect(incrementFinder, findsOneWidget);
    expect(decrementFinder, findsOneWidget);
  });
```
You can update the model directly to verify that the UI updates appropriately:

```dart
  testWidgets('CounterViewModel UI test', (WidgetTester tester) async {
    // Setup - Arrange
    await tester.pumpWidget(MaterialApp(builder: (context, child) => const CounterView()));
    final CounterViewModel model = tester.state(find.byType(CounterViewModelBuilder));

    model.setState(() => model.counter = 7);

    await tester.pump();

    // finders
    final countFinder = find.text('7');

    expect(countFinder, findsOneWidget);
  });
```

### Test a ViewModel

ViewModels in simple_mvvm are state objects so in order to test them, you need to build the corresponding StatefulWidget (ex. for the `CounterViewModel`, you need to build the `CounterViewModelBuilder`).

```dart
void main() {
  testWidgets('CounterViewModel smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(builder: (context, child) => const CounterView()));
  });
}
```

Once the ViewModelBuilder widget is added to the tree, you can use the [state method](https://api.flutter.dev/flutter/flutter_test/WidgetController/state.html) on WidgetTester to find the state object:
```dart
final CounterViewModel model = tester.state(find.byType(CounterViewModelBuilder));
```

With the model in hand, you can start test it's internal logic directly:

```dart
void main() {
  testWidgets('CounterViewModel smoke test', (WidgetTester tester) async {
    // Setup - Arrange
    await tester.pumpWidget(MaterialApp(builder: (context, child) => const CounterView()));
    final CounterViewModel model = tester.state(find.byType(CounterViewModelBuilder));

    // Action - Act
    model.increment();

    // Result - Assert
    expect(model.counter, 1);

    model.decrement();
    expect(model.counter, 0);
  });
}
```
<div class="alert alert--primary" role="alert">
  <a href="https://stackoverflow.com/a/42128652/12806961">See this StackOverflow answer by one of Flutter's lead engineers</a>
</div>

## IntelliJ Live Templates

### View

```dart
import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';
import '$snakeName$_model.dart';

class $Name$View extends StatelessWidget {
  const $Name$View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: $Name$ViewModelBuilder(
        builder: (context, model) {
          return Center(child: Text('$Name$'););
        },
      ),
    );
  }
}
```

### ViewModel and ViewModelBuilder

```dart
import 'package:simple_mvvm/simple_mvvm.dart';
import 'package:flutter/material.dart';

class $Name$ViewModelBuilder extends ViewModelBuilder<$Name$ViewModel> {
  const $Name$ViewModelBuilder({
    super.key,
    required super.builder,
  });

  @override
  State<StatefulWidget> createState() => $Name$ViewModel();
}

class $Name$ViewModel extends ViewModel<$Name$ViewModel> {
  static $Name$ViewModel of_(BuildContext context) => getModel<$Name$ViewModel>(context);
}
```

You can read more about using variables in Live
Templates [here](https://www.jetbrains.com/help/idea/template-variables.html#example_live_template_variables).

## VS Code Snippets

### View
```
"Simple MVVM View": {
			"prefix": "simpleView",
			"body": [
				"import 'package:auto_route/annotations.dart';",
				"import 'package:auto_route/auto_route.dart';",
				"import 'package:flutter/material.dart';",
				"import '${TM_FILENAME_BASE/(.*)/${1:/downcase}/}_model.dart';",
				"",
				"@RoutePage()",
				"class ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/} extends StatelessWidget {",
				"  const ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/}({Key? key}) : super(key: key);",
				"",
				"  @override",
				"  Widget build(BuildContext context) {",
				"    return ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/}Builder(",
				"        builder: (context, model) {",
				"          return Scaffold(",
				"            appBar: AppBar(",
				"              title: Text('${4:Home}'),",
				"            ),",
				"            body: Center(",
				"              child: Text('${4:Home}'),",
				"            )",
				"          );",
				"        },",
				"      );",
				"  }",
				"}"
			],
			"description": "Creates a new Simple MVVM View"
		},
```

### ViewModel and ViewModelBuilder
```
"Simple MVVM ViewModel": {
				"prefix": "simpleViewModel",
				"body": [
					"import 'package:simple_mvvm/simple_mvvm.dart';",
					"import 'package:flutter/material.dart';",
					"",
					"class $${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/}Builder extends ViewModelBuilder<${TM_FILENAME/(.*)/${1:/pascalcase}/}> {",
					"  const ${1:HomeViewModelBuilder}({",
					"    super.key,",
					"    required super.builder,",
					"  });",
					"",
					"  @override",
					"  State<StatefulWidget> createState() => ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/}();",
					"}",
					"",
					"class ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/} extends ViewModel<${TM_FILENAME/(.*)/${1:/pascalcase}/}> {",
					"   static ${TM_FILENAME_BASEs/(.*)/${1:/pascalcase}/} of_(BuildContext context) => getModel<${TM_FILENAME/(.*)/${1:/pascalcase}/}>(context);",
					"}"
				],
				"description": "Creates a new Flutter Simple MVVM ViewModel"
			}
```

You can read more about creating VS Code Snippets [here](https://code.visualstudio.com/docs/editor/userdefinedsnippets).