class PermissionStatus {
  final bool isGranted;
  PermissionStatus(this.isGranted);
}

class Permission {
  static final camera = Permission();
  static final storage = Permission();

  Future<PermissionStatus> get status async => PermissionStatus(true);
  Future<PermissionStatus> request() async => PermissionStatus(true);
}

Future<void> openAppSettings() async {}

