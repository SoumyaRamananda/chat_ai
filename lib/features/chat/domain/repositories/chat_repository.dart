import '../entities/conversation_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<String> createConversation(String uid);

  Future<void> sendMessage({
    required String conversationId,
    required MessageEntity message,
  });

  Stream<List<MessageEntity>> getMessages(String conversationId);

  Stream<List<ConversationEntity>> getUserConversations(String uid);
}