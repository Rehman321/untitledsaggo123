import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitledsaggo123/fetch_screen.dart';
import 'package:untitledsaggo123/firebase_options.dart';
import 'package:uuid/uuid.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FetchScreen(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  void addUser()async{

    String uID = Uuid().v1();

    Map<String, dynamic> userreg = {
      "User_ID": uID,
      "User_Name": _usernameController.text.toString(),
      "User_Email": _emailController.text.toString(),
      "User_Password": _passwordController.text.toString()
    };

    // Default firebase
    // await FirebaseFirestore.instance.collection("userData").add(userreg);

    // with Custom Firebase ID
    await FirebaseFirestore.instance.collection("userData").doc(uID).set(userreg);
    Navigator.pop(context);
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
              onPressed:(){
                addUser();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
