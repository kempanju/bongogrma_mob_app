class User {
  final int id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profilePic;
  final bool isBlocked;
  final double? latitude;
  final double? longitude;
  final String? city;

  User({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.isBlocked = false,
    this.latitude,
    this.longitude,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profilePic: json['profile_pic'] as String?,
      isBlocked: (json['blocked'] as int?) == 1,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      city: json['city'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_pic': profilePic,
      'blocked': isBlocked ? 1 : 0,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
    };
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? profilePic,
    bool? isBlocked,
    double? latitude,
    double? longitude,
    String? city,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePic: profilePic ?? this.profilePic,
      isBlocked: isBlocked ?? this.isBlocked,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
    );
  }
}
