import 'package:flutter/material.dart';
import 'package:paystome/helper/core/app_constant.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/core/state_controller.dart';
import 'package:paystome/view/splash/screen_splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderStateController.providers,
      child: MaterialApp(
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: AppConstant.appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          primarySwatch: AppColoring.primaryApp,
          useMaterial3: true,
        ),
        home: const ScreenSplash(),
      ),
    );
  }
}
