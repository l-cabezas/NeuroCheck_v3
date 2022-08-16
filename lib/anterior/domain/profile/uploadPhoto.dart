import 'dart:io';
import '/domain/resources/Strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '/data/global_var/globals.dart' as globals;

class UploadPhoto {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> upload(String inputSource) async {

    final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        var info = await storage.ref('icono/'+globals.user_email).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'icon_by': globals.user_email,
            }));

      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }




  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<String> loadImages() async {
    List<Map<String, dynamic>> files = [];
    String fileUrl ='';

    //final ListResult result = await storage.ref('icono').list();
    final ListResult result = await storage.ref('icono'+globals.user_email).list();
    //final String stringResult = await storage.ref('icono/'+user_email).fullPath;
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      fileUrl = await file.getDownloadURL();
      print('fileUrl $fileUrl');

      globals.urlIconoInicial=fileUrl;
      print(globals.urlIconoInicial);
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Nobody',
        "description":
        fileMeta.customMetadata?['description'] ?? 'No description',
        "icon_by": fileMeta.customMetadata?['icon_by'] ?? 'Nobody'
      });

      print('fileUrl $fileUrl');

    });

    globals.urlIcono = fileUrl;


    return fileUrl;
  }

  cargaImage() async{
    Reference  ref = FirebaseStorage.instance.ref().child("icono/"+globals.user_email);

    //get image url from firebase storage
    await ref.getDownloadURL().then((data) =>
    globals.urlIconoInicial = data.toString()
    ).catchError((e) =>
    globals.urlIconoInicial = 'none'
    //"https://firebasestorage.googleapis.com/v0/b/daily-tea.appspot.com/o/icono%2Fuser.png?alt=media&token=f1ac1210-8a1f-4d61-92ba-2327dde53b42"
    );
    print('url '+globals.urlIconoInicial);

  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> delete(String ref) async {
    await storage.ref(ref).delete();
  }




}








