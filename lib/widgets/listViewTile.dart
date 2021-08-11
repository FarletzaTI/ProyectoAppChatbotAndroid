// @dart=2.9
import 'package:app_prueba/models/carga.dart';
import 'package:flutter/material.dart';

class CargaListTile extends StatelessWidget {
  final Carga carga;
  final VoidCallback onTap;

  const CargaListTile({Key key, this.carga, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(carga.cantidad.toString()),
          Text("Cant."),
        ],
      ),
      title: Text('${carga.descripcion}',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontSize: 16)),
      subtitle: carga.tipoCarga == 8 || carga.tipoCarga == 9 ? Text("Temp: ${carga.temperatura} - Ventilacion: ${carga.ventilacion}"): Text(""),
      onTap: onTap,
    );
  }
}
