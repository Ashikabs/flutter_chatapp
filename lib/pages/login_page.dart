// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/services/auth/auth_service.dart';
import 'package:flutter_chatapp/components/my_button.dart';
import 'package:flutter_chatapp/components/my_textfield.dart';

class LoginPage extends StatelessWidget {

  //email and pw controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  //tap to go to the registor page
  final void Function()? onTap;

   LoginPage({
    super.key,
    required this.onTap
   });

   void login(BuildContext context) async{
  // auth service
  final authservice = AuthService();

  //try login
  try{
    await authservice.signInWithEmailPassword(_emailController.text,_passwordController.text,);
  }
  //catch any errors
  catch(e){
   showDialog(context: context, builder: (context) => AlertDialog(
   title:Text(e.toString()),
   ));
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

        SizedBox(height: 50),

          //welcome back message
         Text("Welcome back,you've been missed!",
         style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
         ),
         ),

         SizedBox(height: 25),
        
          // email textfield
        MyTextfield(
        controller: _emailController,
        hintText: "Email",
        obscureText: false,
        ),

        SizedBox(height: 10),

        //password textfiled
         MyTextfield(
          controller: _passwordController,
          obscureText: true,
          hintText: "Password",
        ),

         SizedBox(height: 25),

          //login button
         MyButton(
          text:"Login",
          onTap: () => login(context),
          ),
        
        SizedBox(height: 25),
          //registor now 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Not a memeber? ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
         
        GestureDetector(
          onTap: onTap,
          child: Text("Register now",
          style: TextStyle(
            fontWeight:FontWeight.bold,
          ),
          ),
        ),
        ],
        )
       
        ],
        ),
      ),
    );
  
  }
}