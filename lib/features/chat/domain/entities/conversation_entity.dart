import 'package:equatable/equatable.dart';

class ConversationEntity extends Equatable {
  final String id;
  final String ownerUid;
  final String title;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ConversationEntity({
    required this.id,
    required this.ownerUid,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    ownerUid,
    title,
    createdAt,
    updatedAt,
  ];
}