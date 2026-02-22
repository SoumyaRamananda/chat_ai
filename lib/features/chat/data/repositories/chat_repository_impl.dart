import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';

import '../datasources/chat_remote_datasource.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<String> createConversation(String uid) async {
    try {
      return await remoteDataSource.createConversation(uid);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Future<void> sendMessage({
    required String conversationId,
    required MessageEntity message,
  }) async {
    try {
      final model = MessageModel(
        id: message.id,
        role: message.role,
        content: message.content,
        createdAt: message.createdAt,
        status: message.status,
      );

      await remoteDataSource.sendMessage(
        conversationId: conversationId,
        messageData: model.toMap(),
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const UnknownFailure();
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(
      String conversationId,
      ) {
    try {
      return remoteDataSource
          .getMessages(conversationId)
          .map((snapshot) {
        return snapshot.docs
            .map((doc) =>
            MessageModel.fromFirestore(doc).toEntity())
            .toList();
      });
    } catch (_) {
      throw const ServerFailure("Failed to fetch messages");
    }
  }

  @override
  Stream<List<ConversationEntity>> getUserConversations(
      String uid,
      ) {
    try {
      return remoteDataSource
          .getUserConversations(uid)
          .map((snapshot) {
        return snapshot.docs
            .map((doc) =>
            ConversationModel.fromFirestore(doc)
                .toEntity())
            .toList();
      });
    } catch (_) {
      throw const ServerFailure(
          "Failed to fetch conversations");
    }
  }
}