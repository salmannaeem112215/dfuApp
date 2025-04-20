class MyQuestionaries {
  final String diabetesDuration;
  final String footCare;
  final String hadUlcerBefore;

  const MyQuestionaries({
    required this.diabetesDuration,
    required this.footCare,
    required this.hadUlcerBefore,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'diabetesDuration': diabetesDuration,
      'footCare': footCare,
      'hadUlcerBefore': hadUlcerBefore,
    };
  }

  // Create from JSON
  factory MyQuestionaries.fromJson(Map<String, dynamic> json) {
    return MyQuestionaries(
      diabetesDuration: json['diabetesDuration'] ?? '',
      footCare: json['footCare'] ?? '',
      hadUlcerBefore: json['hadUlcerBefore'] ?? '',
    );
  }
}
