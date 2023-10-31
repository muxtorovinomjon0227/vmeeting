import 'dart:async';

class NumberController {
  final StreamController<bool> themeController = StreamController<bool>.broadcast();
  Sink<bool> get inputTheme => themeController.sink;
  Stream<bool> get outputTheme => themeController.stream;

}
