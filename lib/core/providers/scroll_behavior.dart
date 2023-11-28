import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class ScrollBehavior extends _$ScrollBehavior {

  void enable(bool value) {
    state = value;
  }
}
