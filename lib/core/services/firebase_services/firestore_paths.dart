class FirestorePaths {
  /// User
  static String userCollection() => 'users';

  //specific user
  static String userUId(String uid) => 'users/$uid';

  static String userDocument(String docId) => 'users/$docId';

  /// TASKs
  //static String userTask(String uid,String taskName) => 'users/$uid/tasks/$taskName';
  static String getTaskCollection(String uid) => 'users/$uid/tasks';

  static String taskById(String uid,{required String taskId})
          => 'users/$uid/tasks/$taskId';
  static String taskPath(String uid) => 'users/$uid/tasks';

  //supervisor
  static String taskPathBoss(String uid, {required String taskId})
          => 'users/$uid/tasksSupervisor/$taskId';

  /// FirebaseStorage
  static String profilesImagesPath(String userId) => 'users/$userId/$userId';
}
