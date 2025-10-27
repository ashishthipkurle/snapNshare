import 'package:flutter/material.dart';
import '../shims/sizer_shim.dart';

import '../../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class MediaOptionsWidget extends StatelessWidget {
  final VoidCallback? onCameraPressed;
  final VoidCallback? onGalleryPressed;
  final VoidCallback? onGifPressed;
  final VoidCallback? onPollPressed;

  const MediaOptionsWidget({
    super.key,
    this.onCameraPressed,
    this.onGalleryPressed,
    this.onGifPressed,
    this.onPollPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 12.w,
              height: 1.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Title
          Text(
            'Add to your post',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 4.h),

          // Media options grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMediaOption(
                context,
                icon: 'camera_alt',
                label: 'Camera',
                color: AppTheme.lightTheme.colorScheme.primary,
                onTap: onCameraPressed,
              ),
              _buildMediaOption(
                context,
                icon: 'photo_library',
                label: 'Gallery',
                color: AppTheme.lightTheme.colorScheme.secondary,
                onTap: onGalleryPressed,
              ),
              _buildMediaOption(
                context,
                icon: 'gif',
                label: 'GIF',
                color: AppTheme.lightTheme.colorScheme.tertiary,
                onTap: onGifPressed,
              ),
              _buildMediaOption(
                context,
                icon: 'poll',
                label: 'Poll',
                color: AppTheme.lightTheme.colorScheme.error,
                onTap: onPollPressed,
              ),
            ],
          ),

          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildMediaOption(
    BuildContext context, {
    required String icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: color.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: icon,
                color: color,
                size: 7.w,
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

