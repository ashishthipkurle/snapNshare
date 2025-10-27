import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import 'chat.dart';

class MessagesPage extends StatefulWidget {
  final VoidCallback? onBack;

  const MessagesPage({
    Key? key,
    this.onBack,
  }) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  // search query used by the search input on this screen
  String _searchQuery = '';
  final _conversations = [
    {
      'id': 1,
      'user': {
        'name': 'Sarah Johnson',
        'username': 'sarahj',
        'avatar':
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      },
      'lastMessage': 'Thanks for sharing! Love your content 😊',
      'timestamp': '5m ago',
      'unread': 2,
      'online': true,
    },
    {
      'id': 2,
      'user': {
        'name': 'Mike Chen',
        'username': 'mikechen',
        'avatar':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      },
      'lastMessage': 'Let me know when you\'re free to chat',
      'timestamp': '1h ago',
      'unread': 0,
      'online': true,
    },
    {
      'id': 3,
      'user': {
        'name': 'Emma Davis',
        'username': 'emmad',
        'avatar':
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      },
      'lastMessage': 'You: That sounds great!',
      'timestamp': '3h ago',
      'unread': 0,
      'online': false,
    },
    {
      'id': 4,
      'user': {
        'name': 'Alex Park',
        'username': 'alexpark',
        'avatar':
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
      },
      'lastMessage': 'Just saw your latest post, amazing!',
      'timestamp': '1d ago',
      'unread': 0,
      'online': false,
    },
    {
      'id': 5,
      'user': {
        'name': 'Lily Wang',
        'username': 'lilyw',
        'avatar':
            'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100',
      },
      'lastMessage': 'You: Thanks! Really appreciate it',
      'timestamp': '2d ago',
      'unread': 0,
      'online': false,
    },
  ];

  void _handleOpenChat(Map<String, dynamic> user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          onBack: () => Navigator.of(context).pop(),
          contact: {
            'name': user['name'],
            'username': user['username'],
            'avatar': user['avatar'],
            'online': user['online'],
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // apply simple search filter using _searchQuery so the field is used
    final query = _searchQuery.trim().toLowerCase();
    final filteredConversations = query.isEmpty
        ? _conversations
        : _conversations.where((c) {
            final user = c['user'] as Map<String, dynamic>;
            final name = (user['name'] as String).toLowerCase();
            final username = (user['username'] as String).toLowerCase();
            final last = (c['lastMessage'] as String).toLowerCase();
            return name.contains(query) || username.contains(query) || last.contains(query);
          }).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor.withOpacity(0.8),
                border: Border(bottom: BorderSide(color: theme.dividerColor)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (widget.onBack != null)
                            IconButton(
                              icon: const Icon(Icons.chevron_left, size: 28),
                              onPressed: widget.onBack,
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                backgroundColor: Colors.transparent,
                                hoverColor: theme.hoverColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          Text(
                            'Messages',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.edit,
                            color: theme.primaryColor, size: 24),
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(8),
                          backgroundColor: Colors.transparent,
                          hoverColor: theme.hoverColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    onChanged: (value) => setState(() => _searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search messages',
                      prefixIcon:
                          Icon(Icons.search, color: theme.hintColor, size: 20),
                      filled: true,
                      fillColor: theme.inputDecorationTheme.fillColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.dividerColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.dividerColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: theme.primaryColor),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Conversations List
            Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: filteredConversations.length,
                  separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: theme.dividerColor,
                      ),
                  itemBuilder: (context, index) {
                    final conversation = filteredConversations[index];
                  final user = conversation['user'] as Map<String, dynamic>;
                  final unread = conversation['unread'] as int;
                  final online = conversation['online'] as bool;

                  return InkWell(
                    onTap: () => _handleOpenChat(user),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Avatar with online indicator
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage(user['avatar'] as String),
                                onBackgroundImageError: (e, s) =>
                                    const Icon(Icons.person),
                              ),
                              if (online)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: theme.scaffoldBackgroundColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),

                          // Message content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      user['name'] as String,
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      conversation['timestamp'] as String,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: theme.hintColor,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        conversation['lastMessage'] as String,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: unread > 0
                                              ? theme.textTheme.bodyLarge?.color
                                              : theme.hintColor,
                                          fontWeight: unread > 0
                                              ? FontWeight.w500
                                              : null,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (unread > 0) ...[
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            unread.toString(),
                                            style: TextStyle(
                                              color:
                                                  theme.colorScheme.onPrimary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
