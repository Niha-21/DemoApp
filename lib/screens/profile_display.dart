import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Display extends StatefulWidget {
  final String uid;
  Display({this.uid});
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  CollectionReference cr = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  
  Future<bool> signOut()async{
  User user = _auth.currentUser;
  if(user.providerData[1].providerId == "google.com")
  {
    await googleSignIn.disconnect();
  }  
  await _auth.signOut();
  return Future.value(true);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Row(
          children: [
            SizedBox(width: 120,),
            Text("DEMO APP",style: TextStyle(fontFamily: 'Merienda')),
            SizedBox(width: 80,),
            IconButton(icon: Icon(Icons.arrow_drop_down_circle, color: Color(0xFFE64141),size: 35,), 
            onPressed:()=>signOut().whenComplete(() => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => Login()),(Route <dynamic> route)=>false)))
          ],
        ),
        backgroundColor: Colors.grey.shade800,
        automaticallyImplyLeading: false,),
        body: Container(
                    height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:Alignment.bottomLeft,
                end:Alignment.topRight,
                stops: [0.55,0.5],
                colors: [Colors.grey.shade800,Color(0xFFE64141)]
               )
            ),
            child: 
              Column(
                children: [
                  Expanded(
                      child: StreamBuilder(
                      stream: cr.doc(widget.uid).collection('Personal').snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.data == null) return CircularProgressIndicator();
                        return ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context,index){
                            DocumentSnapshot ds = snapshot.data.docs[index];
                              return 
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top:80),
                                      width:300,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade900,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Center(child: Text(ds['name']+"'s PROFILE",style: TextStyle(fontFamily: 'Merienda',color: Colors.white,fontSize: 25),))),

                                      Container(height: 70,),

                                      Container(
                                      margin: EdgeInsets.all(20),
                                      width:300,
                                      height: 400,
                                      decoration: BoxDecoration(
                                        color: Colors.black38,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Container(height:10),
                                          Text("CONTACT DETAILS:",style: TextStyle(fontFamily: 'Merienda',color: Colors.white,fontSize: 15)),
                                          Container(height:10),
                                          Text("Phone: "+ds['phone'],style: TextStyle(fontFamily: 'Merienda',color: Colors.white,fontSize: 20)),
                                          Container(height:10),
                                          Text("Email: "+ds['email'],style: TextStyle(fontFamily: 'Merienda',color: Colors.white,fontSize: 20)),
                                          Container(height:40),
                                          Text("WORK LOCATION:",style: TextStyle(fontFamily: 'Merienda',color: Colors.white,fontSize: 15)),
                                          Container(height:10),
                                          Text(ds['city']+" - "+ds['pincode'],style: TextStyle(fontFamily: 'Merienda',color: Colors.white,fontSize: 20)),
                                          Container(height:10),
                                          Text(ds['state']+", "+ds['country'],style: TextStyle(fontFamily: 'Merienda',color: Colors.white,fontSize: 20)),
                                        ],
                                      ),),
                                  ],
                                );
                          },
                        );
                      }),
                    ),
                ],
              ),
              
              
            ));
  }
}
