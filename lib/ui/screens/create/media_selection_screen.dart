import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

// Use local shim for UI iteration and to keep the analyzer happy in all targets.
// The shim exposes the same minimal API as the real plugin (XFile, ImagePicker,
// ImageSource). If you want to enable the real native plugin for mobile runs,
// replace this import with the package import and ensure permissions are set.
import 'shims/image_picker_shim.dart';
import 'shims/permission_handler_shim.dart';
import 'shims/sizer_shim.dart';

import '../../../core/app_export.dart';
import 'creat_post_widget/camera_preview_widget.dart';
import 'creat_post_widget/gallery_thumbnail_widget.dart';
import 'creat_post_widget/gif_search_widget.dart';
import 'creat_post_widget/media_options_widget.dart';
import 'creat_post_widget/poll_creation_widget.dart';
import '../../widgets/custom_icon_widget.dart';

class MediaSelectionScreen extends StatefulWidget {
  const MediaSelectionScreen({super.key});

  @override
  State<MediaSelectionScreen> createState() => _MediaSelectionScreenState();
}

class _MediaSelectionScreenState extends State<MediaSelectionScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  // Media selection state
  XFile? _selectedImage;
  String? _selectedGif;
  Map<String, dynamic>? _selectedPoll;

  // UI state
  bool _showGalleryThumbnails = true;
  bool _showGifSearch = false;
  bool _showPollCreation = false;
  bool _showMediaOptions = false;

  // Camera state
  bool _cameraError = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _checkPermissions();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    if (kIsWeb) return;

    final cameraStatus = await Permission.camera.status;
    final storageStatus = await Permission.storage.status;

    if (!cameraStatus.isGranted || !storageStatus.isGranted) {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Permissions Required',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'This app needs camera and storage permissions to capture and select media.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _onPhotoTaken(XFile photo) {
    // Keep the photo selected in the preview instead of immediately returning
    setState(() {
      _selectedImage = photo;
      _selectedGif = null;
      _selectedPoll = null;
    });
  }

  void _onImageSelected(XFile image) {
    // Keep the gallery selection in the preview instead of immediately returning
    setState(() {
      _selectedImage = image;
      _selectedGif = null;
      _selectedPoll = null;
    });
  }

  void _onGifSelected(String gifUrl) {
    setState(() {
      _selectedGif = gifUrl;
      _selectedImage = null;
      _selectedPoll = null;
    });
    _returnToPostCreation();
  }

  void _onPollCreated(Map<String, dynamic> pollData) {
    setState(() {
      _selectedPoll = pollData;
      _selectedImage = null;
      _selectedGif = null;
    });
    _returnToPostCreation();
  }

  void _returnToPostCreation() {
    // In a real app, this would navigate back to post creation with selected media
    Navigator.of(context).pop({
      'image': _selectedImage,
      'gif': _selectedGif,
      'poll': _selectedPoll,
    });
  }

  void _onCameraError() {
    setState(() {
      _cameraError = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Camera not available. Please check permissions.'),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        action: SnackBarAction(
          label: 'Settings',
          textColor: Colors.white,
          onPressed: () => openAppSettings(),
        ),
      ),
    );
  }

  void _hideMediaOptions() {
    setState(() {
      _showMediaOptions = false;
      _showGalleryThumbnails = true;
    });
  }

  void _hideGifSearch() {
    setState(() {
      _showGifSearch = false;
      _showMediaOptions = true;
    });
  }

  void _hidePollCreation() {
    setState(() {
      _showPollCreation = false;
      _showMediaOptions = true;
    });
  }

  Future<void> _openCameraApp() async {
    try {
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _selectedImage = photo;
          _selectedGif = null;
          _selectedPoll = null;
        });
      }
    } catch (e) {
      _onCameraError();
    }
  }

  @override
  Widget build(BuildContext context) {
    // When embedded inside another Scaffold (for example the Create page),
    // we avoid returning a nested Scaffold so parent bottom bars remain visible.
    return Container(
      color: AppTheme.lightTheme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // App bar (consistent with other screens) - use mediaCreation factory
                CustomAppBar.mediaCreation(
                  title: 'Select Media',
                  onClose: null, // left close removed per UX request
                  showNext: false,
                ),

                const SizedBox(height: 8),

                // Camera preview or error state (button inside this area)
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // --- If an image is selected, show it ---
                        if (_selectedImage != null)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: GestureDetector(
                                onTap: () {
                                  // show full screen preview in a dialog
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: kIsWeb
                                            ? Image.network(
                                                _selectedImage!.path,
                                                fit: BoxFit.contain,
                                              )
                                            : Image.file(
                                                File(_selectedImage!.path),
                                                fit: BoxFit.contain,
                                              ),
                                      ),
                                    ),
                                  );
                                },
                                    child: _selectedImage!.path.startsWith('http')
                                        ? Image.network(
                                            _selectedImage!.path,
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            File(_selectedImage!.path),
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                          )
                        else
                          // --- Else, show the camera preview ---
                          Positioned.fill(
                            child: _cameraError
                                ? _buildCameraErrorState()
                                : CameraPreviewWidget(
                                    onPhotoTaken: _onPhotoTaken,
                                    onError: _onCameraError,
                                  ),
                          ),

                        // --- Overlay for light gradient / contrast ---
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.14),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // --- Camera button (top-left) only visible if NO image selected ---
                        if (_selectedImage == null)
                          Positioned(
                            top: 12,
                            left: 12,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(999),
                                onTap: () async {
                                  // small feedback so taps are obvious during development
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Opening camera...'),
                                      duration: Duration(milliseconds: 700),
                                    ),
                                  );
                                  await _openCameraApp();
                                },
                                child: Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: AppTheme
                                        .lightTheme.colorScheme.primary
                                        .withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppTheme
                                        .lightTheme.colorScheme.onSurface,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // --- Add Media (+) button on top-right ---
                        if (_selectedImage == null)
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(999),
                                onTap: () {
                                  setState(() {
                                    _showMediaOptions = true;
                                    _showGalleryThumbnails = false;
                                  });
                                },
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: AppTheme
                                        .lightTheme.colorScheme.primary
                                        .withValues(alpha: 0.12),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme
                                            .lightTheme.colorScheme.primary
                                            .withValues(alpha: 0.18),
                                        blurRadius: 22,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: CustomIconWidget(
                                    iconName: 'add',
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Mode selector
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Photo'),
                      Tab(text: 'Video'),
                      Tab(text: 'Story'),
                    ],
                    labelStyle:
                        AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle:
                        AppTheme.lightTheme.textTheme.labelMedium,
                    indicator: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppTheme
                        .lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                    dividerColor: Colors.transparent,
                  ),
                ),

                const SizedBox(height: 8),

                // Bottom section
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    child: _showGalleryThumbnails &&
                            !_showMediaOptions &&
                            !_showGifSearch &&
                            !_showPollCreation
                        ? GalleryThumbnailWidget(
                            onImageSelected: _onImageSelected,
                            onError: _onCameraError,
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ],
            ),

            // Overlay widgets
            if (_showMediaOptions)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MediaOptionsWidget(
                  onCameraPressed: _hideMediaOptions,
                  onGalleryPressed: () async {
                    final picker = ImagePicker();
                    final image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      _onImageSelected(image);
                    }
                    _hideMediaOptions();
                  },
                  onGifPressed: () {
                    setState(() {
                      _showGifSearch = true;
                      _showMediaOptions = false;
                      _showGalleryThumbnails = false;
                    });
                  },
                  onPollPressed: () {
                    setState(() {
                      _showPollCreation = true;
                      _showMediaOptions = false;
                      _showGalleryThumbnails = false;
                    });
                  },
                ),
              ),

            if (_showGifSearch)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GifSearchWidget(
                  onGifSelected: _onGifSelected,
                  onClose: _hideGifSearch,
                ),
              ),

            if (_showPollCreation)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: PollCreationWidget(
                  onPollCreated: _onPollCreated,
                  onClose: _hidePollCreation,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraErrorState() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'camera_alt_outlined',
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.4),
            size: 15.w,
          ),
          SizedBox(height: 2.h),
          Text(
            'Camera Not Available',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Please check camera permissions',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.4),
            ),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: () => openAppSettings(),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
