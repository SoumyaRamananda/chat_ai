import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/message_entity.dart';

class MessageBubble extends StatelessWidget {
  final MessageEntity message;

  const MessageBubble({super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == AppConstants.roleUser;
    final theme = Theme.of(context);
    final maxWidth = MediaQuery.of(context).size.width * 0.75;

    return Align(
      alignment:
      isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        constraints: BoxConstraints(maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: isUser
              ? null
              : Border.all(
            color: theme.colorScheme.primary.withOpacity(0.4),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color:
                isUser ? Colors.white : theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            if (message.createdAt != null)
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormatter.formatTime(
                      message.createdAt!),
                  style: TextStyle(
                    fontSize: 10,
                    color: isUser
                        ? Colors.white70
                        : Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}