class Weight {
  final String? id;
  final String? weight;
  final String? date;

const  Weight({
     this.id,
     this.weight,
     this.date,
  });

Weight copyWith({
    String? id,
    String? weight,
    String? date,
  }) => Weight(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );

factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      id: json['id'] as String,
      weight: json['weight'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'date': date
    };
  }
}