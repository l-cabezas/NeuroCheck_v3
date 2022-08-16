import 'package:shared_preferences/shared_preferences.dart';
/*
* para checkear valores
* SharedPreferences prefs = await SharedPreferences.getInstance();
  bool CheckValue = prefs.containsKey('value');
* */

// uid, uidSupervisado, contraseña, rol, nombre

class SharedPreferencesDatos {

//------------------------UID USER-------------------------------
  setUID_userToSF(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uidUser', valor);
  }

  Future<String?> getUID_userToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('uidUser');
    return stringValue;
  }


//------------------------Name USER-------------------------------
  setNameToSF(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nameUser', valor);
  }

  Future<String?> getNameToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('nameUser');
    return stringValue;
  }

  //------------------------Email USER-------------------------------
  setEmailToSF(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emailUser', valor);
  }

  Future<String?> getEmailToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('emailUser');
    return stringValue;
  }

  //------------------------Email USER-------------------------------
  setEmailSupervisedToSF(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('emailSupervised', valor);
  }

  Future<String?> getEmailSupervisedToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('emailSupervised');
    return stringValue;
  }

//------------------------Name Supervised-------------------------------
  setSuperviseNameToSF(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nameSupervised', valor);
  }

  Future<String?> getSuperviseNameToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('nameSupervised');
    return stringValue;
  }

//------------------------PASSWORD USER-------------------------------
   setPassword_userToSF(String valor) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('password_user', valor);
   }

  Future<String?> getPassword_userToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('password_user');
    return stringValue;
  }



//----------------------------UID SUPERVISADO---------------------------
   setUID_SupervisedToSF(String valor) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setString('uid_supervised', valor);
   }

  Future<String?> getUID_SupervisedToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('uid_supervised');
    return stringValue;
  }



//------------------------PASSWORD SUPERVISADO-------------------------------
  setPassword_SupervisedToSF(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password_supervised', valor);
  }

  Future<String?> getPassword_SupervisedToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('password_supervised');
    return stringValue;
  }


//-------------------------UID ROL------------------------------

  setRolToSF(String valor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('rol', valor);
  }

  Future<String?> getRolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('rol');
    return stringValue;
  }




/*
* If the value is not present in the storage then we might get a null value.
To handle this we can use

int intValue= await prefs.getInt('intValue') ?? 0;
* */

//borrar datos

  removeValuesUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("uidUser");
    //Remove bool
    prefs.remove("password_user");
  }

  removeValuesSupervised() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.remove("uid_supervised");
    //Remove bool
    prefs.remove("password_supervised");
  }
}