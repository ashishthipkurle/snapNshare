import 'package:flutter/material.dart';
import '../widgets/gradient_button.dart';
import '../widgets/animated_fade_up.dart';
import '../widgets/floating_circle.dart';
import '../../theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: kGradientBg)),
          Positioned(
              left: 40,
              top: 120,
              child: FloatingCircle(size: 80, color: kPrimary, dx: 0, dy: 0)),
          Positioned(
              right: 60,
              bottom: 160,
              child: FloatingCircle(size: 64, color: kSecondary, dx: 0, dy: 0)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: AnimatedFadeUp(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('snapNshare',
                        style: TextStyle(
                            fontSize: 42, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white.withOpacity(0.7),
                          boxShadow: kShadowMedium),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset('assets/welcome-illustration.png',
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 20),
                    const Text('Share moments.',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const Text('Start conversations',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    GradientButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/signup'),
                        child: const Text('Get Started')),
                    const SizedBox(height: 12),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/login'),
                          child: const Text('Log In')),
                      const Text('·'),
                      TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/home'),
                          child: const Text('Learn More'))
                    ])
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
