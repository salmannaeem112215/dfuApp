import 'package:flutter_ui/headers.dart';

class MyResults {
  final String userId;
  final DateTime dateTime;
  final String imagePath;
  final String result;

  const MyResults({
    required this.userId,
    required this.dateTime,
    required this.imagePath,
    required this.result,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'dateTime': dateTime.toIso8601String(),
      'imagePath': imagePath,
      'result': result,
    };
  }

  // From JSON
  factory MyResults.fromJson(Map<String, dynamic> json) {
    return MyResults(
      userId: json['userId'] ?? '',
      dateTime: DateTime.parse(json['dateTime'].toString()),
      imagePath: json['imagePath'] ?? '',
      result: json['result'] ?? '',
    );
  }

  // From Firestore Document
}
