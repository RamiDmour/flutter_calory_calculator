import 'dart:convert';

class Profile {
  final int? id;
  final String? email;
  final String gender;
  final String birthday;
  final double weight;
  final int height;
  final String goal;
  final String lifeStyle;
  final String firstName;
  final String lastName;
  Profile({
    this.id,
    this.email,
    required this.gender,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.goal,
    required this.lifeStyle,
    required this.firstName,
    required this.lastName,
  });

  Profile copyWith({
    int? id,
    String? email,
    String? gender,
    String? birthday,
    double? weight,
    int? height,
    String? goal,
    String? lifeStyle,
    String? firstName,
    String? lastName,
  }) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
      lifeStyle: lifeStyle ?? this.lifeStyle,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'weight': weight,
      'height': height,
      'goal': goal,
      'lifeStyle': lifeStyle,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id']?.toInt() ?? 0,
      email: map['email'],
      gender: map['gender'] ?? '',
      birthday: map['birthday'] ?? '',
      weight: map['weight']?.toDouble() ?? 0,
      height: map['height']?.toInt() ?? 0,
      goal: map['goal'] ?? '',
      lifeStyle: map['lifeStyle'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Profile(id: $id, email: $email, gender: $gender, birthday: $birthday, weight: $weight, height: $height, goal: $goal, lifeStyle: $lifeStyle, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.id == id &&
        other.email == email &&
        other.gender == gender &&
        other.birthday == birthday &&
        other.weight == weight &&
        other.height == height &&
        other.goal == goal &&
        other.lifeStyle == lifeStyle &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        birthday.hashCode ^
        weight.hashCode ^
        height.hashCode ^
        goal.hashCode ^
        lifeStyle.hashCode ^
        firstName.hashCode ^
        lastName.hashCode;
  }
}
