import '../../models/userApp_entity.dart';
import '/data/global_var/globals.dart' as globals;

abstract class AuthRepository{

//usando entity
  addSupervised(UserApp userApp);

  addBoss(UserApp userApp);

  changeSupervised(String uid, String uidSupervisado);

  inicializarUser(String uidUser);


}
