

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neurocheck/modules/notifications/models/notiControl_model.dart';
import 'package:neurocheck/modules/notifications/repo/notiControl_repo.dart';
import 'package:neurocheck/modules/notifications/viewmodels/notiControl_provider.dart';
import 'package:rxdart/rxdart.dart';

final notiControlToDoStream = StreamProvider<List<List<NotiControlModel>>>((ref) {
  return CombineLatestStream.list([
    ref.watch(notiControlRepoProvider).getNotiStream()
  ]);
});