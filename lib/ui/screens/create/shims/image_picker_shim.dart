// Minimal shim for ImagePicker/XFile to allow UI iteration without the real plugin.
class XFile {
  final String path;
  XFile(this.path);
}

enum ImageSource { gallery, camera }

class ImagePicker {
  Future<XFile?> pickImage(
      {required ImageSource source,
      int? maxWidth,
      int? maxHeight,
      int? imageQuality}) async {
    // For UI development, return a sample network image so the preview can show
    // a real picture when running on web/desktop. In a real mobile run the
    // real plugin should be used instead of this shim.
    return XFile(
        'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?fit=crop&w=1024&q=80');
  }

  Future<List<XFile>> pickMultiImage() async => [];
}
