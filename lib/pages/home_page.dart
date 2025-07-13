
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/components/my_drawer.dart';
import 'package:flutter_chatapp/components/user_title.dart';
import 'package:flutter_chatapp/pages/chat_page.dart';
import 'package:flutter_chatapp/services/auth/auth_service.dart';
import 'package:flutter_chatapp/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
    HomePage({super.key});

  //chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout(){
  //get auth service
  final auth = AuthService();
  auth.signOut();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 217, 179),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body:_buildUserList(),
    );
  }

  //build a list of users except for the current logged in user
  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
       builder: (context,snapshot) {
        //error

        if( snapshot.hasError){
          return const Text("Error");
        }

        //loading
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");
        }

        //return list view
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
        );
       },
       );
  }

  //build individual list title for user
  Widget _buildUserListItem(
    Map<String,dynamic> userData, BuildContext context){
      //display all user except current user
     if (userData["email"] != _authService.getCurrentUser()!.email) {
     return UserTitle(
      text: userData["email"],
      onTap: () {
        //tapped on a user -> go to chat page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData["email"],
              receiverID: userData["uid"],
              
            ),
            ),
            );
      },
     );
     } else{
        return Container();
     }
  }
}
