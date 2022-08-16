import '../../data/models/userApp_entity.dart';
import '../../data/repository/auth/auth_repository.dart';


class GetUserUC {
  final AuthRepository _authRepository;

  GetUserUC(this._authRepository);


  addSupervised(UserApp userApp) async {
    await _authRepository.addSupervised(userApp);
  }

  addBoss(UserApp userApp) async {
    await addBoss(userApp);
  }

  changeSupervised(UserApp userApp,String emailSupervised) async{
    await changeSupervised(userApp, emailSupervised);
  }

  inicializarUser(String uidUser) async {
    await inicializarUser(uidUser);
  }


}