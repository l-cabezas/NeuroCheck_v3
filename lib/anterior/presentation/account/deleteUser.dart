import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neurocheck/presentation/account/textFieldsForm.dart';

import '../../behaviors/hiddenScrollBehavior.dart';
import '../../device/shared_preferences/shared_preferences.dart';
import '../mensajes/showInfo.dart';

class DeleteUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeleteUserPage();
}

class _DeleteUserPage extends State<DeleteUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool _passwordVisible = true;

  final TextFieldsForm logic = TextFieldsForm(
    TextEditingController(),
    TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
      ),
      key: _scaffoldKey,
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(25.0),
        //en caso de pantallas pequeñas no se derbode teclado
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                logic.getEmail(context),
                logic.space(30),
                Row(
                  children: [
                    SizedBox(
                        width: 305,
                        child: logic.getPassword(context, _passwordVisible)),
                    const SizedBox(
                      width: 5,
                    ),
                    iconButton(),
                  ],
                ),
                //getPassword(context),
                logic.space(30),
                Row(
                  children: [
                    SizedBox(
                        width: 305,
                        child: logic.getPassword2(context, _passwordVisible)),
                    const SizedBox(
                      width: 5,
                    ),
                    iconButton(),
                  ],
                ),
                logic.space(35),
                deletebutton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  Widget iconButton() {
    return IconButton(
      onPressed: () {
        _togglePasswordView();
      },
      icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: Theme.of(context).bottomAppBarColor),
    );
  }

  Widget deletebutton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: isLoading
          ? const CupertinoActivityIndicator()
          : CupertinoButton.filled(
        onPressed: () {
          if (_formKey.currentState!.validate()) {

            FirebaseAuth.instance.currentUser?.delete().then((value) {
              SharedPreferencesDatos().removeValuesUser();
              ShowInfo().showDismissableFlushbar(context, '  Cuenta borrada  ');

              logic.emailController.clear();
              logic.passwordController?.clear();
              logic.passwordController2?.clear();

              Navigator.pushReplacementNamed(context, '/login');
            });
          }
        },
        child: const Text('Borrar Cuenta'),
      ),
    );
  }
}
