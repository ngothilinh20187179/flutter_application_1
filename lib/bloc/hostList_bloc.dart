// ignore: file_names
import 'dart:async';
import 'package:flutter_application_1/base/base_event.dart';
import 'package:flutter_application_1/db/host_table.dart';
import 'package:flutter_application_1/event/addHost_event.dart';
import 'package:flutter_application_1/event/deleteHost_event.dart';
import 'dart:math';
import '../base/base_bloc.dart';
import '../model/host.dart';

class HostListBloc extends BaseBloc {
  HostTable _hostTable = HostTable();

  final StreamController<List<Host>> _hostListStreamController =
      StreamController<List<Host>>();
  
  Stream<List<Host>> get hostListStream => _hostListStreamController.stream;
  
  List<Host> _hostListData = [];

  var randomId = Random();

  getAllHosts() async{
    _hostListData = await _hostTable.selectAllHosts();
    if (_hostListData == []) {
      return;
    }
    _hostListStreamController.sink.add(_hostListData); // đẩy data mới ra
  }

  _addHost(Host host) {
    //await _hostTable.insertHost(host);

    _hostListData.add(host);
    _hostListStreamController.sink.add(_hostListData); // đẩy data mới ra
  }

  _deleteHost(Host host) {
    //await _hostTable.deleteHost(host);

    _hostListData.remove(host);
    _hostListStreamController.sink.add(_hostListData);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddHostEvent) {
      Host host = Host(randomId.nextInt(1000), event.content);
      _addHost(host);
    } else if (event is DeleteHostEvent) {
      _deleteHost(event.host);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _hostListStreamController.close();
  }
}