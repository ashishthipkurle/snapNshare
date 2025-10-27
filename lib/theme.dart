import 'package:flutter/material.dart';

// Helper to convert HSL values used in Tailwind CSS variables into Flutter Color
Color hsl(double h, double sPercent, double lPercent) {
  return HSLColor.fromAHSL(1.0, h, sPercent / 100.0, lPercent / 100.0)
      .toColor();
}

// Design tokens (light theme) from src/index.css
final Color kBackground = hsl(240, 20, 99);
final Color kForeground = hsl(240, 10, 10);

final Color kCard = hsl(0, 0, 100);
final Color kCardForeground = hsl(240, 10, 10);

final Color kPrimary = hsl(180, 85, 55);
final Color kPrimaryForeground = hsl(0, 0, 100);

final Color kSecondary = hsl(330, 85, 70);
final Color kSecondaryForeground = hsl(0, 0, 100);

final Color kMuted = hsl(240, 10, 96);
final Color kMutedForeground = hsl(240, 5, 50);

final Color kAccent = hsl(270, 70, 65);
final Color kAccentForeground = hsl(0, 0, 100);

final Color kDestructive = hsl(0, 84.2, 60.2);
final Color kDestructiveForeground = hsl(0, 0, 100);

final Color kBorder = hsl(240, 10, 90);
final Color kInput = hsl(240, 10, 95);

// Gradients (approximate equivalents)
final Gradient kGradientPrimary = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [hsl(180, 85, 55), hsl(330, 85, 70)],
);

final Gradient kGradientSecondary = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [hsl(250, 70, 65), hsl(200, 85, 60)],
);

final Gradient kGradientBg = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [hsl(180, 80, 85), hsl(330, 80, 90)],
);

// Small AppTheme helper so older snippet that references AppTheme.storyGradient works
class AppTheme {
  static Gradient get storyGradient => kGradientPrimary;
}

// Shadows
final List<BoxShadow> kShadowSoft = [
  BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 24,
      offset: const Offset(0, 4))
];
final List<BoxShadow> kShadowMedium = [
  BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 32,
      offset: const Offset(0, 8))
];
final List<BoxShadow> kShadowGlow = [
  BoxShadow(
      color: const Color.fromRGBO(94, 234, 212, 0.3),
      blurRadius: 32,
      offset: const Offset(0, 8))
];

// Small convenience ThemeData generator
ThemeData buildAppTheme({bool dark = false}) {
  if (!dark) {
    return ThemeData(
      primaryColor: kPrimary,
      scaffoldBackgroundColor: kBackground,
      appBarTheme: AppBarTheme(
          backgroundColor: kCard,
          foregroundColor: kCardForeground,
          elevation: 0),
      colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimary,
          primary: kPrimary,
          background: kBackground,
          onBackground: kForeground,
          surface: kCard,
          onSurface: kCardForeground),
    );
  } else {
    // dark tokens from index.css (approximations)
    final bg = hsl(240, 20, 8);
    final fg = hsl(240, 10, 95);
    final card = hsl(240, 15, 12);
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: kPrimary,
      scaffoldBackgroundColor: bg,
      appBarTheme:
          AppBarTheme(backgroundColor: card, foregroundColor: fg, elevation: 0),
      colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimary,
          primary: kPrimary,
          background: bg,
          onBackground: fg,
          surface: card,
          onSurface: fg),
    );
  }
}

