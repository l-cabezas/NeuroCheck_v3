import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/resources/Strings.dart';

class TextFieldsForm {
  late TextEditingController emailController;
  late TextEditingController? nameController;
  late TextEditingController? passwordController;
  late TextEditingController? passwordController2;
  late TextEditingController? supervisedNameController;

  TextFieldsForm(
      this.emailController,
      [this.passwordController, this.passwordController2,
        this.nameController]
      );

  Widget getName(BuildContext context){
    return TextFormField(
      autocorrect: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          focusColor: Theme.of(context).bottomAppBarColor,
          labelText: 'Nombre',
          labelStyle:  TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).bottomAppBarColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
            //  when the TextFormField in unfocused
          ) ,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
            //  when the TextFormField in focused
          ) ,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.person_outlined,
            color: Theme.of(context).bottomAppBarColor
          )
      ),
      validator:(val){
        if(val!.isEmpty){
          return 'Inserte nombre';
        }else{
          return null;
        }
      } ,
    );
  }

  Widget getEmail(BuildContext context){
    return TextFormField(
      autocorrect: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          focusColor: Theme.of(context).bottomAppBarColor,
          labelText: 'Email',
          labelStyle:  TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).bottomAppBarColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
            //  when the TextFormField in unfocused
          ) ,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).bottomAppBarColor),
            //  when the TextFormField in focused
          ) ,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.email_outlined,
            color: Theme.of(context).bottomAppBarColor
          )

      ),

      validator: (value) {
        if (value!.isEmpty) {
          return 'Introduce Email';
        } else if (!value.contains('@')) {
          return 'Por favor Introduce un email válido';
        }
        return null;
      },
    );
  }

  Widget space(double altura){
    return SizedBox(
      height: altura,
    );
  }

  Widget getPassword(BuildContext context, bool passwordVisible) {
    return //Column(children: [
      TextFormField(
        obscureText: passwordVisible,
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            focusColor: Theme.of(context).bottomAppBarColor,
            labelText: 'Contraseña',
            labelStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).bottomAppBarColor),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).bottomAppBarColor),
              //  when the TextFormField in unfocused
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).bottomAppBarColor),
              //  when the TextFormField in focused
            ),
            border: const OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Theme.of(context).bottomAppBarColor
            ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Introduzca contraseña';
          } else if (value.length < 6) {
            return 'La contraseña tiene que ser mínimo de 6 caracteres!';
          } else
            if(passwordController2 !=null){
              if (passwordController?.text != passwordController2?.text) {
                  return 'Las contraseñas no coinciden';
              }
            }
          return null;
        },
      );

  }

  Widget getPassword2(BuildContext context, bool passwordVisible){
    return TextFormField(
        obscureText: passwordVisible,
        controller: passwordController2,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            focusColor: Theme.of(context).bottomAppBarColor,
            labelText: Strings.password2,
            labelStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).bottomAppBarColor
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).bottomAppBarColor),
              //  when the TextFormField in unfocused
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).bottomAppBarColor),
              //  when the TextFormField in focused
            ),
            border: const OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: Theme.of(context).bottomAppBarColor
            )
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Introduzca contraseña';
          } else if (value.length < 6) {
            return 'La contraseña tiene que ser mínimo de 6 caracteres!';
          } else if(passwordController2 !=null){
            if (passwordController?.text != passwordController2?.text) {
              return 'Las contraseñas no coinciden';
            }
          }
          return null;
        });
  }

  Border border34(BuildContext context){
    return Border(
      top: BorderSide(color: Theme.of(context).bottomAppBarColor),
      left: BorderSide(color: Theme.of(context).bottomAppBarColor),
      bottom: BorderSide(color: Theme.of(context).bottomAppBarColor),
    );
  }

  Widget haveAccount(BuildContext context){
    return  CupertinoButton(
            child:  const Text("Ya tengo una cuenta",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 15
                    //color: Theme.of(context).bottomAppBarColor
                )),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            });
  }


  

}





