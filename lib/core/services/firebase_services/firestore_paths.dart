class FirestorePaths {
  /// User
  static String userCollection() => 'users';

  static String userDocument(String docId) => 'users/$docId';

  /// TASKs
  static String userTask(String uid,String taskName) => 'users/$uid/tasks/$taskName';
  static String getTaskCollection(String uid) => 'users/$uid/tasks';

  static String taskById(String uid,{required String taskId}) => 'users/$uid/tasks/$taskId';
  static String taskPath(String uid) => 'users/$uid/tasks';

  /// FirebaseStorage
  static String profilesImagesPath(String userId) => 'users/$userId/$userId';
}
