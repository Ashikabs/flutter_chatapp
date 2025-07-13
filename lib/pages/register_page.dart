import 'package:flutter/material.dart';
import 'package:flutter_chatapp/services/auth/auth_service.dart';
import 'package:flutter_chatapp/components/my_button.dart';
import 'package:flutter_chatapp/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _confirmpasswordController = TextEditingController();
//tap to go to the registor page
  final void Function()? onTap;
   
 RegisterPage({super.key,
 required this.onTap});

 void register(BuildContext context) async {
  final auth = AuthService();

  // passwords match
  if (_passwordController.text == _confirmpasswordController.text) {
    try {
      // Wait for Firebase to finish signing up
      await auth.signUpWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Navigate to home page (or just pop to let StreamBuilder handle it)
      Navigator.pop(context); // or do nothing, StreamBuilder in auth_gate handles it

    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Registration failed"),
          content: Text(e.toString()),
        ),
      );
    }
  } else {
    // passwords do not match
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Passwords don't match!"),
      ),
    );
  }
}

 
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //logo
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
            ),

        const SizedBox(height: 50),

          //welcome back message
         Text("Lets create an account for you",
         style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
         ),
         ),

         const SizedBox(height: 25),
        
          // email textfield
        MyTextfield(
        controller: _emailController,
        hintText: "Email",
        obscureText: false,
        ),

        const SizedBox(height: 10),

        //password textfiled
         MyTextfield(
          controller: _passwordController,
          obscureText: true,
          hintText: "Password",
        ),

         const SizedBox(height: 10),

        //confirm password textfiled
         MyTextfield(
          controller: _confirmpasswordController,
          obscureText: true,
          hintText: "Confirm password",
        ),

         const SizedBox(height: 25),

          //login button
         MyButton(
          text:"Register",
          onTap:  () => register(context),
          ),
        
        const SizedBox(height: 25),
          //registor now 
        Text("Already have an account? ",
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text("Login now",
          style: TextStyle(
            fontWeight:FontWeight.bold,
          ),
          ),
        ),
        ],
        ),
      ),
    );
  }
}