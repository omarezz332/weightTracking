class Weight {
  final String id;
  final double weight;
  final DateTime date;

const  Weight({
    required this.id,
    required this.weight,
    required this.date,
  });

Weight copyWith({
    String? id,
    double? weight,
    DateTime? date,
  }) => Weight(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );

factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      id: json['id'] as String,
      weight: json['weight'] as double,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'date': date.toIso8601String(),
    };
  }
}