import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 217, 179),
     appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body:Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(13),
        ),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dark mode
           const Text("Dark Mode"),

            //switch toggle
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
              onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false)
              .toggleTheme(),
              ),
          ],
        )
      )
    );
  }
}