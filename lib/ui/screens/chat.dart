import 'package:flutter/material.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Map<String, dynamic> contact;

  const ChatScreen({
    Key? key,
    required this.onBack,
    required this.contact,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  String _message = '';

  final List<Map<String, dynamic>> _messages = [
    {
      'id': 1,
      'text': 'Hey! How are you doing?',
      'sender': 'them',
      'timestamp': '10:30 AM',
      'read': true,
    },
    {
      'id': 2,
      'text': 'I\'m doing great! Just saw your latest post, it\'s amazing! 🎨',
      'sender': 'me',
      'timestamp': '10:32 AM',
      'read': true,
    },
    {
      'id': 3,
      'text': 'Thanks for sharing! Love your content 😊',
      'sender': 'them',
      'timestamp': '10:33 AM',
      'read': true,
    },
    {
      'id': 4,
      'text': 'Thank you so much! I really appreciate your support 💜',
      'sender': 'me',
      'timestamp': '10:35 AM',
      'read': true,
    },
    {
      'id': 5,
      'text': 'Are you working on any new projects?',
      'sender': 'them',
      'timestamp': '10:36 AM',
      'read': true,
    },
    {
      'id': 6,
      'text':
          'Actually yes! I\'m planning something really exciting. I\'ll share more details soon!',
      'sender': 'me',
      'timestamp': '10:38 AM',
      'read': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Scroll to bottom after build
    Timer(const Duration(milliseconds: 100), _scrollToBottom);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSendMessage() {
    if (_message.trim().isNotEmpty) {
      final now = TimeOfDay.now();
      final timestamp =
          '${now.hourOfPeriod}:${now.minute.toString().padLeft(2, '0')} ${now.period == DayPeriod.am ? 'AM' : 'PM'}';

      setState(() {
        _messages.add({
          'id': _messages.length + 1,
          'text': _message.trim(),
          'sender': 'me',
          'timestamp': timestamp,
          'read': false,
        });
        _message = '';
        _messageController.clear();
      });

      Timer(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.8),
                border: Border(bottom: BorderSide(color: theme.dividerColor)),
              ),
              child: Row(
                children: [
                  // Back button
                  IconButton(
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Avatar and user info
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: widget.contact['avatar'] != null
                            ? NetworkImage(widget.contact['avatar'])
                            : null,
                        child: widget.contact['avatar'] == null
                            ? Text(widget.contact['name'][0])
                            : null,
                      ),
                      if (widget.contact['online'] == true)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: theme.cardColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),

                  // Name and status
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contact['name'],
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.contact['online'] == true
                              ? 'Active now'
                              : '@${widget.contact['username']}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // More options button
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: Container(
                color: theme.scaffoldBackgroundColor,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isMe = message['sender'] == 'me';
                    final showTimestamp = index == 0 ||
                        _messages[index - 1]['sender'] != message['sender'];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isMe && showTimestamp) ...[
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: widget.contact['avatar'] != null
                                  ? NetworkImage(widget.contact['avatar'])
                                  : null,
                              child: widget.contact['avatar'] == null
                                  ? Text(widget.contact['name'][0])
                                  : null,
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (!isMe && !showTimestamp)
                            const SizedBox(width: 40),
                          Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.75,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  gradient: isMe
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF9333EA), // purple-600
                                            Color(0xFF2563EB), // blue-600
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        )
                                      : null,
                                  color: isMe ? null : theme.cardColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(20),
                                    topRight: const Radius.circular(20),
                                    bottomLeft: Radius.circular(isMe
                                        ? 20
                                        : showTimestamp
                                            ? 4
                                            : 20),
                                    bottomRight: Radius.circular(isMe
                                        ? showTimestamp
                                            ? 4
                                            : 20
                                        : 20),
                                  ),
                                  border: isMe
                                      ? null
                                      : Border.all(color: theme.dividerColor),
                                ),
                                child: Text(
                                  message['text'],
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isMe ? Colors.white : null,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              if (showTimestamp)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Text(
                                    message['timestamp'],
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.hintColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Input area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor.withOpacity(0.8),
                border: Border(top: BorderSide(color: theme.dividerColor)),
              ),
              child: Row(
                children: [
                  // Image button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.image, color: theme.primaryColor),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  // Emoji button
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.emoji_emotions, color: theme.primaryColor),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  // Message input
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onChanged: (value) => setState(() => _message = value),
                      onSubmitted: (_) => _handleSendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Message...',
                        filled: true,
                        fillColor: theme.inputDecorationTheme.fillColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: theme.dividerColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: theme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send button
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: _message.trim().isNotEmpty
                          ? const LinearGradient(
                              colors: [
                                Color(0xFF9333EA), // purple-600
                                Color(0xFF2563EB), // blue-600
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color:
                          _message.trim().isEmpty ? theme.disabledColor : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed:
                          _message.trim().isEmpty ? null : _handleSendMessage,
                      icon: const Icon(Icons.send, size: 20),
                      color: Colors.white,
                      style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

