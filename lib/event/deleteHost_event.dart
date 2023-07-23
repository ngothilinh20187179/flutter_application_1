import 'package:flutter_application_1/model/host.dart';

import '../base/base_event.dart';

class DeleteHostEvent extends BaseEvent {
  Host host;
  DeleteHostEvent(this.host);
}