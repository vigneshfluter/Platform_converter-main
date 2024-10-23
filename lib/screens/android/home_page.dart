import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_converter_app/components/android_comp/calls.dart';
import 'package:platform_converter_app/components/android_comp/chats.dart';
import 'package:platform_converter_app/components/android_comp/settings.dart';
import 'package:platform_converter_app/providers/platform_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/contact_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> allComponents = [
    Chats(),
    Calls(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    var platformProvider = Provider.of<PlatformProvider>(context);
    var platformProviderFalse =
        Provider.of<PlatformProvider>(context, listen: false);

    return DefaultTabController(
      length: allComponents.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          actions: [
            Switch(
              value: platformProvider.isIos,
              onChanged: (value) {
                platformProviderFalse.changePlatform();
              },
            )
          ],
          bottom: TabBar(
            tabs: const <Tab>[
              Tab(
                text: 'Chat',
              ),
              Tab(
                text: 'Calls',
              ),
              Tab(
                text: 'Settings',
              ),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8),
          child: TabBarView(children: allComponents),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertBox();
              },
            );
          },
          child: const Icon(
            Icons.add,
            size: 35,
          ),
        ),
        drawer: const Navbar(),
      ),
    );
  }
}

class AlertBox extends StatefulWidget {
  const AlertBox({super.key});

  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    var contactprovider = Provider.of<ContactProvider>(context);
    var contactproviderfalse =
        Provider.of<ContactProvider>(context, listen: false);

    return AlertDialog(
      title: Text("Add Contact"),
      content: SizedBox(
        height: 480,
        width: 450,
        child: Stepper(
          currentStep: contactprovider.current_step,
          controlsBuilder: (context, details) {
            if (contactprovider.current_step == 0) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      contactproviderfalse.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                ],
              );
            } else if (contactprovider.current_step == 3) {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      contactproviderfalse.checkFilledData();
                      contactprovider.current_step = 0;
                      Navigator.pop(context);
                    },
                    child: const Text('Finish'),
                  ),
                  TextButton(
                    onPressed: () {
                      contactproviderfalse.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      contactproviderfalse.checkContinueState();
                    },
                    child: const Text('Continue'),
                  ),
                  TextButton(
                    onPressed: () {
                      contactproviderfalse.checkCancelState();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            }
          },
          steps: [
            Step(
              state: (contactprovider.current_step == 0)
                  ? StepState.editing
                  : StepState.complete,
              title: Text("Contact Image"),
              content: Column(
                children: [
                  (contactprovider.profileImageVar != null)
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              FileImage(File(contactprovider.profileImageVar!)),
                        )
                      : CircleAvatar(
                          radius: 40,
                          child: FlutterLogo(),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          contactproviderfalse.ImagePickerCamera();
                        },
                        child: Icon(Icons.camera),
                      ),
                      FloatingActionButton(
                        mini: true,
                        onPressed: () {
                          contactproviderfalse.ImagePickerGalary();
                        },
                        child: Icon(Icons.photo),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Step(
              state: (contactprovider.current_step < 1)
                  ? StepState.indexed
                  : (contactprovider.current_step == 1)
                      ? StepState.editing
                      : (contactprovider.nameController.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: Text("Name"),
              content: TextField(
                  controller: contactprovider.nameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Name')),
            ),
            Step(
              state: (contactprovider.current_step < 2)
                  ? StepState.indexed
                  : (contactprovider.current_step == 2)
                      ? StepState.editing
                      : (contactprovider.phoneController.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: Text("Phone Number"),
              content: TextField(
                  controller: contactprovider.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Phone Number')),
            ),
            Step(
              state: (contactprovider.current_step < 3)
                  ? StepState.indexed
                  : (contactprovider.current_step == 3)
                      ? StepState.editing
                      : (contactprovider.emailController.text.isEmpty)
                          ? StepState.error
                          : StepState.complete,
              title: Text("Email"),
              content: TextField(
                  controller: contactprovider.emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your Email')),
            ),
          ],
        ),
      ),
    );
  }
}



class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Batman'),
            accountEmail: const Text(
              '+91 99887 74455',
              // style: TextStyle(color: Colors.grey),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/img/batman.jpg'),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://wallpapers.com/images/hd/simple-batman-metal-logo-ahqvts7n7p74k9dt.jpg')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('New Contact'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Calls'),
            onTap: () {},
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.bookmark_border),
            title: Text('Saved Messages'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
