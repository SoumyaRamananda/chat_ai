import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/message_entity.dart';

class MessageModel {
  final String id;
  final String role;
  final String content;
  final DateTime? createdAt;
  final String status;

  MessageModel({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
    required this.status,
  });

  factory MessageModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data()!;

    return MessageModel(
      id: doc.id,
      role: data[AppConstants.role],
      content: data[AppConstants.content],
      createdAt:
      (data[AppConstants.createdAt] as Timestamp?)?.toDate(),
      status: data[AppConstants.status] ??
          AppConstants.statusDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppConstants.role: role,
      AppConstants.content: content,
      AppConstants.createdAt: createdAt,
      AppConstants.status: status,
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      role: role,
      content: content,
      createdAt: createdAt,
      status: status,
    );
  }
}