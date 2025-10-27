import 'package:flutter/material.dart';
import 'snapverse_page.dart';
import '../../../widgets/bottom_nav.dart';

class SnapVerseFeed extends StatefulWidget {
  const SnapVerseFeed({Key? key}) : super(key: key);

  @override
  State<SnapVerseFeed> createState() => _SnapVerseFeedState();
}

class _SnapVerseFeedState extends State<SnapVerseFeed> {
  final PageController _pageController = PageController();

  final List<Video> videos = [
    Video(
      id: '1',
      user: User(
          username: 'connecto_user',
          // use local asset avatars to avoid network failures during testing
          avatar: 'assets/avatar1.jpg',
          verified: true),
      caption: 'Exploring the beauty of nature 🌊',
      location: 'Big Suanê, CA',
      hashtags: ['nature', 'travel', 'adventure', 'connecto'],
      stats: VideoStats(
        views: '12.3k',
        likes: '456',
        comments: '456',
        shares: '890',
        bookmarks: '15.2k',
        reposts: '15.2k',
      ),
      duration: '2:15',
      currentTime: '0:45',
      timestamp: '3h ago',
      // use packaged asset for thumbnails to avoid network dependency in demos
      thumbnail: 'assets/post1.jpg',
    ),
    Video(
      id: '2',
      user: User(
          username: 'travel_girl',
          avatar: 'assets/avatar2.jpg',
          verified: false),
      caption: 'Sunsets are proof that endings can be beautiful 🌅',
      location: 'Santorini, Greece',
      hashtags: ['sunset', 'greece', 'travelgram'],
      stats: VideoStats(
        views: '8.7k',
        likes: '1.2k',
        comments: '340',
        shares: '240',
        bookmarks: '8.4k',
        reposts: '4.8k',
      ),
      duration: '1:45',
      currentTime: '0:30',
      timestamp: '5h ago',
      thumbnail: 'assets/post1.jpg',
    ),
    Video(
      id: '3',
      user: User(
          username: 'urban_explorer',
          avatar: 'assets/avatar1.jpg',
          verified: true),
      caption: 'City lights, sleepless nights 🌃',
      location: 'Tokyo, Japan',
      hashtags: ['citylife', 'night', 'aesthetic'],
      stats: VideoStats(
        views: '22.3k',
        likes: '2.1k',
        comments: '670',
        shares: '540',
        bookmarks: '9.7k',
        reposts: '5.6k',
      ),
      duration: '0:58',
      currentTime: '0:15',
      timestamp: '8h ago',
      thumbnail: 'assets/post1.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fixed AppBar and BottomNav live here so they don't move when the
      // inner PageView scrolls. Only the PageView (body) scrolls.
      // Make AppBar transparent so content can extend behind it (like before).
      appBar: AppBar(
        title: const Text('SnapVerse'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        // keep the body behind the AppBar so thumbnails can show beneath it
      ),
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return SnapVersePage(video: videos[index]);
        },
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
