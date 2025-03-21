import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _showText = false;
  bool _isExiting = false;
  double _sparklePosition = -1.0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showText = true;
      });
      _startSparkleAnimation();
    });

    Timer(const Duration(seconds: 8), () {
      setState(() {
        _isExiting = true;
      });

      Timer(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                )),
                child: child,
              );
            },
            transitionDuration: const Duration(seconds: 1),
          ),
        );
      });
    });
  }

  void _startSparkleAnimation() {
    const duration = Duration(seconds: 2);
    const interval = Duration(milliseconds: 16);
    Timer.periodic(interval, (timer) {
      if (_sparklePosition >= 1.0) {
        _sparklePosition = -1.0;
      } else {
        setState(() {
          _sparklePosition += interval.inMilliseconds / duration.inMilliseconds;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A043C), // Very Dark Purple
                  Color(0xFF0D1B2A), // Dark Blue
                  Color(0xFF1B263B), // Deep Blue
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.5),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.5),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Stack(
                children: [
                  _animatedIcon(FontAwesomeIcons.cameraRetro, 50, 100, 60, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.photoVideo, 200, 250, 70, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.images, 120, 400, 65, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.calendarDay, 300, 200, 55, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.peopleGroup, 350, 500, 75, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.music, 50, 600, 55, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.champagneGlasses, 270, 450, 50, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.video, 400, 300, 65, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.ring, 250, 550, 50, screenWidth, screenHeight),
                  _animatedIcon(FontAwesomeIcons.gift, 150, 650, 55, screenWidth, screenHeight),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.5,
                )
                    .animate()
                    .fadeIn(duration: 1200.ms)
                    .shake(delay: 1000.ms, hz: 4)
                    .then(delay: 500.ms)
                    .slide(begin: const Offset(0, -0.5), end: Offset.zero)
                    .then()
                    .blur(
                  begin: const Offset(0, 0),
                  end: const Offset(5, 5),
                  duration: 1000.ms,
                  curve: Curves.easeInOut,
                )
                    .then()
                    .blur(
                  begin: const Offset(5, 5),
                  end: const Offset(0, 0),
                  duration: 1000.ms,
                  curve: Curves.easeInOut,
                ),
              ],
            ),
          ),

          if (_showText)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.1),
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: const [Colors.transparent, Colors.yellow, Colors.transparent],
                      stops: const [0.0, 0.5, 1.0],
                      begin: Alignment(_sparklePosition, 0.0),
                      end: Alignment(_sparklePosition + 1.0, 0.0),
                      tileMode: TileMode.clamp,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcATop,
                  child: const Text(
                    'Capture your dream',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _animatedIcon(IconData icon, double left, double top, double size, double screenWidth, double screenHeight) {
    return Positioned(
      left: left * (screenWidth / 500),
      top: top * (screenHeight / 800),
      child: Icon(
        icon,
        size: size * (screenWidth / 500),
        color: Colors.white.withValues(alpha: 0.6),
      )
          .animate(
        onPlay: (controller) {
          controller.repeat(reverse: true);
        },
      )
          .fadeIn(duration: 2500.ms)
          .moveY(begin: 0, end: 12, duration: 10000.ms, curve: Curves.easeInOut),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A043C),
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: const Color(0xFF0D1B2A),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Screen!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B263B),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}