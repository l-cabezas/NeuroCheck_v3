import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/notifications/models/notiControl_model.dart';

import '../../../core/services/firebase_services/firebase_caller.dart';
import '../../../core/services/firebase_services/firestore_paths.dart';
import '../../../core/services/firebase_services/i_firebase_caller.dart';


final notiControlRepoProvider = Provider<NotiControlRepo>((ref) => NotiControlRepo(ref));


class NotiControlRepo {
  NotiControlRepo(this.ref) {
    _firebaseCaller = ref.watch(firebaseCaller);
  }

  final Ref ref;

  late IFirebaseCaller _firebaseCaller;
  NotiControlModel? notiControlModelModel;

  //obtenemos datos

  Stream<List<NotiControlModel>> getNotiStream() {
    return  _firebaseCaller.collectionStream<NotiControlModel>(
      path: FirestorePaths.notificationPass(GetStorage().read('uidUsuario')),
      builder: (snapshotData, snapshotId) {
        return NotiControlModel.fromMap(snapshotData!, snapshotId);
      },
    );
  }

}