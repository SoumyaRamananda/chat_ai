import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository repository;

  StreamSubscription? _messagesSubscription;
  final _uuid = const Uuid();

  ChatBloc({required this.repository}) : super(const ChatState()) {
    on<LoadMessages>(_onLoadMessages);
    on<MessagesUpdated>(_onMessagesUpdated);
    on<SendMessageRequested>(_onSendMessage);
  }

  void _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(isLoading: true));

    _messagesSubscription?.cancel();

    _messagesSubscription = repository.getMessages(event.conversationId).listen(
      (messages) {
        add(MessagesUpdated(messages));
      },
    );
  }

  void _onMessagesUpdated(
    MessagesUpdated event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(
      isLoading: false,
      messages: List<MessageEntity>.from(event.messages),
    ));
  }

  Future<void> _onSendMessage(
    SendMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    try {
      // This Save user message
      final userMessage = MessageEntity(
        id: _uuid.v4(),
        role: AppConstants.roleUser,
        content: event.content,
        createdAt: DateTime.now(),
        status: AppConstants.statusDone,
      );

      await repository.sendMessage(
        conversationId: event.conversationId,
        message: userMessage,
      );

      // This Simulate AI streaming LOCALLY only
      const fullResponse = "This is a simulated AI streaming response.";

      String currentText = "";

      for (int i = 0; i < fullResponse.length; i++) {
        await Future.delayed(
          Duration(milliseconds: AppConstants.streamingDelayMs),
        );

        currentText += fullResponse[i];

        emit(
          state.copyWith(
            messages: [
              ...state.messages,
              MessageEntity(
                id: "temp_ai",
                role: AppConstants.roleAssistant,
                content: currentText,
                createdAt: DateTime.now(),
                status: AppConstants.statusStreaming,
              ),
            ],
          ),
        );
      }

      // 3️⃣ Save final AI message ONCE
      final finalAiMessage = MessageEntity(
        id: _uuid.v4(),
        role: AppConstants.roleAssistant,
        content: fullResponse,
        createdAt: DateTime.now(),
        status: AppConstants.statusDone,
      );

      await repository.sendMessage(
        conversationId: event.conversationId,
        message: finalAiMessage,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
