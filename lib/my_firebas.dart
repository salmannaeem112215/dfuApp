import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register User
  Future<User?> registerUser({
    required String email,
    required String password,
    required String name,
    required int age,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'age': age,
          'email': email,
        });
      }

      return user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          throw 'User already register with this email';
        }
      }
      throw 'Unable to Register User';
    }
  }

  // Login User
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Login Error: $e');
      return null;
    }
  }

  // Add User (manually)
  Future<void> addUser(String uid, String name, int age, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'age': age,
      'email': email,
    });
  }

  // Get User
  Future<Map<String, dynamic>?> getUser(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : null;
  }

  // Update User
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  // Delete User
  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
    User? user = _auth.currentUser;
    if (user != null && user.uid == uid) {
      await user.delete();
    }
  }

  // Add Result
  Future<void> addResult(String userId, String imageUrl, String result) async {
    await _firestore.collection('results').add({
      'userId': userId,
      'imageUrl': imageUrl,
      'result': result,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get User Results
  Future<List<Map<String, dynamic>>> getUserResults(String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('results')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Get Result
  Future<Map<String, dynamic>?> getResult(String resultId) async {
    DocumentSnapshot doc =
        await _firestore.collection('results').doc(resultId).get();
    return doc.exists ? doc.data() as Map<String, dynamic> : null;
  }

  // Delete Result
  Future<void> deleteResult(String resultId) async {
    await _firestore.collection('results').doc(resultId).delete();
  }
}
