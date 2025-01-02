import 'package:agecalculator/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:agecalculator/views/age_calculator_view/age_calculator_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed (const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AgeCalculatorView()),
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
      backgroundColor: AppColors.kContentColor,
      body: FadeTransition(
        opacity: _animation,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.hourglass_bottom,
                color: AppColors.kTextAndIconColor,
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'مرحبا بك في تطبيق\n"اعرف عمرك"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextAndIconColor,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'لنحسب العمر معاً بدقة وسهولة!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.kTextAndIconColors,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
