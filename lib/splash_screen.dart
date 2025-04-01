import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/constants/_assets.dart';
import 'components/widgets.dart';
import 'utils/color_palette.dart';
import 'utils/font_sizes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: kPrimaryColor,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsUtils.logo, width: 100,),
            const SizedBox(height: 20,),
            buildText('Everything Tasks', kBlackColor, textBold,
                FontWeight.w600, TextAlign.center, TextOverflow.clip),
            const SizedBox(
              height: 10,
            ),
            buildText('Schedule your week with ease', kBlackColor, textTiny,
                FontWeight.normal, TextAlign.center, TextOverflow.clip),
          ],
        )));
  }
}
