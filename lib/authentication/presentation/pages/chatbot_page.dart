//@dart=2.9

import 'package:app_prueba/authentication/presentation/widgets/contactarCliente.dart';
import 'package:app_prueba/authentication/presentation/widgets/solicitudes_widget.dart';
import 'package:app_prueba/models/solicitudes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBotPage extends StatefulWidget {
  ChatBotPage({Key key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage>
    with SingleTickerProviderStateMixin {
  List<Solicitude> _solicitudes = [];
  int vendedorId = 0;
  bool isLoadData = true;

  //late TabController _controller;

  @override
  void initState() {
    // _controller = TabController(length: 2, vsync: this);
    _loadIdVendedor();
    super.initState();
  }

  _loadIdVendedor() async {
    final prefs = await SharedPreferences.getInstance();
    vendedorId = prefs.getInt("vendedorId") ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Solicitudes'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Pendientes',
              ),
              Tab(
                text: 'Finalizades',
              ),
              Tab(
                text: 'Todas',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SolicitudesView(
              titulo: 'Pendientes',
              param: 'A',
            ),
            SolicitudesView(
              titulo: 'Finalizadas',
              param: 'F',
            ),
            SolicitudesView(
              titulo: 'Todas',
              param: 'T',
            )
          ],
        ),
      ),
    );
  }

  _createSearchView() => Container(
        decoration: BoxDecoration(border: Border.all(width: 1.0)),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Busca por nombre",
          ),
          textAlign: TextAlign.center,
        ),
      );

  _vista1({String title}) => Column(
        children: [
          _createSearchView(),
          SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(title),
          ),
          SizedBox(
            height: 12,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _solicitudes.length,
            itemBuilder: (BuildContext context, int index) {
              final cliente = _solicitudes[index];
              return Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(cliente.nombre),
                      subtitle: Text("Su email es: ${cliente.email}"),
                      onTap: () {
                        final route = MaterialPageRoute(
                            builder: (BuildContext context) => ClientDetailPage(
                                  solicitude: cliente,
                                ));
                        Navigator.push(context, route);
                      },
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          ),
        ],
      );
}
