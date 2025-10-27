import 'package:flutter/material.dart';

import '../shims/image_picker_shim.dart';
import '../shims/sizer_shim.dart';
import '../../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';
import '../../../widgets/custom_image_widget.dart';

class GalleryThumbnailWidget extends StatefulWidget {
  final ValueChanged<XFile> onImageSelected;
  final VoidCallback? onError;

  const GalleryThumbnailWidget({
    super.key,
    required this.onImageSelected,
    this.onError,
  });

  @override
  State<GalleryThumbnailWidget> createState() => _GalleryThumbnailWidgetState();
}

class _GalleryThumbnailWidgetState extends State<GalleryThumbnailWidget> {
  final ImagePicker _picker = ImagePicker();
  List<Map<String, dynamic>> _recentImages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecentImages();
  }

  void _loadRecentImages() {
    // Mock recent images data
    _recentImages = [
      {
        "id": 1,
        "url": "https://images.unsplash.com/photo-1427745189433-923c65f8c54b",
        "semanticLabel":
            "Close-up portrait of a young woman with curly brown hair and natural makeup, smiling softly against a blurred outdoor background"
      },
      {
        "id": 2,
        "url": "https://images.unsplash.com/photo-1666147635028-406bd4615b49",
        "semanticLabel":
            "Scenic mountain landscape with snow-capped peaks reflected in a calm alpine lake during golden hour"
      },
      {
        "id": 3,
        "url": "https://images.unsplash.com/photo-1612478278673-e53b0eb67629",
        "semanticLabel":
            "Delicious homemade pizza with melted cheese, fresh basil leaves, and tomato sauce on a wooden cutting board"
      },
      {
        "id": 4,
        "url": "https://images.unsplash.com/photo-1714247084434-49bbc3ebf577",
        "semanticLabel":
            "Cute golden retriever puppy sitting in green grass with tongue out, looking happy and playful"
      },
      {
        "id": 5,
        "url": "https://images.unsplash.com/photo-1657170222276-0f3acdde4df7",
        "semanticLabel":
            "Modern minimalist living room with white sofa, wooden coffee table, and large windows with natural light"
      },
      {
        "id": 6,
        "url": "https://images.unsplash.com/photo-1594402100371-7a7fd9917b9f",
        "semanticLabel":
            "Fresh colorful salad bowl with mixed greens, cherry tomatoes, avocado slices, and olive oil dressing"
      },
    ];

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _selectFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        widget.onImageSelected(image);
      }
    } catch (e) {
      widget.onError?.call();
    }
  }

  void _onThumbnailTap(Map<String, dynamic> imageData) {
    // For demo purposes, we'll simulate selecting a gallery image
    // In a real app, this would convert the network image to XFile
    _selectFromGallery();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

          // Title and Gallery button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: _selectFromGallery,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'photo_library',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 4.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Gallery',
                        style:
                            AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Thumbnails grid
          Expanded(
            child: _isLoading
                ? _buildLoadingGrid()
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2.w,
                      mainAxisSpacing: 2.w,
                      childAspectRatio: 1,
                    ),
                    itemCount: _recentImages.length,
                    itemBuilder: (context, index) {
                      final imageData = _recentImages[index];
                      return _buildThumbnail(imageData);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
        childAspectRatio: 1,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: SizedBox(
              width: 4.w,
              height: 4.w,
              child: CircularProgressIndicator(
                color: AppTheme.lightTheme.colorScheme.primary,
                strokeWidth: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThumbnail(Map<String, dynamic> imageData) {
    return GestureDetector(
      onTap: () => _onThumbnailTap(imageData),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: CustomImageWidget(
            imageUrl: imageData["url"] as String,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            semanticLabel: imageData["semanticLabel"] as String,
          ),
        ),
      ),
    );
  }
}
