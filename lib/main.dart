import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/hostList_bloc.dart';
import 'package:flutter_application_1/event/addHost_event.dart';
import 'package:flutter_application_1/event/deleteHost_event.dart';
import 'package:provider/provider.dart';

//import 'db/comfySSH_database.dart';
import 'model/host.dart';

void main() {
  //await ComfySSHDatabase.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text("Host")),
          body: Provider<HostListBloc>.value(value: HostListBloc(),
          child: const HostListContainer(),),
        )
    );
  }
}

class HostListContainer extends StatelessWidget {
  const HostListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(children: <Widget>[
        HostListHeader(),
        SizedBox(height: 20,),
        Expanded(child: HostListData())
      ]),
    );
  }
}

class HostListHeader extends StatelessWidget {
  const HostListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var txtController = TextEditingController();
    var bloc = Provider.of<HostListBloc>(context);

    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: txtController,
            decoration: const InputDecoration(hintText: "Add new"),
          ),
        ),
        ElevatedButton.icon(
            onPressed: () {
              bloc.event.add(AddHostEvent(txtController.text));
            },
            icon: const Icon(Icons.add),
            label: const Text("Add"))
      ],
    );
  }
}

class HostListData extends StatefulWidget {
  const HostListData({super.key});

  @override
  State<HostListData> createState() => _HostListDataState();
}

class _HostListDataState extends State<HostListData> {

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   var bloc = Provider.of<HostListBloc>(context);
  //   bloc.getAllHosts();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<HostListBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Host>> (
        stream: bloc.hostListStream,
        builder: (contex, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].content),
                    trailing: GestureDetector(
                    onTap: () {
                      bloc.event.add(DeleteHostEvent(snapshot.data![index]));
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red[500],
                      ),
                    ),
                  );
                  });
            case ConnectionState.none:
            case ConnectionState.waiting:
            default: 
              return Center(
                child: Container(
                  width: 70,
                  height: 70,
                  child: const CircularProgressIndicator(),
                ),
              );
          }
        },
      ));
  }
}