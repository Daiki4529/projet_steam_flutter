import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore;

  FirebaseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final String documentPath =
      'data/default'; // "data" is the collection name and "default" is the document name

  Future<Map<String, dynamic>> fetchLists() async {
    final DocumentSnapshot doc = await _firestore.doc(documentPath).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      // If the document doesn't exist, initialize it.
      await _firestore.doc(documentPath).set({
        'likelist': [],
        'wishlist': [],
      });
      return {'likelist': [], 'wishlist': []};
    }
  }

  Future<void> updateLists({
    required List<String> likeList,
    required List<String> wishList,
  }) async {
    await _firestore.doc(documentPath).update({
      'likelist': likeList,
      'wishlist': wishList,
    });
  }
}
