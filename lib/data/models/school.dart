class School {
  final int id;
  final String name;
  final String? location;
  final int type; // 1 = primary, 2 = secondary, 3 = college
  final int? memberCount;

  School({
    required this.id,
    required this.name,
    this.location,
    required this.type,
    this.memberCount,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'] as int,
      name: json['name'] as String,
      location: json['location'] as String?,
      type: json['type'] as int? ?? 1,
      memberCount: json['member_count'] as int?,
    );
  }

  String get levelName {
    switch (type) {
      case 1:
        return 'Primary';
      case 2:
        return 'Secondary';
      case 3:
        return 'College/University';
      default:
        return 'School';
    }
  }

  String get displayName {
    if (type == 1) {
      return '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()} Primary';
    } else if (type == 2) {
      return '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()} Secondary';
    }
    return name;
  }
}

class Education {
  final int id;
  final int schoolId;
  final String schoolName;
  final int startYear;
  final int? endYear;
  final String level; // plevel, olevel, college
  final bool isCurrent;

  Education({
    required this.id,
    required this.schoolId,
    required this.schoolName,
    required this.startYear,
    this.endYear,
    required this.level,
    this.isCurrent = false,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as int,
      schoolId: json['school_id'] as int,
      schoolName: json['school_name'] as String,
      startYear: json['start_year'] as int,
      endYear: json['end_year'] as int?,
      level: json['level'] as String,
      isCurrent: (json['is_current'] as int?) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'school_name': schoolName,
      'start_year': startYear,
      'end_year': endYear,
      'level': level,
      'is_current': isCurrent ? 1 : 0,
    };
  }

  String get levelDisplayName {
    switch (level) {
      case 'plevel':
        return 'Primary School';
      case 'olevel':
        return 'Secondary School';
      case 'college':
        return 'College/University';
      default:
        return level;
    }
  }

  String get yearRange {
    if (isCurrent || endYear == null) {
      return '$startYear - Present';
    }
    return '$startYear - $endYear';
  }
}
