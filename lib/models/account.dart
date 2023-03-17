import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String? id;
  String email;
  String userName;
  String password;
  String birthDate;
  String image;
  bool status;

  Account(
      {this.id, required this.email, required this.userName, required this.password, required this.birthDate, this.image = 'default.png', this.status = true});

  Map<String, dynamic> toJson() => {'email': email, 'userName': userName, 'password': password, 'birthDate': birthDate, 'image': image, 'status': status};

  static Account fromSnapshot(DocumentSnapshot snapshot) {
    return Account(
        id: snapshot.id,
        email: snapshot['email'],
        userName: snapshot['userName'],
        password: snapshot['password'],
        birthDate: snapshot['birthDate'],
        image: snapshot['image'],
        status: snapshot['status']);
  }
}
