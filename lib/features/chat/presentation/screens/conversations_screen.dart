import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../core/constants/app_constants.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

import '../../domain/entities/conversation_entity.dart';
import '../../domain/repositories/chat_repository.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    if (authState is! AuthAuthenticated) {
      return const Scaffold(
        body: Center(child: Text("Not authenticated")),
      );
    }

    final uid = authState.user.uid;
    final repository = context.read<ChatRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppConstants.profileRoute,
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<ConversationEntity>>(
        stream: repository.getUserConversations(uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final conversations = snapshot.data!;

          if (conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.chat_bubble_outline,
                      size: 60, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No conversations yet",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            itemCount: conversations.length,
            separatorBuilder: (_, __) =>
            const Divider(height: 1, indent: 72),
            itemBuilder: (context, index) {
              final convo = conversations[index];

              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppConstants.chatRoute,
                    arguments: convo.id,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [

                      // Avatar
                      CircleAvatar(
                        radius: 26,
                        backgroundColor:
                        Theme.of(context).colorScheme.primary,
                        child: Text(
                          convo.title.isNotEmpty
                              ? convo.title[0].toUpperCase()
                              : "?",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Title + Preview
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              convo.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Tap to open conversation",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Time
                      if (convo.updatedAt != null)
                        Text(
                          DateFormatter.formatChatTimestamp(
                              convo.updatedAt!),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final conversationId = await repository.createConversation(uid);

          Navigator.pushNamed(
            context,
            AppConstants.chatRoute,
            arguments: conversationId,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
