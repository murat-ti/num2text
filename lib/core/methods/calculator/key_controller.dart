import 'dart:async';
import 'key_event.dart';

abstract class KeyController {
  static StreamController controller = StreamController();

  static Stream get _stream => controller.stream;

  static StreamSubscription listen(Function handler) {
    if(controller.isClosed) {
      controller = StreamController();
    }
    return _stream.listen(handler as dynamic);
  }

  static void fire(KeyEvent event) {
    //if(!controller.isClosed) {
      controller.add(event);
    //}
  }

  static dispose() => controller.close();
}
