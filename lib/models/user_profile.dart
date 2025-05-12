class UserProfile {
  final String name;
  final String avatar;
  final int level;
  final int experience;
  final int totalStars;
  final bool isDarkMode;

  UserProfile({
    required this.name,
    required this.avatar,
    required this.level,
    required this.experience,
    required this.totalStars,
    required this.isDarkMode,
  });

  UserProfile copyWith({
    String? name,
    String? avatar,
    int? level,
    int? experience,
    int? totalStars,
    bool? isDarkMode,
  }) {
    return UserProfile(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      totalStars: totalStars ?? this.totalStars,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
