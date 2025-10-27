import 'package:flutter/material.dart';

import '../ui/widgets/custom_icon_widget.dart';
import '../ui/widgets/notification_filter_tabs_widget.dart';
import '../ui/widgets/notification_item_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedFilter = 'All';

  final List<NotificationData> notifications = [
    NotificationData(
      id: '1',
      type: NotificationType.like,
      userName: 'Like',
      action: 'liked your post',
      timestamp: '2m',
      avatarUrl:
          'https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      postImageUrl:
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      isToday: true,
    ),
    NotificationData(
      id: '2',
      type: NotificationType.comment,
      userName: 'Comment',
      action: 'commented on your post',
      timestamp: '5m',
      avatarUrl:
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      hasFollowButton: true,
      isToday: true,
    ),
    NotificationData(
      id: '3',
      type: NotificationType.follow,
      userName: 'Follow',
      action: 'started following you',
      timestamp: '10m',
      avatarUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      isToday: true,
    ),
    NotificationData(
      id: '4',
      type: NotificationType.mention,
      userName: 'Merticent',
      action: 'mentioned you in a comment',
      timestamp: '15m',
      avatarUrl:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      isToday: true,
    ),
    NotificationData(
      id: '5',
      type: NotificationType.like,
      userName: 'Sarah Chen',
      action: 'liked your post',
      timestamp: '1d',
      avatarUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      postImageUrl:
          'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      isToday: false,
    ),
    NotificationData(
      id: '6',
      type: NotificationType.follow,
      userName: 'Alex Kumar',
      action: 'started following you',
      timestamp: '2d',
      avatarUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=150&q=80',
      isToday: false,
    ),
  ];

  List<NotificationData> get filteredNotifications {
    if (selectedFilter == 'All') {
      return notifications;
    }
    return notifications.where((notification) {
      switch (selectedFilter) {
        case 'Mentions':
          return notification.type == NotificationType.mention;
        case 'Likes':
          return notification.type == NotificationType.like;
        case 'Comments':
          return notification.type == NotificationType.comment;
        case 'Follows':
          return notification.type == NotificationType.follow;
        default:
          return true;
      }
    }).toList();
  }

  List<NotificationData> get todayNotifications =>
      filteredNotifications.where((n) => n.isToday).toList();

  List<NotificationData> get earlierNotifications =>
      filteredNotifications.where((n) => !n.isToday).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CustomIconWidget(
              iconName: 'settings',
              size: 24,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter tabs
          NotificationFilterTabsWidget(
            selectedFilter: selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                selectedFilter = filter;
              });
            },
          ),

          // Notifications list
          Expanded(
            child: filteredNotifications.isEmpty
                ? _buildEmptyState()
                : ListView(
                    padding: const EdgeInsets.only(top: 8),
                    children: [
                      // Today section
                      if (todayNotifications.isNotEmpty) ...[
                        _buildSectionHeader('Today'),
                        ...todayNotifications.map(
                          (notification) => NotificationItemWidget(
                            notification: notification,
                            onTap: () => _handleNotificationTap(notification),
                            onFollowTap: () => _handleFollowTap(notification),
                          ),
                        ),
                      ],

                      // Earlier section
                      if (earlierNotifications.isNotEmpty) ...[
                        _buildSectionHeader('Earlier'),
                        ...earlierNotifications.map(
                          (notification) => NotificationItemWidget(
                            notification: notification,
                            onTap: () => _handleNotificationTap(notification),
                            onFollowTap: () => _handleFollowTap(notification),
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'notifications_none',
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(NotificationData notification) {
    // Handle navigation to post or profile
    switch (notification.type) {
      case NotificationType.like:
      case NotificationType.comment:
        // Navigate to post details
        break;
      case NotificationType.follow:
      case NotificationType.mention:
        // Navigate to user profile
        break;
    }
  }

  void _handleFollowTap(NotificationData notification) {
    // Handle follow back action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Following ${notification.userName}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

enum NotificationType { like, comment, follow, mention }

class NotificationData {
  final String id;
  final NotificationType type;
  final String userName;
  final String action;
  final String timestamp;
  final String avatarUrl;
  final String? postImageUrl;
  final bool hasFollowButton;
  final bool isToday;

  const NotificationData({
    required this.id,
    required this.type,
    required this.userName,
    required this.action,
    required this.timestamp,
    required this.avatarUrl,
    this.postImageUrl,
    this.hasFollowButton = false,
    required this.isToday,
  });
}
