import 'dart:async';
import 'package:flutter/material.dart';

import 'base_event.dart';

abstract class BaseBloc {
  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;
  
  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      // ignore: unnecessary_type_check
      if (event is! BaseEvent) {
        throw Exception("Event ko hop le");
      }
      dispatchEvent(event);
    });
  }
  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
