import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom app bar widget implementing content-aware navigation
/// for social media applications with context-sensitive actions
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The type of app bar to display
  final CustomAppBarType type;

  /// The title to display in the app bar
  final String? title;

  /// Custom leading widget (overrides default back button)
  final Widget? leading;

  /// List of action widgets to display on the right
  final List<Widget>? actions;

  /// Whether to show the back button
  final bool showBackButton;

  /// Callback when back button is pressed
  final VoidCallback? onBackPressed;

  /// Whether to center the title
  final bool centerTitle;

  /// Custom background color (overrides theme)
  final Color? backgroundColor;

  /// Custom foreground color (overrides theme)
  final Color? foregroundColor;

  /// Elevation of the app bar
  final double? elevation;

  /// Whether to show a bottom border
  final bool showBottomBorder;

  const CustomAppBar({
    super.key,
    this.type = CustomAppBarType.standard,
    this.title,
    this.leading,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.centerTitle = false,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showBottomBorder = false,
  });

  /// Factory constructor for media creation app bar
  factory CustomAppBar.mediaCreation({
    Key? key,
    String? title,
    VoidCallback? onClose,
    VoidCallback? onNext,
    bool showNext = true,
  }) {
    return CustomAppBar(
      key: key,
      type: CustomAppBarType.mediaCreation,
      title: title ?? 'Create Post',
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onClose,
      ),
      actions: showNext
          ? [
              TextButton(
                onPressed: onNext,
                child: const Text('Next'),
              ),
              const SizedBox(width: 8),
            ]
          : null,
      showBackButton: false,
    );
  }

  /// Factory constructor for profile app bar
  factory CustomAppBar.profile({
    Key? key,
    String? username,
    VoidCallback? onSettings,
    VoidCallback? onShare,
  }) {
    return CustomAppBar(
      key: key,
      type: CustomAppBarType.profile,
      title: username,
      centerTitle: true,
      actions: [
        if (onShare != null)
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: onShare,
          ),
        if (onSettings != null)
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: onSettings,
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  /// Factory constructor for search app bar
  factory CustomAppBar.search({
    Key? key,
    String? hintText,
    ValueChanged<String>? onSearchChanged,
    VoidCallback? onFilterPressed,
  }) {
    return CustomAppBar(
      key: key,
      type: CustomAppBarType.search,
      title: hintText ?? 'Search',
      actions: [
        if (onFilterPressed != null)
          IconButton(
            icon: const Icon(Icons.tune_outlined),
            onPressed: onFilterPressed,
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: _buildTitle(context),
      leading: _buildLeading(context),
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? theme.appBarTheme.foregroundColor,
      elevation: elevation ?? 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      bottom: showBottomBorder
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: colorScheme.outline.withOpacity(0.2),
              ),
            )
          : null,
    );
  }

  Widget? _buildTitle(BuildContext context) {
    if (title == null) return null;

    final theme = Theme.of(context);

    switch (type) {
      case CustomAppBarType.search:
        return Container(
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: title,
              prefixIcon: const Icon(Icons.search, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
            ),
            style: theme.textTheme.bodyMedium,
          ),
        );

      case CustomAppBarType.mediaCreation:
        return Text(
          title!,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        );

      case CustomAppBarType.profile:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        );

      default:
        return Text(
          title!,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (!showBackButton) return null;

    final canPop = ModalRoute.of(context)?.canPop ?? false;
    if (!canPop) return null;

    return IconButton(
      icon: const Icon(Icons.arrow_back_ios, size: 20),
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (showBottomBorder ? 1 : 0),
      );
}

/// Enum defining different types of app bars
enum CustomAppBarType {
  /// Standard app bar with title and actions
  standard,

  /// App bar for media creation with close and next buttons
  mediaCreation,

  /// App bar for user profiles with username and settings
  profile,

  /// App bar with integrated search field
  search,
}

