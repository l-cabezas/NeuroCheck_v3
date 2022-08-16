import 'package:flutter/cupertino.dart';
import 'package:neurocheck/presentation/account/textFieldsForm.dart';

import '/behaviors/hiddenScrollBehavior.dart';
import '/domain/resources/Strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//HiddenScrollBehavior

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late String _email;
  final auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  //TextEditingController emailcontroller = TextEditingController();
  TextFieldsForm logic = TextFieldsForm(TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
          title: Text('Reset Password',
              style: TextStyle(
                  color: Theme.of(context).textTheme.titleLarge?.color)),
        ),
        key: _scaffoldKey,
        body: Container(
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.all(25.0),
            child: ScrollConfiguration(
                behavior: HiddenScrollBehavior(),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[

                      logic.space(5),
                      logic.getEmail(context),
                      logic.space(20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CupertinoButton.filled(
                            child: const Text('Restaurar contraseña'),
                            onPressed: () {
                              auth.sendPasswordResetEmail(email: logic.emailController.text.trim());
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
