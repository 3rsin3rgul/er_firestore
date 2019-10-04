import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  Future<CollectionReference> createCollectionRef(String collection) async {
    final CollectionReference ref = Firestore.instance.collection(collection);
    return ref;
  }

  Future<String> create(T, CollectionReference collection) async {
    final TransactionHandler create = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(collection.document());

      final Map<String, dynamic> data = T.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(create).then((mapData) {
      return T.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getLists(
      {int offset, int limit, CollectionReference reference}) {
    Stream<QuerySnapshot> snapshots = reference.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> update(T, CollectionReference reference) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(reference.document(T.id));

      await tx.update(ds.reference, T.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> delete(String id, CollectionReference reference) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(reference.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
