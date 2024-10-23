import 'package:flutter/cupertino.dart';
import 'package:platform_converter_app/components/ios_comp/call.dart';
import 'package:platform_converter_app/components/ios_comp/chat.dart';
import 'package:platform_converter_app/components/ios_comp/setting.dart';
import 'package:platform_converter_app/providers/platform_provider.dart';
import 'package:provider/provider.dart';

class HomePageIos extends StatefulWidget {
  const HomePageIos({super.key});

  @override
  State<HomePageIos> createState() => _HomePageIosState();
}

class _HomePageIosState extends State<HomePageIos> {
  List<Widget> allComponents = [
    Chat(),
    Call(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    var platformProvider = Provider.of<PlatformProvider>(context);
    var platformProviderFalse =
        Provider.of<PlatformProvider>(context, listen: false);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Home"),
        trailing: CupertinoSwitch(
          value: platformProvider.isIos,
          onChanged: (value) {
            platformProviderFalse.changePlatform();
          },
        ),
      ),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone_fill),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: allComponents[index],
                );
              },
            );
          }),
    );
  }
}
