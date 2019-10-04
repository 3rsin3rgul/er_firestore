# er_firestore

## Example Usage

```
FirebaseFirestoreService db = new FirebaseFirestoreService();
  create() {
    final Swap swap = new Swap("", "_bio", "_email");
    db.createCollectionRef('users').then(
      (v) {
        db.create(swap, v);
      },
    );
  }
```
