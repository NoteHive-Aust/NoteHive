import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:notehive/FirebaseOperations/auth_services.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final FirebaseStorageService instance = FirebaseStorageService._();

  final FirebaseStorage storage = FirebaseStorage.instance;
  final AuthServices auth = AuthServices.instance;

  Future<String?> uploadFile(Uint8List bytes, String fileName) async {
    try {
      final ref = storage
          .ref()
          .child('users')
          .child(auth.uid)
          .child('uploads')
          .child(fileName);

      final uploadTask = await ref.putData(
        bytes,
        SettableMetadata(contentType: 'application/pdf'),
      );

      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Firebase Storage upload failed: $e');
      return null;
    }
  }

  Future<String?> getDownloadUrl(String path) async {
    try {
      return await storage.ref(path).getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
