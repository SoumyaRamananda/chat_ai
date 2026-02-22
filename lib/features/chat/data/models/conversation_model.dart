import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/conversation_entity.dart';

class ConversationModel {
  final String id;
  final String ownerUid;
  final String title;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ConversationModel({
    required this.id,
    required this.ownerUid,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ConversationModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data()!;

    return ConversationModel(
      id: doc.id,
      ownerUid: data[AppConstants.ownerUid],
      title: data[AppConstants.title] ?? "New Chat",
      createdAt:
      (data[AppConstants.createdAt] as Timestamp?)?.toDate(),
      updatedAt:
      (data[AppConstants.updatedAt] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppConstants.ownerUid: ownerUid,
      AppConstants.title: title,
      AppConstants.createdAt: createdAt,
      AppConstants.updatedAt: updatedAt,
    };
  }

  ConversationEntity toEntity() {
    return ConversationEntity(
      id: id,
      ownerUid: ownerUid,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}