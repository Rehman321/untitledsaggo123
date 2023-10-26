import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {

  String userID;
  String userName;
  String userEmail;
  String userPassword;


  UpdateScreen({required this.userID, required this.userName, required this.userEmail, required this.userPassword});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void updateUser()async{
    await FirebaseFirestore.instance.collection("userData").doc(widget.userID).update({
      "User_ID": widget.userID,
      "User_Name": _usernameController.text.toString(),
      "User_Email": _emailController.text.toString(),
      "User_Password": _passwordController.text.toString()
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState

    _usernameController.text = widget.userName;
    _emailController.text = widget.userEmail;
    _passwordController.text = widget.userPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Registration Form'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: (){
              updateUser();
            },
            child: Text('Update'),
          ),
        ],
      ),
    ),
    );
  }
}
