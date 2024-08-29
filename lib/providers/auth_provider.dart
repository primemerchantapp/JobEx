import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth with ChangeNotifier {
  String? _userId;
  String? _name;
  String? _phoneNumber;
  String? _role;

  bool get isAuth {
    return _userId != null;
  }

  String? get userId {
    return _userId;
  }

  String? get name {
    return _name;
  }

  String? get phoneNumber {
    return _phoneNumber;
  }

  Future<void> _authenticate(String email, String password, bool isSignup,
      {String? name, String? phoneNumber}) async {
    try {
      UserCredential userCredential;
      if (isSignup) {
        userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        _userId = userCredential.user!.uid;
        await _saveUserDataToFirestore(
          _userId!,
          name!,
          phoneNumber!,
          email,
        );
      } else {
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        _userId = userCredential.user?.uid;
      }

      await _fetchUserDetails();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _saveUserDataToFirestore(
      String userId, String name, String phoneNumber, String email) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
    await userDoc.set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': Timestamp.now(),
    });
  }

  Future<void> _fetchUserDetails() async {
    if (_userId == null) return;

    final userDoc = FirebaseFirestore.instance.collection('users').doc(_userId);
    final userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      _name = userSnapshot['name'];
      _phoneNumber = userSnapshot['phoneNumber'];
    }
  }

  Future<void> login(String email, String password) async {
    await _authenticate(email, password, false);
  }

  Future<void> signup(
      String email, String password, String name, String phoneNumber) async {
    await _authenticate(email, password, true,
        name: name, phoneNumber: phoneNumber);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _userId = null;
    _name = null;
    _phoneNumber = null;
    notifyListeners();
  }
}
