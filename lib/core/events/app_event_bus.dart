import 'dart:async';
import 'app_event.dart';

class AppEventBus {
  AppEventBus._();

  static final AppEventBus instance = AppEventBus._();

  final _controller = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get stream => _controller.stream;

  void emit(AppEvent event) => _controller.add(event);

  Future<void> dispose() async => _controller.close();
}
