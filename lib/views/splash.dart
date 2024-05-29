import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/views/home/home.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward().then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: 30.0),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 150.0,
                  height: 150.0,
                  child: CircularProgressIndicator(
                    value: _animation.value,
                    strokeWidth: 8.0,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
                    backgroundColor: AppColors.gold.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  child: Text(
                    '${(_animation.value * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
