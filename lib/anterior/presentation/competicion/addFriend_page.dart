import '/behaviors/hiddenScrollBehavior.dart';
import '/domain/competicion/CompeticionUsuarios.dart';
import '/domain/resources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../domain/users/GestionUsuarios.dart';
import '../../domain/notification/SendNotification.dart';

class AddFriendPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController nombreTarea = TextEditingController();
  TextEditingController rangoH = TextEditingController();


  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('usuarios');
  GestionUsuarios gestionUsuarios = GestionUsuarios();
  SendNotificacion sendNotificacion = SendNotificacion();
  CompeticionUsuarios tablaUsuarios = CompeticionUsuarios();

  TextEditingController emailController = TextEditingController();
  var email_amigo = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdf7f3),
      body: Container(
        child: buildPage(),
      ),
    );
  }

  Widget buildPage() {
    return Scaffold(
      //para poder presentar menus contextuales con info al usuario
      // lo que serian Toast
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(25.0),
        //en caso de pantallas pequeñas no se derbode teclado
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              const Text('Email:', style: TextStyle(fontSize: 18)),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autocorrect: false,
                controller: emailController,
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
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Introduce Email';
                  } else if (!value.contains('@')) {
                    return 'Por favor Introduce un email válido';
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    email_amigo = emailController.text;
                  });
                },
              ),
              const SizedBox(height: 20,),
              boton()
            ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  Widget boton() {
    return FloatingActionButton.extended(
      heroTag: "add_friend",
      tooltip: 'añadir amigo',
      //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
      backgroundColor: const Color(0xff2b56bd),
      foregroundColor: Colors.white,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          tablaUsuarios.getAmigos(emailController.text,context);
          setState(() {});
        }
      },
      label: const Text('Añadir'),
    );
  }

}
