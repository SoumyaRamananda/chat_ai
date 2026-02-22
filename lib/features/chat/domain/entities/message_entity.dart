import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String role;
  final String content;
  final DateTime? createdAt;
  final String status;

  const MessageEntity({
    required this.id,
    required this.role,
    required this.content,
    required this.createdAt,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    role,
    content,
    createdAt,
    status,
  ];
}