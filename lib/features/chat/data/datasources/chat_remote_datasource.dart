import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';

abstract class ChatRemoteDataSource {
  Future<String> createConversation(String uid);

  Future<void> sendMessage({
    required String conversationId,
    required Map<String, dynamic> messageData,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String conversationId,
      );

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserConversations(
      String uid,
      );
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  ChatRemoteDataSourceImpl({
    FirebaseFirestore? firestore,
  }) : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<String> createConversation(String uid) async {
    try {
      final doc = firestore
          .collection(AppConstants.conversationsCollection)
          .doc();

      await doc.set({
        AppConstants.ownerUid: uid,
        AppConstants.title: "New Chat",
        AppConstants.createdAt: FieldValue.serverTimestamp(),
        AppConstants.updatedAt: FieldValue.serverTimestamp(),
      });

      return doc.id;
    } catch (_) {
      throw const ServerException("Failed to create conversation");
    }
  }

  @override
  Future<void> sendMessage({
    required String conversationId,
    required Map<String, dynamic> messageData,
  }) async {
    try {
      final messagesRef = firestore
          .collection(AppConstants.conversationsCollection)
          .doc(conversationId)
          .collection(AppConstants.messagesSubcollection)
          .doc(messageData['id']);

      await messagesRef.set(messageData);

      // Update conversation updatedAt
      await firestore
          .collection(AppConstants.conversationsCollection)
          .doc(conversationId)
          .update({
        AppConstants.updatedAt: FieldValue.serverTimestamp(),
      });
    } catch (_) {
      throw const ServerException("Failed to send message");
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String conversationId,
      ) {
    try {
      return firestore
          .collection(AppConstants.conversationsCollection)
          .doc(conversationId)
          .collection(AppConstants.messagesSubcollection)
          .orderBy(AppConstants.createdAt)
          .snapshots();
    } catch (_) {
      throw const ServerException("Failed to fetch messages");
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserConversations(
      String uid,
      ) {
    try {
      return firestore
          .collection(AppConstants.conversationsCollection)
          .where(AppConstants.ownerUid, isEqualTo: uid)
          .orderBy(AppConstants.updatedAt, descending: true)
          .snapshots();
    } catch (_) {
      throw const ServerException("Failed to fetch conversations");
    }
  }
}