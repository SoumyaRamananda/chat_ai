import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';

class MessageInputField extends StatefulWidget {
  final void Function(String message) onSend;
  final bool isLoading;

  const MessageInputField({
    super.key,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final error = Validators.validateMessage(_controller.text);

    if (error != null) return;

    widget.onSend(_controller.text.trim());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Type a message...",
              ),
            ),
          ),
          IconButton(
            icon: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.send),
            onPressed: widget.isLoading ? null : _handleSend,
          ),
        ],
      ),
    );
  }
}
