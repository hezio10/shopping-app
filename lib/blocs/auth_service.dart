
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';


class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserModel?> createUser(
      String email, String password, String name, String phone) async {
    try {

      final credentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credentials.user;

      if (user != null) {

        final newUser = UserModel(
          id: user.uid,
          name: name,
          email: email,
          phone: phone,
          address: '',
          role: 'customer',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      log(0);
      print("erroe");
    }
    return null;
  }


  Future<User?> singInUserWithEmailAndPassword(String email,
      String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final user = credentials.user;
      return user;
    } catch (e) {
      log(0);
      print('Erro!!');
    }
    return null;
  }

  Future<bool> deleteAccount(String email, String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: email,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);

        await FirebaseFirestore.instance.collection('users').doc(user.uid).delete();

        await user.delete();

        return true;
      }
    } catch (e) {
      print('Erro ao excluir a conta: $e');
    }
    return false;
  }



  Future<User?> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log(0);
    }
    return null;
  }
}