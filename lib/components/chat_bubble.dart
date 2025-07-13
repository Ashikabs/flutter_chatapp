import 'package:flutter/material.dart';
import 'package:flutter_chatapp/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
      super.key,
      required this.message,
      required this.isCurrentUser,
      });

  @override
  Widget build(BuildContext context) {

    //lightmode vs dark mode for correct bubble colors
    bool isDarkMode = Provider.of<ThemeProvider>(context , listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser 
        ? (isDarkMode ? const Color.fromARGB(255, 194, 29, 84) : const Color.fromARGB(255, 12, 56, 93))
        : (isDarkMode ? const Color.fromARGB(255, 88, 43, 58) : const Color.fromARGB(255, 159, 191, 217)),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
           ? Colors.white 
           :(isDarkMode ? Colors.white : Colors.black)
           ),
        ),
    );
  }
}