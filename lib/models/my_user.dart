import 'package:flutter_ui/headers.dart';

class MyUser {
  final String uid;
  final String email;
  final String name;
  final int age;
  final List<MyResults> results;
  final MyQuestionaries? questionaries;

  const MyUser({
    this.uid = '',
    required this.name,
    required this.email,
    required this.age,
    required this.results,
    required this.questionaries,
  });

  // Convert to JSON (excluding results if you store them separately)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'age': age,
      'name': name,
      'results': results.map((e) => e.toJson()).toList(),
      'questionaries': questionaries?.toJson(),
    };
  }

  // From JSON
  factory MyUser.fromJson(
    Map<String, dynamic> json, {
    String uid = '',
  }) {
    final results = ((json['results'] as List?) ?? [])
        .map((e) => MyResults.fromJson(e))
        .toList();
    final questionaries = json['questionaries'] != null
        ? MyQuestionaries.fromJson(json['questionaries'])
        : null;
    return MyUser(
      uid: uid,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      age: json['age'] ?? '',
      results: results,
      questionaries: questionaries,
    );
  }

  // From Firestore Document
  factory MyUser.fromFirebaseDoc(
    DocumentSnapshot doc,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    return MyUser.fromJson(
      data,
      uid: doc.id,
    );
  }
}
