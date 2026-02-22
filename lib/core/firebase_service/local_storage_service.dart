import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();

  static const String _keyGuestUid = 'guest_uid';
  static const String _keyLastConversationId = 'last_conversation_id';

  static Future<void> saveGuestUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyGuestUid, uid);
  }

  static Future<String?> getGuestUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyGuestUid);
  }

  static Future<void> clearGuestUid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyGuestUid);
  }

  static Future<void> saveLastConversationId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastConversationId, id);
  }

  static Future<String?> getLastConversationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastConversationId);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
