import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '/domain/users/GestionUsuarios.dart';
import '/domain/notification/SendNotification.dart';
import '/domain/competicion/CompeticionUsuarios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/domain/resources/Strings.dart';
import '/data/global_var/globals.dart' as globals;

class CompetitionPage extends StatefulWidget {
  @override
  _CompetitionPageState createState() => _CompetitionPageState();
}

class _CompetitionPageState extends State<CompetitionPage>{
  GestionUsuarios gestionUsuarios = GestionUsuarios();
  SendNotificacion sendNotificacion = SendNotificacion();
  CompeticionUsuarios tablaUsuarios = CompeticionUsuarios();
  /*var BaseDatos = FirebaseFirestore.instance
      .collection('competicion')
      .doc(globals.user_email);*/

  final TextEditingController _textFieldController = TextEditingController();

  late bool sort;
  List<String> list = [];

  late String codeDialog;
  late String valueText;

  String sele = '';

  @override
  void initState() {
    super.initState();
    var competidoresProvider= Provider.of<TaskProvider>(context, listen: false);
    competidoresProvider.showDatosCompeticion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SizedBox(
              height: MediaQuery.of(context).size.height - 60.0,
              child: Column(
                children: [
                  myInfo(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: const Color(0xff5a348b),
                        gradient: const LinearGradient(
                            colors: [Color(0xff8d70fe), Color(0xff2da9ef)],
                            begin: Alignment.centerRight,
                            end: Alignment(-1.0, -1.0)), //Gradient
                      ),
                      child: buildInfo(context),
                    ),
                  ),
                  //botonAmigo()
                ],
              ))),
      floatingActionButton: botonAmigo(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  Widget myInfo() {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: const Text(
            'Tabla de puntos',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataTable(
        dataRowHeight: 50,
        columns: const [
          DataColumn(
              label: Text("Nombre",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold))),
          DataColumn(label: Text("")),
          DataColumn(
              label: SizedBox(
            width: 0,
          )),
          DataColumn(
              label: Text("Puntos",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold))),
        ],
        rows: const [],
      )
    ]);
  }

  final Widget _verticalDivider = const VerticalDivider(
    color: Colors.black,
    thickness: 2,
  );


  Widget buildInfo(BuildContext context) {
    var competidoresProvider= Provider.of<TaskProvider>(context, listen: false);
    if(competidoresProvider.competidores.isEmpty){
      //print(taskProvider.listaTareas.isEmpty);
      if(competidoresProvider.listaTareas.isEmpty){return const Text('');}
      return const Center(child: CupertinoActivityIndicator(radius: 25,));
    }
    return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: competidoresProvider.competidores.length,
            itemBuilder: (BuildContext context, int index) {
              var competidor = competidoresProvider.competidores[index];
              var nombreCompetidor =competidor.nombre;
              var puntos = competidor.puntos;

              return Column(children: <Widget>[
                DataTable(
                  columnSpacing: 0,
                  headingRowHeight: 0,
                  dataRowHeight: 50,
                  sortAscending: false,
                  columns: [
                    const DataColumn(label: Text("")),
                    DataColumn(label: _verticalDivider),
                    const DataColumn(
                        label: SizedBox(
                          width: 0,
                        )),
                    const DataColumn(label: Text("")),
                  ],
                  rows: _createRows(nombreCompetidor, puntos, index),
                )
              ]);
            })
          );
  }
  /*Widget buildInfo() {
    return ListView(shrinkWrap: true, children: [
      StreamBuilder(
          stream: BaseDatos.collection('amigos')
              .orderBy('puntos', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            print(snapshot.data?.docs.length);
            if (!snapshot.hasData) {
              return Text('');//Text('cargando'); //GFLoader(type:GFLoaderType.ios);
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var nombre_competicion =
                        snapshot.data?.docs[index]['nombre'];
                    var puntos = snapshot.data?.docs[index]['puntos'];

                    return Column(children: <Widget>[
                      DataTable(
                        columnSpacing: 0,
                        headingRowHeight: 0,
                        dataRowHeight: 50,
                        sortAscending: false,
                        columns: [
                          DataColumn(label: Text("")),
                          DataColumn(label: _verticalDivider),
                          DataColumn(
                              label: SizedBox(
                            width: 0,
                          )),
                          DataColumn(label: Text("")),
                        ],
                        rows: _createRows(nombre_competicion, puntos, index),
                      )
                    ]);
                  });
            }
          })
    ]);
  }*/

  List<DataRow> _createRows(String nombre, var puntos, int index) {
    return [
      DataRow(cells: [
        DataCell(SizedBox(
            height: 20,
            width: 20,
            child: (index == 0)
                ? const Image(image: AssetImage('assets/medal.png'))
                : const Image(image: AssetImage('assets/military-rank.png')))),
        const DataCell(SizedBox(
          width: 10,
        )),
        DataCell(SizedBox(
            width: 180, //SET width
            child: Text(nombre,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                )))),
        DataCell(SizedBox(
            width: 180, //SET width
            child: Text(
              puntos.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ))),
      ]),
    ];
  }

  Widget botonAmigo() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent, // Background color
        onPrimary: Colors.white, // Text Color (Foreground color)
      ),
      onPressed: () {
        displayTextInputDialog(context);
        //Navigator.of(context).pushNamed('/addAmigo');
      },
      icon: const Icon(Icons.add),
      label: const Text('Añadir amigo'),
    );
  }

  chooseText() {
    tablaUsuarios.getAmigos(valueText, context);
    sele = '';
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Introduce email'),
            content: TextField(
                onChanged: (value) {
                  setState(() {
                    valueText = value;
                  });
                },
                controller: _textFieldController,
                //decoration: InputDecoration(hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: Strings.email,
                  labelStyle: const TextStyle(color: Color(0xff001858)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Color(0xff001858),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: Color(0xff001858),
                      width: 1.0,
                    ),
                  ),
                )),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    sele = 'cancel';
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  tablaUsuarios.getAmigos(valueText, context);
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
