library er_firestore;

import 'package:er_firestore/swap.dart';

import 'firestore_manager.dart';

/// A Firestore Manager
class FirestoreManager {
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  create() {
    final Swap swap = new Swap("", "_bio", "_email");
    db.createCollectionRef('users').then(
      (v) {
        db.create(swap, v);
      },
    );
  }
}
