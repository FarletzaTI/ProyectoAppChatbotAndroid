import 'package:app_prueba/models/solicitude_model.dart';
import 'package:flutter/material.dart';

class ContactCustomerprovider with ChangeNotifier {
  List<SolicitudeModel> _solicitudeModelList = [];
  List<SolicitudeModel> get solicitudeModelList => this._solicitudeModelList;

  saveSolicitude(SolicitudeModel solicitude) {
    _solicitudeModelList.add(solicitude);
    notifyListeners();
  }

  emptySolicitude({bool refresh = false}) {
    _solicitudeModelList = [];
    if (refresh) notifyListeners();
  }

  SolicitudeModel getSolicitude(int idSolicitude) {
    return _solicitudeModelList
        .where((element) => element.idsolicitud == idSolicitude)
        .first;
  }

  setSolicitude(SolicitudeModel solicitudeModel) {
    print(_solicitudeModelList);
    List<SolicitudeModel> solicitudeModelList = [
      ..._solicitudeModelList.map((e) {
        if (e.idsolicitud == solicitudeModel.idsolicitud) e = solicitudeModel;
        return e;
      }).toList()
    ];
    _solicitudeModelList = solicitudeModelList;
    //Actualizar memoria
    print(_solicitudeModelList);
    notifyListeners();
  }
}
