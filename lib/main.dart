import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/providers/contact_provider.dart';
import 'package:platform_converter_app/providers/month_provider.dart';
import 'package:platform_converter_app/providers/platform_provider.dart';
import 'package:platform_converter_app/screens/android/home_page.dart';
import 'package:platform_converter_app/screens/ios/home_page_ios.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MonthProvider(),
        )
      ],
      builder: (context, _) {
        return (Provider.of<PlatformProvider>(context).isIos == false)
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                routes: {
                  "/": (context) => HomePage(),
                },
                theme: ThemeData.light(useMaterial3: true),
                darkTheme: ThemeData.dark(useMaterial3: true),
                themeMode: ThemeMode.system,
              )
            : CupertinoApp(
                debugShowCheckedModeBanner: false,
                routes: {
                  "/": (context) => HomePageIos(),
                },
              );
      },
    );
  }
}
