import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class Video {
  final String id;
  final User user;
  final String caption;
  final String location;
  final List<String> hashtags;
  final VideoStats stats;
  final String duration;
  final String currentTime;
  final String thumbnail;
  final String timestamp;

  Video({
    required this.id,
    required this.user,
    required this.caption,
    required this.location,
    required this.hashtags,
    required this.stats,
    required this.duration,
    required this.currentTime,
    required this.thumbnail,
    required this.timestamp,
  });
}

class User {
  final String username;
  final String avatar;
  final bool verified;

  User({required this.username, required this.avatar, required this.verified});
}

class VideoStats {
  final String views;
  final String likes;
  final String comments;
  final String shares;
  final String bookmarks;
  final String reposts;

  VideoStats({
    required this.views,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.bookmarks,
    required this.reposts,
  });
}

class SnapVersePage extends StatefulWidget {
  final Video video;
  const SnapVersePage({Key? key, required this.video}) : super(key: key);

  @override
  _SnapVersePageState createState() => _SnapVersePageState();
}

class _SnapVersePageState extends State<SnapVersePage>
    with TickerProviderStateMixin {
  static const double collapsedHeight = 120;
  static const double expandedHeight = 320;

  bool isExpanded = false;
  bool isLiked = false;
  bool isBookmarked = false;

  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _heightAnimation = Tween<double>(
      begin: collapsedHeight,
      end: expandedHeight,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleOverlay() {
    setState(() {
      isExpanded = !isExpanded;
    });

    if (isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    bool filled = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 6),
          if (label.isNotEmpty)
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final video = widget.video;
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;

    // This used to be its own Scaffold (which caused the AppBar and
    // BottomNav to move with each page). Now the parent feed provides a
    // fixed AppBar and BottomNav; this widget only builds the page content.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: video.thumbnail.startsWith('http')
                ? Image.network(
                    video.thumbnail,
                    fit: BoxFit.cover,
                    // Provide an errorBuilder so missing network images won't crash
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image,
                          color: Colors.white54, size: 48),
                    ),
                  )
                : Image.asset(
                    video.thumbnail,
                    fit: BoxFit.cover,
                  ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
            ),
          ),

          // Side actions
          Positioned(
            right: 12,
            bottom:
                collapsedHeight + (bottomPadding > 0 ? bottomPadding : 16) + 20,
            child: Column(
              children: [
                _buildActionButton(
                  icon: Icons.favorite_border,
                  label: video.stats.likes,
                  color: isLiked ? const Color(0xFFFF3B5C) : Colors.white,
                  filled: isLiked,
                  onTap: () => setState(() => isLiked = !isLiked),
                ),
                const SizedBox(height: 18),
                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: video.stats.comments,
                  color: Colors.white,
                  onTap: () {},
                ),
                const SizedBox(height: 18),
                _buildActionButton(
                  icon: Icons.send_outlined,
                  label: video.stats.shares,
                  color: Colors.white,
                  onTap: () {},
                ),
                const SizedBox(height: 18),
                _buildActionButton(
                  icon: Icons.bookmark_border,
                  label: '',
                  color: Colors.white,
                  filled: isBookmarked,
                  onTap: () => setState(() => isBookmarked = !isBookmarked),
                ),
              ],
            ),
          ),

          // Bottom overlay (expandable)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _heightAnimation,
              builder: (context, child) {
                final height = _heightAnimation.value;
                return SizedBox(
                  height: height,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      // Panel background & content (ignore pointer events when collapsed)
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: !isExpanded,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                height: height,
                                color: Colors.black.withOpacity(0.38),
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 40,
                                  bottom:
                                      bottomPadding > 0 ? bottomPadding : 16,
                                ),
                                child: SingleChildScrollView(
                                  physics: isExpanded
                                      ? const BouncingScrollPhysics()
                                      : const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 21,
                                            backgroundColor: Colors.grey[700],
                                            child: ClipOval(
                                              child: video.user.avatar
                                                      .startsWith('http')
                                                  ? Image.network(
                                                      video.user.avatar,
                                                      width: 42,
                                                      height: 42,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          const Icon(
                                                        Icons.person,
                                                        color: Colors.white70,
                                                      ),
                                                    )
                                                  : Image.asset(
                                                      video.user.avatar,
                                                      width: 42,
                                                      height: 42,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '@${video.user.username}',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  video.timestamp,
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  video.caption,
                                                  maxLines: isExpanded ? 6 : 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.95),
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text('Follow'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Wrap(
                                        spacing: 8,
                                        runSpacing: 6,
                                        children: video.hashtags
                                            .map((h) => Chip(
                                                  label: Text('#$h',
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.08),
                                                ))
                                            .toList(),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // handle: draggable and tappable
                      Positioned(
                        top: 6,
                        child: GestureDetector(
                          onTap: toggleOverlay,
                          onVerticalDragUpdate: (details) {
                            final delta = -details.delta.dy /
                                (expandedHeight - collapsedHeight);
                            _animationController.value =
                                (_animationController.value + delta)
                                    .clamp(0.0, 1.0);
                          },
                          onVerticalDragEnd: (details) {
                            final velocity =
                                details.velocity.pixelsPerSecond.dy;
                            if (velocity < -300) {
                              _animationController.fling(velocity: 2.0);
                              setState(() => isExpanded = true);
                            } else if (velocity > 300) {
                              _animationController.fling(velocity: -2.0);
                              setState(() => isExpanded = false);
                            } else {
                              if (_animationController.value > 0.5) {
                                _animationController.forward();
                                setState(() => isExpanded = true);
                              } else {
                                _animationController.reverse();
                                setState(() => isExpanded = false);
                              }
                            }
                          },
                          child: Container(
                            width: 40,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isExpanded
                                  ? Icons.expand_more
                                  : Icons.expand_less,
                              color: Colors.grey[300],
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
