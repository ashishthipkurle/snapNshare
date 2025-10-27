import 'package:flutter/material.dart';
import 'ui/screens/welcome.dart';
import 'ui/screens/login.dart';
import 'ui/screens/signup.dart';
import 'ui/screens/home.dart';
import 'ui/screens/create/create.dart';
import 'ui/screens/explore.dart';
import 'ui/screens/notifications_screen.dart';
import 'ui/screens/snapverse/snapverse.dart';
import 'ui/screens/messages.dart';
import 'ui/screens/profile.dart';
import 'ui/screens/settings.dart';
import 'ui/screens/not_found.dart';

void main() {
  runApp(const SnapNshareApp());
}

class SnapNshareApp extends StatelessWidget {
  const SnapNshareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SnapNsharePage(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const StoriesScreen(),
        '/create': (context) => const CreatePage(),
        '/explore': (context) => const ExplorePage(),
  '/notifications': (context) => const NotificationsScreen(),
  '/snapverse': (context) => const SnapVersePage(),
  '/messages': (context) => const MessagesPage(),
        '/profile': (context) => const ProfilePage(),
        '/settings': (context) => const SettingsPage(),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (_) => const NotFoundPage()),
    );
  }
}

class SnapNsharePage extends StatelessWidget {
  const SnapNsharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2DD4BF),
              Color(0xFF5EEAD4),
              Color(0xFFE9D5FF),
              Color(0xFFF9A8D4),
              Color(0xFF1E293B),
            ],
            stops: [0.0, 0.3, 0.5, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    // Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'S',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2DD4BF),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'snapNshare',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Main Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.4),
                              Colors.white.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            // Illustration Area
                            SizedBox(
                              height: 280,
                              child: Stack(
                                children: [
                                  CustomPaint(
                                    painter: IllustrationPainter(),
                                    child: Container(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            // Text Content
                            const Text(
                              'Share moments.',
                              style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Start conversations',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 48),
                            // Get Started Button
                            Container(
                              width: double.infinity,
                              height: 64,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFFFDA4AF),
                                    Color(0xFFC084FC),
                                    Color(0xFF60A5FA),
                                    Color(0xFF2DD4BF),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pushNamed('/signup'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Bottom Navigation
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/login'),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 80),
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/home'),
                            child: const Text(
                              'Learn More',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bottom Indicator
                    Container(
                      width: 120,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    // Purple accent dots
    final purpleDotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFA855F7);

    canvas.drawCircle(
        Offset(size.width * 0.18, size.height * 0.15), 6, purpleDotPaint);
    canvas.drawCircle(
        Offset(size.width * 0.38, size.height * 0.88), 6, purpleDotPaint);

    // Light circle decorations
    final lightCirclePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFE9D5FF).withOpacity(0.3)
      ..strokeWidth = 2;

    canvas.drawCircle(
        Offset(size.width * 0.87, size.height * 0.18), 15, lightCirclePaint);
    canvas.drawCircle(
        Offset(size.width * 0.48, size.height * 0.42), 20, lightCirclePaint);

    // Left Person
    // Head
    final leftHeadPath = Path();
    leftHeadPath.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.2, size.height * 0.28),
      radius: 20,
    ));
    canvas.drawPath(leftHeadPath, fillPaint);

    // Hair
    final leftHairPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    final leftHairPath = Path();
    leftHairPath.moveTo(size.width * 0.18, size.height * 0.24);
    leftHairPath.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.2,
      size.width * 0.22,
      size.height * 0.24,
    );
    canvas.drawPath(leftHairPath, leftHairPaint);

    // Body - torso
    final leftTorsoPath = Path();
    leftTorsoPath.moveTo(size.width * 0.2, size.height * 0.35);
    leftTorsoPath.lineTo(size.width * 0.16, size.height * 0.42);
    leftTorsoPath.lineTo(size.width * 0.16, size.height * 0.58);
    leftTorsoPath.lineTo(size.width * 0.24, size.height * 0.58);
    leftTorsoPath.lineTo(size.width * 0.24, size.height * 0.42);
    leftTorsoPath.close();
    canvas.drawPath(leftTorsoPath, fillPaint);

    // Left person - tablet in hand
    final tabletPath = Path();
    final tabletRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.25, size.height * 0.47, 35, 28),
      const Radius.circular(4),
    );
    tabletPath.addRRect(tabletRect);
    canvas.drawPath(tabletPath, Paint()..color = const Color(0xFFD1D5DB));
    canvas.drawPath(tabletPath, paint);

    // Left arm holding tablet
    final leftArmPath = Path();
    leftArmPath.moveTo(size.width * 0.24, size.height * 0.42);
    leftArmPath.lineTo(size.width * 0.25, size.height * 0.52);
    canvas.drawPath(leftArmPath, paint);

    leftArmPath.moveTo(size.width * 0.24, size.height * 0.5);
    leftArmPath.lineTo(size.width * 0.28, size.height * 0.58);
    canvas.drawPath(leftArmPath, paint);

    // Left person legs
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.58),
      Offset(size.width * 0.15, size.height * 0.78),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.22, size.height * 0.58),
      Offset(size.width * 0.22, size.height * 0.78),
      paint,
    );

    // Right Person (Woman)
    // Head
    final rightHeadPath = Path();
    rightHeadPath.addOval(Rect.fromCircle(
      center: Offset(size.width * 0.8, size.height * 0.38),
      radius: 20,
    ));
    canvas.drawPath(rightHeadPath, fillPaint);

    // Long hair
    final hairPath = Path();
    hairPath.moveTo(size.width * 0.78, size.height * 0.32);
    hairPath.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.28,
      size.width * 0.88,
      size.height * 0.38,
    );
    hairPath.quadraticBezierTo(
      size.width * 0.89,
      size.height * 0.48,
      size.width * 0.86,
      size.height * 0.55,
    );
    canvas.drawPath(hairPath, fillPaint);

    // Body
    final rightTorsoPath = Path();
    rightTorsoPath.moveTo(size.width * 0.8, size.height * 0.45);
    rightTorsoPath.lineTo(size.width * 0.76, size.height * 0.52);
    rightTorsoPath.lineTo(size.width * 0.76, size.height * 0.65);
    rightTorsoPath.lineTo(size.width * 0.84, size.height * 0.65);
    rightTorsoPath.lineTo(size.width * 0.84, size.height * 0.52);
    rightTorsoPath.close();
    canvas.drawPath(rightTorsoPath, fillPaint);

    // Right person arm
    canvas.drawLine(
      Offset(size.width * 0.76, size.height * 0.52),
      Offset(size.width * 0.68, size.height * 0.55),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.68, size.height * 0.55),
      Offset(size.width * 0.68, size.height * 0.62),
      paint,
    );

    // Right person legs
    canvas.drawLine(
      Offset(size.width * 0.78, size.height * 0.65),
      Offset(size.width * 0.76, size.height * 0.78),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.82, size.height * 0.65),
      Offset(size.width * 0.84, size.height * 0.78),
      paint,
    );

    // Center large image frame
    final centerImageRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.52),
        width: 95,
        height: 115,
      ),
      const Radius.circular(8),
    );

    final imageGradient = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF60A5FA),
          Color(0xFFA78BFA),
          Color(0xFFF472B6),
        ],
      ).createShader(centerImageRect.outerRect);

    canvas.drawRRect(centerImageRect, imageGradient);
    canvas.drawRRect(centerImageRect, paint);

    // Top left small image bubble
    final topLeftImageRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.3, size.height * 0.25, 48, 42),
      const Radius.circular(6),
    );

    final topLeftGradient = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF8B5CF6), Color(0xFF60A5FA)],
      ).createShader(topLeftImageRect.outerRect);

    canvas.drawRRect(topLeftImageRect, topLeftGradient);
    canvas.drawRRect(topLeftImageRect, paint);

    // Small image inside top left bubble
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.34, size.height * 0.32)
        ..lineTo(size.width * 0.34, size.height * 0.285)
        ..lineTo(size.width * 0.36, size.height * 0.29)
        ..lineTo(size.width * 0.37, size.height * 0.32)
        ..close(),
      Paint()..color = const Color(0xFF8B5CF6),
    );

    // Right text bubble
    final rightBubblePath = Path();
    final rightBubbleRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.62, size.height * 0.35, 80, 42),
      const Radius.circular(8),
    );
    rightBubblePath.addRRect(rightBubbleRect);
    canvas.drawPath(rightBubblePath, Paint()..color = Colors.white);
    canvas.drawPath(rightBubblePath, paint);

    // Lines in text bubble
    canvas.drawLine(
      Offset(size.width * 0.66, size.height * 0.39),
      Offset(size.width * 0.74, size.height * 0.39),
      paint..strokeWidth = 2,
    );
    canvas.drawLine(
      Offset(size.width * 0.66, size.height * 0.43),
      Offset(size.width * 0.74, size.height * 0.43),
      paint..strokeWidth = 2,
    );
    canvas.drawLine(
      Offset(size.width * 0.66, size.height * 0.47),
      Offset(size.width * 0.7, size.height * 0.47),
      paint..strokeWidth = 2,
    );

    // Connecting curves
    paint.strokeWidth = 2;

    // From left person to top image
    final curve1 = Path();
    curve1.moveTo(size.width * 0.28, size.height * 0.48);
    curve1.quadraticBezierTo(
      size.width * 0.32,
      size.height * 0.36,
      size.width * 0.37,
      size.height * 0.32,
    );
    canvas.drawPath(curve1, paint);

    // From top image to center device
    final curve2 = Path();
    curve2.moveTo(size.width * 0.42, size.height * 0.42);
    curve2.quadraticBezierTo(
      size.width * 0.44,
      size.height * 0.46,
      size.width * 0.455,
      size.height * 0.48,
    );
    canvas.drawPath(curve2, paint);

    // From center device to right bubble
    final curve3 = Path();
    curve3.moveTo(size.width * 0.545, size.height * 0.48);
    curve3.quadraticBezierTo(
      size.width * 0.58,
      size.height * 0.46,
      size.width * 0.62,
      size.height * 0.48,
    );
    canvas.drawPath(curve3, paint);

    // From right bubble to right person
    final curve4 = Path();
    curve4.moveTo(size.width * 0.7, size.height * 0.5);
    curve4.quadraticBezierTo(
      size.width * 0.73,
      size.height * 0.54,
      size.width * 0.76,
      size.height * 0.58,
    );
    canvas.drawPath(curve4, paint);

    // Arrow dots
    final pinkDot = Paint()..color = const Color(0xFFF472B6);
    canvas.drawCircle(
        Offset(size.width * 0.42, size.height * 0.31), 5, pinkDot);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.65), 5, pinkDot);

    // Teal arrow accent
    final tealDot = Paint()..color = const Color(0xFF14B8A6);
    canvas.drawCircle(Offset(size.width * 0.53, size.height * 0.7), 5, tealDot);

    // Ground line
    paint.strokeWidth = 2.5;
    canvas.drawLine(
      Offset(size.width * 0.12, size.height * 0.78),
      Offset(size.width * 0.88, size.height * 0.78),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
