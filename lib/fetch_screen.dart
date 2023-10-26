import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitledsaggo123/main.dart';
import 'package:untitledsaggo123/update_screen.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
       children: [
         StreamBuilder(
              stream: FirebaseFirestore.instance.collection("userData").snapshots(),
              builder: (BuildContext context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasData) {
                  var dataLength = snapshot.data!.docs.length;
                  return ListView.builder(
                    itemCount: dataLength,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {

                      String uName = snapshot.data!.docs[index]["User_Name"];
                      String uEmail = snapshot.data!.docs[index]["User_Email"];
                      String uPassword = snapshot.data!.docs[index]["User_Password"];
                      String uID = snapshot.data!.docs[index]["User_ID"];

                        return Container(
                          width: double.infinity,
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: GestureDetector(
                            onDoubleTap: ()async{
                              await FirebaseFirestore.instance.collection("userData").doc(uID).delete();
                            },
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(userID: uID, userName: uName, userEmail: uEmail, userPassword: uPassword),));
                            },
                            child: Container(
                                margin: EdgeInsets.only(left: 14,top: 14),
                                child: Text(uName)),
                          ),
                        );
                      },);
                } if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                }
                return Container();
              }),

         ElevatedButton(onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationForm(),));

         }, child: Text("Add Data"))
       ],
     ),
    );
  }
}
