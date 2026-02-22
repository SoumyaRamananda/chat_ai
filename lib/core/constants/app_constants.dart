class AppConstants {
  AppConstants._();

  // Firestore Collections
  static const String usersCollection = 'users';
  static const String conversationsCollection = 'conversations';
  static const String messagesSubcollection = 'messages';

  // Firestore Fields
  static const String ownerUid = 'ownerUid';
  static const String title = 'title';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';

  static const String role = 'role';
  static const String content = 'content';
  static const String status = 'status';

  // Message Roles
  static const String roleUser = 'user';
  static const String roleAssistant = 'assistant';
  static const String roleSystem = 'system';

  // Message Status
  static const String statusSent = 'sent';
  static const String statusStreaming = 'streaming';
  static const String statusDone = 'done';
  static const String statusError = 'error';

  // Routes
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String chatRoute = '/chat';
  static const String conversationsRoute = '/conversations';
  static const String profileRoute = '/profile';

  // Streaming Config
  static const int streamingDelayMs = 30;

  // Pagination / Limits
  static const int messagesLimit = 50;

  // App Info
  static const String appName = 'Mini AI Chat';
}
