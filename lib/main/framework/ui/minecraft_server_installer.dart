import 'package:flutter/material.dart';
import 'package:minecraft_server_installer/main/framework/ui/basic_configuration_tab.dart';

class MinecraftServerInstaller extends StatelessWidget {
  const MinecraftServerInstaller({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minecraft Server Installer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(
        body: Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32), child: BasicConfigurationTab()),
      ),
    );
  }
}
