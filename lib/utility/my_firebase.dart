import 'package:flutter_ui/headers.dart';

class MyFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
  Future<MyUser?> autoLogin() async {
    try {
      if (currentUser != null) {
        final myUser = await getUser(currentUser!.uid);
        return myUser;
      }

      return null;
    } catch (e) {
      debugPrint("ERROR on AUTO LOGIN $e");
      return null;
    }
  }

  // Register User
  Future<MyUser> registerUser({
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

        return MyUser(
          email: email,
          age: age,
          uid: user.uid,
          questionaries: null,
          results: [],
        );
      }
      throw Error();
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
  Future<MyUser> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final myUser = await getUser(userCredential.user!.uid);
      if (myUser == null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': 'Unkown',
          'age': 99,
          'email': email,
        });

        return MyUser(
          email: email,
          age: 99,
          uid: userCredential.user!.uid,
          questionaries: null,
          results: [],
        );
      }
      return myUser;
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-credential') {
          throw 'Invalid Credentials';
        }
      }
      throw 'Unable To Login User';
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
  Future<MyUser?> getUser(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    final res = doc.exists ? doc.data() as Map<String, dynamic> : null;
    if (res == null) return null;
    return MyUser.fromFirebaseDoc(doc);
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
