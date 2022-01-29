import 'package:uuid/uuid.dart';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev/models/post.dart';
import 'package:dev/resources/storage_method.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get profImage => null;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImag,
  ) async {
    String res = "Some error occure";

    try {
      String photoUrl =
          await StorageMethod().uploadImageStorage('posts', file, true);
      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profImage: profImag,
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
        res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId,String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
       await _firestore.collection('posts').doc(postId).update({
         'likes': FieldValue.arrayRemove([uid])
       });
      } else {
        await _firestore.collection('posts').doc(postId).update({
         'likes': FieldValue.arrayUnion([uid]),
       });
      }

    } catch(err) {
      print('error in string');
      print(err.toString());
    }
  }
}
