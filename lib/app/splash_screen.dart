import 'dart:math';
import 'package:flutter/material.dart';
import '../generated/app_localizations.dart';

const kSplashDuration = Duration(milliseconds: 3000);

class SplashScreen extends StatefulWidget {
  final Widget child;
  const SplashScreen({super.key, required this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final Animation<double> _fadeOut;
  late final int _phraseIndex;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _phraseIndex = Random().nextInt(10);
    _controller = AnimationController(
      vsync: this,
      duration: kSplashDuration,
    );
    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.15, curve: Curves.easeIn),
    );
    _fadeOut = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.75, 1.0, curve: Curves.easeOut),
    );
    _controller.forward().then((_) {
      if (mounted) setState(() => _done = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phrases = AppLocalizations.of(context)!.splashPhrases.split('|');
    final phrase = phrases[_phraseIndex % phrases.length];

    // widget.child всегда на позиции 0 — никогда не размонтируется.
    // Если убрать это условие, BiometricGate будет пересоздаваться при
    // переходе из Stack → прямой возврат, что вызывает повторный initState.
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (!_done)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final opacity = _fadeIn.value * (1.0 - _fadeOut.value);
              if (opacity <= 0) return const SizedBox.shrink();
              return Opacity(
                opacity: opacity,
                child: _SplashContent(phrase: phrase),
              );
            },
          ),
      ],
    );
  }
}

class _SplashContent extends StatelessWidget {
  final String? phrase;
  const _SplashContent({this.phrase});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF1B2640),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Hero(
              tag: 'app_logo',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.asset('icons/1024.png', width: 120, height: 120),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'RentFlow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            const Spacer(flex: 2),
            if (phrase != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  phrase!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF8DA4C8),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
