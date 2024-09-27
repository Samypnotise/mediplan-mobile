class Settings {
  final String id;
  final bool authorizeNotifications;
  final bool authorizeEmails;
  final String userId;

  Settings({
    required this.id,
    required this.authorizeNotifications,
    required this.authorizeEmails,
    required this.userId,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'],
      authorizeNotifications: json['authorize_notifications'],
      authorizeEmails: json['authorize_emails'],
      userId: json['user_id'],
    );
  }
}
