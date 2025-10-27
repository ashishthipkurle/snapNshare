import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../widgets/bottom_nav.dart';
import 'notifications_screen.dart';
import 'messages.dart';

// Exact StoriesCarousel widget requested by the user
class StoriesCarousel extends StatelessWidget {
  const StoriesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = List.generate(8, (i) => 'User ${i + 1}');

    return SizedBox(
      height: 108,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        itemCount: stories.length + 1,
        itemBuilder: (_, i) {
          // index 0 is the Add Your Story tile
          if (i == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/create'),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      child: const Center(
                        child: Icon(Icons.add, size: 32, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const SizedBox(
                      width: 84,
                      child: Text('Add Your Story',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12)),
                    )
                  ],
                ),
              ),
            );
          }

          // shift the stories index by -1 because of the add tile
          final storyIndex = i - 1;
          final username = stories[storyIndex];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: kGradientPrimary,
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage(
                        'assets/post1.jpg',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 72,
                  child: Text(username,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  // story items moved to state so we can measure and repack dynamically
  final List<Map<String, dynamic>> _storyItems = [
    {
      'username': 'Your Story',
      'time': 'Time:5:56 d',
      'caption':
          'Tenay st lonaeels op tter buuati, tice ca atel ve nba, Junccont, chungy, an Qineed arae tnan lesatiie.\nBiulaice dacil...',
      'isVideo': false,
      'isLiked': true,
      'hasAddButton': true,
      'likes': 67,
      'shares': 5228,
      'comments': null,
      'heightFactor': 1.2,
    },
    {
      'username': 'Your Story',
      'time': 'Time:20:20 01:55',
      'caption':
          'Content KSWC deliha, jivgle sat, fors you iterrt lco and panls/pnedlobbing tage.',
      'isVideo': true,
      'isLiked': false,
      'hasAddButton': false,
      'likes': null,
      'shares': null,
      'comments': 2,
      'heightFactor': 0.9,
    },
    {
      'username': 'Tour Story',
      'time': 'Time:20 07 02:5',
      'caption': 'Pncy comme hewis, no vur qrfsdigraut, saeed save.',
      'isVideo': true,
      'isLiked': false,
      'hasAddButton': false,
      'likes': null,
      'shares': null,
      'comments': null,
      'heightFactor': 0.8,
    },
    {
      'username': 'Your Story',
      'time': 'Time:15:30 d',
      'caption':
          'Another amazing story with different height to make it feel more natural and realistic.',
      'isVideo': false,
      'isLiked': false,
      'hasAddButton': false,
      'likes': 120,
      'shares': null,
      'comments': 5,
      'heightFactor': 1.1,
    },
  ];

  // keys to measure built children heights after first frame
  late final List<GlobalKey> _itemKeys =
      List.generate(_storyItems.length, (_) => GlobalKey());

  // packed columns to render after measurement
  List<Widget> _leftPacked = [];
  List<Widget> _rightPacked = [];
  bool _packed = false;

  // Measure rendered card heights and repack into two balanced columns
  void _measureAndPack(double cardWidth) {
    if (!mounted) return;

    final heights = <double>[];
    for (var key in _itemKeys) {
      final ctx = key.currentContext;
      if (ctx == null) {
        heights.add(0);
      } else {
        final render = ctx.findRenderObject() as RenderBox?;
        heights.add(render?.size.height ?? 0);
      }
    }

    // If measurement failed (all zeros), skip packing.
    if (heights.every((h) => h == 0)) return;

    final left = <Widget>[];
    final right = <Widget>[];
    double leftH = 0.0;
    double rightH = 0.0;

    for (var i = 0; i < _storyItems.length; i++) {
      final s = _storyItems[i];
      final estimated = heights[i];

      final widget = Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: SizedBox(
          width: cardWidth,
          child: _storyCard(
            username: s['username'] as String,
            time: s['time'] as String,
            caption: s['caption'] as String,
            isVideo: s['isVideo'] as bool,
            isLiked: s['isLiked'] as bool,
            hasAddButton: s['hasAddButton'] as bool,
            likes: s['likes'] as int?,
            shares: s['shares'] as int?,
            comments: s['comments'] as int?,
            heightFactor: s['heightFactor'] as double,
          ),
        ),
      );

      if (leftH <= rightH) {
        left.add(widget);
        leftH += estimated;
      } else {
        right.add(widget);
        rightH += estimated;
      }
    }

    setState(() {
      _leftPacked = left;
      _rightPacked = right;
      _packed = true;
    });
  }

  // (removed unused helper `_storyCircleWithAsset`) - compact carousel used instead

  Widget _storyCard({
    required String username,
    required String time,
    required String caption,
    bool isVideo = false,
    bool isLiked = false,
    bool hasAddButton = false,
    int? likes,
    int? shares,
    int? comments,
    double heightFactor = 1.0,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Avatar (use asset if available)
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/avatar1.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(
                          'IMG',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasAddButton)
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  )
                else
                  Icon(Icons.more_horiz, color: Colors.grey[600], size: 24),
              ],
            ),
          ),

          // Image/Video area with variable visual height.
          // Note: Grid children should not use Expanded (it requires a Flex parent).
          // We drive the visual height with a concrete height (based on heightFactor).
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: (160 * heightFactor)
                .clamp(80, 330), // scaled, clamped for sanity
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: isVideo
                    ? Icon(
                        Icons.play_circle_fill,
                        size: 56,
                        color: Colors.white.withOpacity(0.9),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          'assets/post1.jpg',
                          fit: BoxFit.cover,
                          // If the asset fails to load in a dev environment, show a graceful fallback.
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Text(
                                'IMAGE ASSET',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ),

          // Caption
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Text(
              caption,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
            child: Row(
              children: [
                Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 22,
                  color: isLiked ? Colors.red : Colors.grey[700],
                ),
                if (likes != null) ...[
                  const SizedBox(width: 6),
                  Icon(Icons.star_border, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 3),
                  Text(
                    '$likes',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const Spacer(),
                if (comments != null) ...[
                  Icon(Icons.chat_bubble_outline,
                      size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '$comments',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    'Cceir',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                if (shares != null) ...[
                  const SizedBox(width: 8),
                  Icon(Icons.star, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 3),
                  Text(
                    '$shares',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00C6FF), Color(0xFFFFB800)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Icon(Icons.flash_on,
                            color: Colors.white, size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'snapNshare',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, size: 28),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.message_outlined, size: 28),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MessagesPage(),
                            ),
                          );
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // (carousel) - removed inline duplicate; using the `StoriesCarousel` widget above

            const SizedBox(height: 20),

            // Insert the requested StoriesCarousel (compact circles)
            const StoriesCarousel(),

            const SizedBox(height: 16),

            // Stories Grid with varying heights -> use Wrap inside a SingleChildScrollView
            // so each card can size naturally and push others; the page becomes vertically scrollable.
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                // calculate card width for a 2-column layout with spacing
                final horizontalPadding = 16.0 * 2; // padding on Grid
                final spacing = 12.0; // runSpacing / spacing
                final cardWidth =
                    (constraints.maxWidth - horizontalPadding - spacing) / 2;

                final items = _storyItems;

                // measurement widgets (offstage) to compute actual rendered heights
                final measurementWidgets = <Widget>[];
                for (var i = 0; i < items.length; i++) {
                  final s = items[i];
                  measurementWidgets.add(
                    KeyedSubtree(
                      key: _itemKeys[i],
                      child: SizedBox(
                        width: cardWidth,
                        child: _storyCard(
                          username: s['username'] as String,
                          time: s['time'] as String,
                          caption: s['caption'] as String,
                          isVideo: s['isVideo'] as bool,
                          isLiked: s['isLiked'] as bool,
                          hasAddButton: s['hasAddButton'] as bool,
                          likes: s['likes'] as int?,
                          shares: s['shares'] as int?,
                          comments: s['comments'] as int?,
                          heightFactor: s['heightFactor'] as double,
                        ),
                      ),
                    ),
                  );
                }

                // schedule measurement and packing once (after first frame)
                if (!_packed) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _measureAndPack(cardWidth);
                  });
                }

                // If we've packed, render the packed result; otherwise fall back to
                // an estimation-based packing (fast) while measurement completes.
                final leftToShow = _packed ? _leftPacked : <Widget>[];
                final rightToShow = _packed ? _rightPacked : <Widget>[];

                if (_packed) {
                  return SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: cardWidth,
                            child: Column(children: leftToShow)),
                        SizedBox(width: spacing),
                        SizedBox(
                            width: cardWidth,
                            child: Column(children: rightToShow)),
                      ],
                    ),
                  );
                }

                // Fallback: estimation-based pack while we measure
                final estLeft = <Widget>[];
                final estRight = <Widget>[];
                double estLeftH = 0;
                double estRightH = 0;
                const double headerEstimate = 60.0;
                const double captionEstimate = 54.0;
                const double actionsEstimate = 48.0;

                for (var s in items) {
                  final heightFactor = s['heightFactor'] as double;
                  final imageH = (160 * heightFactor).clamp(80, 330) as double;
                  final estimated = headerEstimate +
                      imageH +
                      captionEstimate +
                      actionsEstimate +
                      24.0;

                  final widget = Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SizedBox(
                        width: cardWidth,
                        child: _storyCard(
                          username: s['username'] as String,
                          time: s['time'] as String,
                          caption: s['caption'] as String,
                          isVideo: s['isVideo'] as bool,
                          isLiked: s['isLiked'] as bool,
                          hasAddButton: s['hasAddButton'] as bool,
                          likes: s['likes'] as int?,
                          shares: s['shares'] as int?,
                          comments: s['comments'] as int?,
                          heightFactor: s['heightFactor'] as double,
                        )),
                  );

                  if (estLeftH <= estRightH) {
                    estLeft.add(widget);
                    estLeftH += estimated;
                  } else {
                    estRight.add(widget);
                    estRightH += estimated;
                  }
                }

                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: cardWidth,
                              child: Column(children: estLeft)),
                          SizedBox(width: spacing),
                          SizedBox(
                              width: cardWidth,
                              child: Column(children: estRight)),
                        ],
                      ),
                      // Hidden measurement widgets to obtain real heights (not painted)
                      Offstage(
                        offstage: true,
                        child: Column(children: measurementWidgets),
                      ),
                    ],
                  ),
                );
              }),
            ),

            // Bottom navigation moved to Scaffold.bottomNavigationBar to avoid layout overflow
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
