//@dart=2.9
import 'package:app_prueba/models/contactosagentes.dart';
import 'package:flutter/material.dart';

class AgentContactModalPage extends StatelessWidget {
  final List<MediosdeContacto> listaEmail;
  final List<MediosdeContacto> listaTelf;
  final Function(String) cambiarEmail;
  final Function(String) cambiarTelf;

  const AgentContactModalPage(
      {Key key,
      this.listaEmail,
      this.listaTelf,
      this.cambiarEmail,
      this.cambiarTelf})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: Column(
        children: [
          Text("Email"),
          Container(
              height: 200,
              child: ContactRadioListView(
                changeValue: cambiarEmail,
                listElements: listaEmail,
              )),
          Text("telf"),
          Container(
              height: 200,
              child: ContactRadioListView(
                changeValue: cambiarTelf,
                listElements: listaTelf,
              )),
        ],
      ),
    );
  }
}

class ContactRadioListView extends StatefulWidget {
  final List<MediosdeContacto> listElements;
  final Function(String) changeValue;
  const ContactRadioListView({Key key, this.listElements, this.changeValue})
      : super(key: key);

  @override
  _ContactRadioListViewState createState() => _ContactRadioListViewState();
}

class _ContactRadioListViewState extends State<ContactRadioListView> {
  String variable = "";
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
        itemCount: widget.listElements.length,
        itemBuilder: (BuildContext context, int index) {
          return RadioListTile(
            value: widget.listElements[index].valor,
            groupValue: variable,
            onChanged: (value) {
              setState(() {
                widget.changeValue(value);
                variable = value;
                print(value);
              });
            },
            title: Text(widget.listElements[index].valor),
          );
        });
  }
}

class AgentContactModal extends StatefulWidget {
  final List<MediosdeContacto> listaEmail;
  final List<MediosdeContacto> listaTelf;
  final Function(String) cambiarEmail;
  final Function(String) cambiarTelf;
  const AgentContactModal(
      {Key key,
      this.listaEmail,
      this.listaTelf,
      this.cambiarEmail,
      this.cambiarTelf})
      : super(key: key);

  @override
  _AgentContactModalState createState() => _AgentContactModalState();
}

class _AgentContactModalState extends State<AgentContactModal> {
  String email = "";
  String telefono = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      child: Column(
        children: [
          Text("Seleccionar información de contacto"),
          Text("Seleccionar un email"),
          Container(
            height: 150,
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                itemCount: widget.listaEmail.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    value: widget.listaEmail[index].valor,
                    groupValue: email,
                    onChanged: (value) {
                      setState(() {
                        widget.cambiarEmail(value);
                        email = value;
                        print(value);
                      });
                    },
                    title: Text(widget.listaEmail[index].valor),
                  );
                }),
          ),
          Text("Seleccionar un teléfono"),
          Container(
            height: 150,
            child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                    ),
                itemCount: widget.listaTelf.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    value: widget.listaTelf[index].valor,
                    groupValue: email,
                    onChanged: (value) {
                      setState(() {
                        widget.cambiarTelf(value);
                        email = value;
                      });
                    },
                    title: Text(widget.listaTelf[index].valor),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
