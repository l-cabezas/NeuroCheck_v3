import 'package:neurocheck/data/models/competidor_entity.dart';
import 'package:neurocheck/domain/users/get_user_uc.dart';

import '../../data/models/userApp_entity.dart';
import '/data/models/task_entity.dart';
import '/domain/resources/Strings.dart';
import '/domain/tasks/get_tasks_uc.dart';
import 'package:flutter/cupertino.dart';

//comunicarse con los casos de uso.
class UserAppProvider with ChangeNotifier {
  final GetUserUC _getUserUC;

  UserAppProvider(this._getUserUC);


  addSupervised(UserApp userApp) async{
    await _getUserUC.addSupervised(userApp);
    notifyListeners();
  }

  addBoss(UserApp userApp)async{
    await _getUserUC.addBoss(userApp);
    notifyListeners();
  }


  changeSupervised(UserApp userApp,String emailSupervised)async{
    await _getUserUC.changeSupervised(userApp, emailSupervised);
    notifyListeners();
  }

  inicializarUser(String uidUser) async {
    await _getUserUC.inicializarUser(uidUser);
    notifyListeners();
  }



}
