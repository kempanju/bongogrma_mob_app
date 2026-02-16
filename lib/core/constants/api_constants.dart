class ApiConstants {
  static const String baseUrl = 'https://habarisasa.softhama.com';
  static const String appUploadUrl = '$baseUrl/uploads';
  
  // Endpoints
  static const String posts = '/api/posts';
  static const String users = '/api/users';
  static const String messages = '/api/messages';
  static const String notifications = '/api/notifications';
  static const String search = '/api/search';
  
  // Image paths
  static const String photoPath = '$appUploadUrl/photo';
  static const String iconPath = '$appUploadUrl/icon';
  static const String thumbnailPath = '$appUploadUrl/thumbnail';
  static const String videoPath = '$appUploadUrl/videolist';
}
