
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

// esto es necesario para borrar las notificaciones del supervisado si se borra
// la tarea, más adelante se podrá usar tb para avisar al supervisor de tarea hecha
class NotiControlModel {
  String taskId;
  String notiId;
  List? idNotification;
  final String? cancel;

  NotiControlModel({
    required this.taskId,
    required this.notiId,
    this.idNotification,
    required this.cancel,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'notiId': notiId,
      'idNotification': idNotification ?? '',
      'cancel': cancel ?? ''
    }..removeWhere((key, value) => value == null);
  }

  factory NotiControlModel.fromMap(Map<String, dynamic> map, String notiId) {
    return NotiControlModel(
        taskId: map['taskId'] ?? '',
        notiId: notiId,
        idNotification: map['idNotification'] ?? '',
        cancel: map['cancel'] ?? '',
    );
  }

  /// Google Factory
  factory NotiControlModel.fromUserCredential(NotiControlModel notiControlModel) {
    return NotiControlModel(
      taskId: notiControlModel.taskId,
      notiId: notiControlModel.notiId,
      idNotification: notiControlModel.idNotification,
      cancel: notiControlModel.cancel ?? '',

    );
  }

  NotiControlModel copyWith({
    String? taskId,
    String? notiId,
    List? idNotification,
    String? cancel,
  }) {
    return NotiControlModel(
      taskId: taskId ?? this.taskId,
      notiId: notiId ?? this.notiId,
      idNotification: this.idNotification,
      cancel: cancel ?? this.cancel,
    );
  }
}

