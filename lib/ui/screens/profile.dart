import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

typedef VoidCallback = void Function();

class ProfilePage extends StatelessWidget {
  final VoidCallback? onEditProfile;
  final VoidCallback? onSettings;

  const ProfilePage({
    Key? key,
    this.onEditProfile,
    this.onSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _ProfileBody(
          onEditProfile: onEditProfile,
          onSettings: onSettings,
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class _ProfileBody extends StatefulWidget {
  final VoidCallback? onEditProfile;
  final VoidCallback? onSettings;

  const _ProfileBody({Key? key, this.onEditProfile, this.onSettings})
      : super(key: key);

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody> {
  String _activeTab = 'grid';

  final List<String> _userPosts = [
    'https://images.unsplash.com/photo-1617634667039-8e4cb277ab46?w=400',
    'https://images.unsplash.com/photo-1579549322334-324325a6540b?w=400',
    'https://images.unsplash.com/photo-1650057861788-b6b8606b77ef?w=400',
    'https://images.unsplash.com/photo-1687618083947-691b6c4adb4d?w=400',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=400',
  ];

  final List<Map<String, Object>> _textPosts = [
    {
      'id': 1,
      'text':
          'Just captured this amazing sunset! Nature never fails to amaze me 🌅✨',
      'likes': 1243,
      'comments': 89,
      'timestamp': '2h',
    },
    {
      'id': 2,
      'text':
          'Hot take: The best code is code you don\'t have to write. Sometimes the simplest solution is the right one. 💭',
      'likes': 892,
      'comments': 156,
      'timestamp': '1d',
    },
    {
      'id': 3,
      'text':
          'Coffee + good music + rainy day = perfect productivity combo ☕🎵🌧️',
      'likes': 567,
      'comments': 42,
      'timestamp': '3d',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.dividerColor)),
            color: theme.scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profile', style: theme.textTheme.titleLarge),
              IconButton(
                onPressed: widget.onSettings ??
                    () => Navigator.of(context).pushNamed('/settings'),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),

        // Cover and avatar
        Expanded(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 128,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF7C3AED), // purple-600
                                Color(0xFF2563EB), // blue-600
                                Color(0xFF06B6D4), // cyan-500
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -48,
                          left: 16,
                          child: Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: theme.scaffoldBackgroundColor,
                                  width: 4),
                              color: theme.primaryColor,
                            ),
                            child: Center(
                              child: Text(
                                'Y',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 60),

                    // Profile Info
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Your Name',
                                      style: theme.textTheme.titleMedium),
                                  const SizedBox(height: 4),
                                  Text('@yourusername',
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: theme.hintColor)),
                                ],
                              ),
                              OutlinedButton(
                                onPressed: widget.onEditProfile ??
                                    () => Navigator.of(context)
                                        .pushNamed('/settings'),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Text('Edit Profile'),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),
                          Text(
                              '📸 Visual storyteller | 💭 Sharing thoughts and moments | 🌍 Exploring the world'),

                          const SizedBox(height: 12),

                          // Stats
                          Row(
                            children: [
                              _StatButton(
                                  label: 'Posts', value: '342', onTap: () {}),
                              const SizedBox(width: 12),
                              _StatButton(
                                  label: 'Followers',
                                  value: '12.5K',
                                  onTap: () {}),
                              const SizedBox(width: 12),
                              _StatButton(
                                  label: 'Following',
                                  value: '890',
                                  onTap: () {}),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Tab Switcher
                          Row(
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () =>
                                      setState(() => _activeTab = 'grid'),
                                  icon: const Icon(Icons.grid_view),
                                  label: const Text('Grid'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: _activeTab == 'grid'
                                        ? theme.primaryColor
                                        : theme.hintColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () =>
                                      setState(() => _activeTab = 'list'),
                                  icon: const Icon(Icons.list),
                                  label: const Text('Posts'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: _activeTab == 'list'
                                        ? theme.primaryColor
                                        : theme.hintColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Content
                          if (_activeTab == 'grid')
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 1,
                              ),
                              itemCount: _userPosts.length,
                              itemBuilder: (context, index) {
                                final url = _userPosts[index];
                                return GestureDetector(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stack) =>
                                          Container(color: theme.dividerColor),
                                    ),
                                  ),
                                );
                              },
                            )
                          else
                            Column(
                              children: _textPosts.map((post) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(post['text'] as String),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text('${post['likes']} likes',
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          color:
                                                              theme.hintColor)),
                                              const SizedBox(width: 12),
                                              Text(
                                                  '${post['comments']} comments',
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          color:
                                                              theme.hintColor)),
                                              const SizedBox(width: 12),
                                              Text('${post['timestamp']} ago',
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                          color:
                                                              theme.hintColor)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatButton extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _StatButton(
      {Key? key, required this.label, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: theme.textTheme.titleMedium),
          Text(label,
              style:
                  theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
        ],
      ),
    );
  }
}
