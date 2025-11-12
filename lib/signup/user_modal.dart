import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id; // Auto-generated random key by Firestore
  final String firstName;
  final String lastName;
  final String address;
  final String email;
  final String role; // 'farmer' or 'buyer'

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.role,
  });

  // Factory constructor to create UserModel from Firestore document
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      //id: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
    );
  }

  //  For reading from GetStorage (local Map)
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
    );
  }

  // Method to convert UserModel to Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'email': email,
      'role': role,
    };
  }
}