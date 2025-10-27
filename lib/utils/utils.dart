// Small utility helpers converted from src/lib/utils.ts

String truncate(String s, [int max = 100]) {
  if (s.length <= max) return s;
  return s.substring(0, max) + '...';
}

String timeAgo(DateTime dt) {
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return 'just now';
  if (diff.inHours < 1) return '${diff.inMinutes}m';
  if (diff.inDays < 1) return '${diff.inHours}h';
  return '${diff.inDays}d';
}

T? safeGet<T>(T? Function() getter) {
  try {
    return getter();
  } catch (_) {
    return null;
  }
}

