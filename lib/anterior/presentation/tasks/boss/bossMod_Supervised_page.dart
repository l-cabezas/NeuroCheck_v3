
import '/domain/users/GestionUsuarios.dart';
import '/presentation/mensajes/showInfo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../behaviors/hiddenScrollBehavior.dart';
import '/domain/resources/Strings.dart';
import '/data/global_var/globals.dart' as globals;

import '../../providers/task_provider.dart';



class BossModSupervisedPage extends StatefulWidget {
  @override
  _BossModSupervisedPageState createState() => _BossModSupervisedPageState();
}

class _BossModSupervisedPageState extends State<BossModSupervisedPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  TextEditingController email_Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //GestionUsuarios addUsuarios = GestionUsuarios();

  @override
  Widget build(BuildContext context) {

    var taskProvider= Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Cambiar supervisado',
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,)
      ),
        key: _scaffoldKey,
        body: Container(
              color: Theme.of(context).primaryColorLight,
              padding: const EdgeInsets.all(25.0),
              //en caso de pantallas pequeñas no se derbode teclado
              child: ScrollConfiguration(
            behavior: HiddenScrollBehavior(),
            child: Form(
            key: _formKey,
            child: ListView(
            children: <Widget>[
                  const SizedBox(
                  height: 30,
                  ),
              TextFormField(
                autocorrect: false,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusColor: Theme.of(context).bottomAppBarColor,
                    labelText: 'Email',
                    labelStyle:  TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).bottomAppBarColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
                      //  when the TextFormField in unfocused
                    ) ,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
                      //  when the TextFormField in focused
                    ) ,
                    border: const UnderlineInputBorder()
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tienes que introducir un email';
                  } else if (!value.contains('@')) {
                    return 'Por favor introduce un email válido!';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autocorrect: false,
                controller: email_Controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusColor: Theme.of(context).bottomAppBarColor,
                    labelText: 'Repita email',
                    labelStyle:  TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).bottomAppBarColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
                      //  when the TextFormField in unfocused
                    ) ,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
                      //  when the TextFormField in focused
                    ) ,
                    border: const UnderlineInputBorder()
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tienes que introducir un email';
                  } else if (!value.contains('@')) {
                    return 'Por favor introduce un email válido!';
                  }if(email_Controller.text != emailController.text){
                    return 'No coinciden!';}
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),


            const SizedBox(
              height: 15,
            ),
            Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  FloatingActionButton.extended(
                    heroTag: "mod_Supervisado",
                    //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //addUsuarios.changeSupervisado(email_Controller,context);

                        taskProvider.cambiarSupervisado(email_Controller.text);
                        ShowInfo().showDismissableFlushbar(context, 'Supervisado cambiado correctamente');
                        Navigator.of(context).pushReplacementNamed('/main');

                        //var email = usuariosProvider.getUsuario(user_email);
                      }
                    },
                    label: const Text('Cambiar'),
                  ),
                ]
            ),
    ]
    )
    )
    ),
    ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    email_Controller.dispose();
  }


}