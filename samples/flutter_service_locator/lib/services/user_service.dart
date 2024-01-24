import 'package:flutter/material.dart';

class UserService {
  ValueNotifier<String?> first = ValueNotifier('John');

  void setFirst(String? val) {
    first.value = val;
  }

  ValueNotifier<String?> last = ValueNotifier('Doe');

  void setLast(String? val) {
    last.value = val;
  }

  ValueNotifier<String?> userName = ValueNotifier('jdoe');

  void setUserName(String? val) {
    userName.value = val;
  }

  String getFullName() {
    return '${first.value} ${last.value}';
  }
}
