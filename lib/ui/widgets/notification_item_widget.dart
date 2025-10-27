import 'package:flutter/material.dart';

import '../../ui/widgets/custom_icon_widget.dart';
import '../screens/notifications_screen.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationData notification;
  final VoidCallback onTap;
  final VoidCallback? onFollowTap;

  const NotificationItemWidget({
    Key? key,
    required this.notification,
    required this.onTap,
    this.onFollowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User avatar
            _buildAvatar(),

            const SizedBox(width: 12),

            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNotificationText(context),
                  const SizedBox(height: 4),
                  _buildTimestamp(context),
                ],
              ),
            ),

            // Right side content (post image, follow button, etc.)
            _buildRightContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 24,
      backgroundImage: NetworkImage(notification.avatarUrl),
      backgroundColor: Colors.grey[300],
      child: notification.avatarUrl.isEmpty
          ? const CustomIconWidget(
              iconName: 'person',
              size: 24,
              color: Colors.grey,
            )
          : null,
    );
  }

  Widget _buildNotificationText(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: notification.userName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          TextSpan(
            text: ' ${notification.action}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimestamp(BuildContext context) {
    return Text(
      notification.timestamp,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }

  Widget _buildRightContent(BuildContext context) {
    if (notification.hasFollowButton) {
      return _buildFollowButton(context);
    } else if (notification.postImageUrl != null) {
      return _buildPostImage();
    }
    return const SizedBox.shrink();
  }

  Widget _buildFollowButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: onFollowTap,
        child: Text(
          'Follow Back',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget _buildPostImage() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: notification.postImageUrl != null
            ? DecorationImage(
                image: NetworkImage(notification.postImageUrl!),
                fit: BoxFit.cover,
              )
            : null,
        color: Colors.grey[300],
      ),
      child: notification.postImageUrl == null
          ? const CustomIconWidget(
              iconName: 'image',
              size: 20,
              color: Colors.grey,
            )
          : null,
    );
  }
}
