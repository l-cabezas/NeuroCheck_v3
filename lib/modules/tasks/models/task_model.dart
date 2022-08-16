
import 'dart:developer';

class TaskModel {
   String taskId;
  final String taskName;
  final String? begin;
  final String? end;
  final String? editable;

  final List? days;
  final List? notiHours;

  final List? idNotification;

  final String? oneTime;
  final String? done;
  final String? numRepetition;


  TaskModel({
    required this.taskId,
    required this.taskName,
    required this.begin,
    required this.end,
    required this.editable,

    this.days,
    this.notiHours,

    this.idNotification,

    this.oneTime,
    required this.done,
    required this.numRepetition,
  });

  Map<String, dynamic> toMap() {
    return {
    'taskId': taskId,
    'taskName':taskName,
    'begin':begin,
    'end':end,
    'editable':editable,

    'days':days ?? '',
    'notiHours': notiHours ?? '',

    'idNotification': idNotification ?? '',

    'oneTime':oneTime ?? '',
    'done':done,
    'numRepetition': numRepetition,
    }..removeWhere((key, value) => value == null);
  }

  factory TaskModel.fromMap(Map<String, dynamic> map, String idTask) {
    return TaskModel(
      taskId: idTask,
      taskName: map['taskName'] ?? '',
      begin: map['begin'] ?? '',
      end: map['end'] ?? '',
      editable: map['editable'] ?? '',

      days: map['days'] ?? '',
      notiHours: map['notiHours'] ?? '',

      idNotification: map['idNotification'] ?? '',

      oneTime: map['oneTime'] ?? '',
      done: map['done'] ?? '',
      numRepetition: map['numRepetition'] ?? ''
    );
  }

  /// Google Factory
  factory TaskModel.fromUserCredential(TaskModel task) {
    return TaskModel(
      taskId: task.taskId,
      taskName: task.taskName,
      begin: task.begin ?? '',
      end: task.end ?? '',
      editable: task.editable ?? '',

      days: task.days,
      notiHours: task.notiHours,

      idNotification: task.idNotification,

      oneTime: task.oneTime ?? '',
      done: task.done ?? '',
      numRepetition: task.numRepetition ?? '',
    );
  }

  TaskModel copyWith({
    String? taskId,
     String? taskName,
     String? begin,
     String? end,
     String? editable,

     List? days,
     List? notiHours,

      List? idNotification,

     String? oneTime,
     String? done,
    String? numRepetition,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      editable: editable ?? this.editable,

      days: this.days,
      notiHours: this.notiHours,

      idNotification: this.idNotification,

      oneTime: oneTime ?? this.oneTime,
      done: done ?? this.done,
      numRepetition: numRepetition ?? this.numRepetition
    );
  }
}

