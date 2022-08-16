import 'package:cloud_firestore/cloud_firestore.dart';

class NotiModel {
  final String taskId;
  bool didShowNotification;

  NotiModel({
    required this.taskId,
    this.didShowNotification = false,
  });
}
