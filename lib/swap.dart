class Swap {
  String _id;
  String _bio;
  String _email;

  Swap(
    this._id,
    this._bio,
    this._email,
  );

  Swap.map(dynamic obj) {
    this._id = obj['id'];
    this._bio = obj['bio'];
    this._email = obj['email'];
  }

  String get id => _id;
  String get bio => _bio;
  String get email => _email;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['bio'] = _bio;
    map['email'] = email;

    return map;
  }

  Swap.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._bio = map['bio'];
    this._email = map['email'];
  }
}
