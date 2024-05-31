// user.dart
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
// health_record.dart
class HealthRecord {
  final String id; // This will be assigned by MongoDB
  final String date;
  final int calories;
  final String foodType;
  final int weight;
  final int height;
  final int exerciseMinutes;
  final int waterIntake;

  HealthRecord({
    required this.id, // MongoDB will assign this
    required this.date,
    required this.calories,
    required this.foodType,
    required this.weight,
    required this.height,
    required this.exerciseMinutes,
    required this.waterIntake,
  });

  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      id: json['_id'],
      date: json['date'],
      calories: json['calories'],
      foodType: json['foodType'],
      weight: json['weight'],
      height: json['height'],
      exerciseMinutes: json['exerciseMinutes'],
      waterIntake: json['waterIntake'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'calories': calories,
      'foodType': foodType,
      'weight': weight,
      'height': height,
      'exerciseMinutes': exerciseMinutes,
      'waterIntake': waterIntake,
    };
  }
}
