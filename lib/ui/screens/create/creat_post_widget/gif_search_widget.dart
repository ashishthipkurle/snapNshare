import 'package:flutter/material.dart';
import '../shims/sizer_shim.dart';

import '../../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class GifSearchWidget extends StatefulWidget {
  final Function(String) onGifSelected;
  final VoidCallback? onClose;

  const GifSearchWidget({
    super.key,
    required this.onGifSelected,
    this.onClose,
  });

  @override
  State<GifSearchWidget> createState() => _GifSearchWidgetState();
}

class _GifSearchWidgetState extends State<GifSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _trendingGifs = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadTrendingGifs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadTrendingGifs() {
    setState(() {
      _isLoading = true;
    });

    // Mock trending GIFs data
    _trendingGifs = [
      {
        "id": 1,
        "url": "https://images.unsplash.com/photo-1731596153022-4cedafe3330a",
        "title": "Happy Dance",
        "semanticLabel":
            "Animated GIF of a person doing a happy dance with arms raised in celebration"
      },
      {
        "id": 2,
        "url": "https://images.unsplash.com/photo-1714914203895-99e450cc9fad",
        "title": "Thumbs Up",
        "semanticLabel":
            "Animated GIF showing a thumbs up gesture with sparkles and positive energy"
      },
      {
        "id": 3,
        "url": "https://images.unsplash.com/photo-1635540634992-b50ac83ea65e",
        "title": "Clapping",
        "semanticLabel":
            "Animated GIF of hands clapping enthusiastically in appreciation"
      },
      {
        "id": 4,
        "url": "https://images.unsplash.com/photo-1512428761985-eb925890864e",
        "title": "Heart Eyes",
        "semanticLabel":
            "Animated GIF with heart-shaped eyes expressing love and admiration"
      },
      {
        "id": 5,
        "url": "https://images.unsplash.com/photo-1658843246615-d791d6b7775c",
        "title": "Laughing",
        "semanticLabel":
            "Animated GIF of someone laughing heartily with joy and amusement"
      },
      {
        "id": 6,
        "url": "https://images.unsplash.com/photo-1698891667813-b445f80aace7",
        "title": "Waving",
        "semanticLabel":
            "Animated GIF of a friendly waving gesture saying hello or goodbye"
      },
    ];

    setState(() {
      _isLoading = false;
    });
  }

  void _searchGifs(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    // Mock search results based on query
    _searchResults = _trendingGifs.where((gif) {
      return (gif["title"] as String)
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    // Add some mock search-specific results
    if (query.toLowerCase().contains('cat')) {
      _searchResults.addAll([
        {
          "id": 7,
          "url": "https://images.unsplash.com/photo-1659177360253-0b5df99113ce",
          "title": "Cat Playing",
          "semanticLabel":
              "Animated GIF of a cute cat playing with a toy, showing playful behavior"
        },
        {
          "id": 8,
          "url": "https://images.unsplash.com/photo-1573391144991-ddddb2ac0751",
          "title": "Cat Sleeping",
          "semanticLabel":
              "Animated GIF of a peaceful cat sleeping curled up in a cozy position"
        },
      ]);
    }

    setState(() {
      _isSearching = false;
    });
  }

  void _onGifTap(Map<String, dynamic> gif) {
    widget.onGifSelected(gif["url"] as String);
  }

  @override
  Widget build(BuildContext context) {
    final displayGifs = _isSearching || _searchController.text.isNotEmpty
        ? _searchResults
        : _trendingGifs;

    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.8,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
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

                SizedBox(height: 2.h),

                // Title and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Choose a GIF',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onClose,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: 'close',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 5.w,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _searchGifs,
                    decoration: InputDecoration(
                      hintText: 'Search for GIFs...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'search',
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                          size: 5.w,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 3.w,
                      ),
                    ),
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: _isLoading
                ? _buildLoadingGrid()
                : displayGifs.isEmpty
                    ? _buildEmptyState()
                    : _buildGifGrid(displayGifs),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
        childAspectRatio: 1.2,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search_off',
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.4),
            size: 15.w,
          ),
          SizedBox(height: 2.h),
          Text(
            'No GIFs found',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try searching for something else',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGifGrid(List<Map<String, dynamic>> gifs) {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
        childAspectRatio: 1.2,
      ),
      itemCount: gifs.length,
      itemBuilder: (context, index) {
        final gif = gifs[index];
        return _buildGifTile(gif);
      },
    );
  }

  Widget _buildGifTile(Map<String, dynamic> gif) {
    return GestureDetector(
      onTap: () => _onGifTap(gif),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Stack(
            children: [
              CustomImageWidget(
                imageUrl: gif["url"] as String,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                semanticLabel: gif["semanticLabel"] as String,
              ),

              // GIF indicator
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'GIF',
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Title overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Text(
                    gif["title"] as String,
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

