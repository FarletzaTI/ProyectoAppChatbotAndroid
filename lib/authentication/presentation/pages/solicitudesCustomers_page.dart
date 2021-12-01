//@dart=2.9
import 'package:app_prueba/authentication/presentation/widgets/solicitud_widgetCus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class solicitudesCustomerPage extends StatefulWidget {
  solicitudesCustomerPage({Key key}) : super(key: key);

  @override
  _solicitudesCustomerstate createState() => _solicitudesCustomerstate();
}

class _solicitudesCustomerstate extends State<solicitudesCustomerPage> {
  int customerId = 0;

  @override
  void initState() {
    _loadIdVendedor();
    super.initState();
  }

  _loadIdVendedor() async {
    final prefs = await SharedPreferences.getInstance();
    customerId = prefs.getInt("vendedorId") ?? 0;
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
                text: 'Finalizadas',
              ),
              Tab(
                text: 'Todas',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            SolicitudesViewCus(
              titulo: 'Pendientes',
              param: 'A',
            ),
            SolicitudesViewCus(
              titulo: 'Finalizadas',
              param: 'F',
            ),
            SolicitudesViewCus(
              titulo: 'Todas',
              param: 'T',
            )
          ],
        ),
      ),
    );
  }
}
