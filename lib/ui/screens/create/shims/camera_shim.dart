// Minimal camera shim for UI development
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'image_picker_shim.dart';

class CameraDescription {
  final String name;
  final CameraLensDirection lensDirection;
  CameraDescription(this.name, {this.lensDirection = CameraLensDirection.back});
}

Future<List<CameraDescription>> availableCameras() async =>
    [CameraDescription('default')];

class CameraValue {
  final bool isInitialized;
  CameraValue({this.isInitialized = true});
}

class CameraController {
  final CameraDescription description;
  CameraController(this.description, [ResolutionPreset? preset]);
  CameraValue value = CameraValue(isInitialized: true);
  Future<void> initialize() async {}
  Future<void> dispose() async {}
  Future<void> setFocusMode(FocusMode mode) async {}
  Future<void> setFlashMode(FlashMode mode) async {}
  // Return a sample image URL when taking a picture in the shim so the
  // preview and selection flow can be tested in web/desktop UI iteration.
  Future<XFile> takePicture() async => XFile(
      'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?fit=crop&w=1024&q=80');
}

enum ResolutionPreset { low, medium, high }

enum CameraLensDirection { front, back }

enum FlashMode { off, auto, torch }

enum FocusMode { auto }

/// Simple CameraPreview widget used in UI stubs
class CameraPreview extends StatelessWidget {
  final CameraController controller;
  const CameraPreview(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    // Friendly placeholder for web / shimmed camera preview.
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF111111),
            const Color(0xFF444444),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt, color: Colors.white70, size: 48),
            const SizedBox(height: 8),
            const Text('Camera preview (web shim)',
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
