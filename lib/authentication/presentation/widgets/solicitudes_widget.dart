//@dart=2.9
import 'package:app_prueba/models/solicitudes.dart';
import 'package:app_prueba/services/requests.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'contactarCliente.dart';

class SolicitudesView extends StatelessWidget {
  final String titulo;
  final String param;
  const SolicitudesView({Key key, this.titulo, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _createSearchView(),
        SizedBox(
          height: 12,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(titulo),
        ),
        SizedBox(
          height: 12,
        ),
        FutureBuilder(
            future: NetworkHelper.attemptConsultRequest(param, context),
            builder: (context, AsyncSnapshot<List<Solicitude>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cliente = snapshot.data[index];
                    return Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(cliente.nombre),
                            leading: Icon(MdiIcons.account),
                            subtitle: Text(
                                "#Solicitud: ${cliente.idsolicitud}, Origen: ${cliente.paisOrigen}, Destino: ${cliente.paisDestino}"),
                            onTap: () {
                              final route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ClientDetailPage(
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
                );
              }
              return CircularProgressIndicator();
            })
      ],
    );
  }
}
