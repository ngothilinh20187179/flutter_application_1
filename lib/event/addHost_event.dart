import '../base/base_event.dart';

class AddHostEvent extends BaseEvent {
  String content;
  AddHostEvent(this.content);
}