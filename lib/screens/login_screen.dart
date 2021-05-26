import 'package:demo/screens/profile_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

bool profile_filled = false;
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String number;
  final googleSignIn = GoogleSignIn();
  final phonecontroller = TextEditingController();
  final codecontroller = TextEditingController(); 
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    profile_filled = false;
    _auth.verifyPhoneNumber(
      phoneNumber: phone, 
      timeout: Duration(seconds:60 ),
      verificationCompleted: (AuthCredential credential) async{
        Navigator.of(context).pop();
      UserCredential result = await _auth.signInWithCredential(credential);
      
      User user = result.user;

      if(user!=null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage(user:user)));
      }
      }, 
      verificationFailed: (FirebaseAuthException exception){
        print(exception);
      }, 
      codeSent: (String verificationId, [int forceResendingToken]){
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context){
            return AlertDialog(backgroundColor: Colors.grey.shade800,title:Text("Enter the OTP",style: TextStyle(fontFamily: 'Merienda'),),
            content:SingleChildScrollView(
              child: Column(children: [
                TextField(
                  style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                  controller: codecontroller,
                  decoration: InputDecoration(
                    hintText: "6-digit OTP",
                    hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.white),
                    prefixIcon: Icon(Icons.code,color: Colors.black)
                  )
                  ),

                RaisedButton(
                  color: Color(0xFFE64141),
                  onPressed: ()async{
                    final code = codecontroller.text.trim();
                    AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId,smsCode: code);
                    UserCredential result = await _auth.signInWithCredential(credential);
                    User user = result.user;
                    if(user!=null)
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage(user:user)));
                    }
                    else{
                      print("Error");
                    }
                  },
                  child: Text("Confirm",style: TextStyle(fontFamily:'Merienda',color: Colors.white),),),

                ],),
              ));
            });
      }, 
      codeAutoRetrievalTimeout: (String verificationId){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Center(child:Text("DEMO APP",style: TextStyle(fontFamily: 'Merienda'),),),
        backgroundColor: Colors.grey.shade800,),
        body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin:Alignment.bottomLeft,
                end:Alignment.topRight,
                stops: [0.55,0.5],
                colors: [Colors.grey.shade800,Color(0xFFE64141)]
               )
            ),
            child: Column(
              children: [

                Container(height:140),

                Container(
                  margin: EdgeInsets.only(bottom:20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(10),
                  child: SignInButton(
                  Buttons.Google,
                  padding: EdgeInsets.all(20),
                  text: "SIGN IN WITH GOOGLE",
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  onPressed:()async{
                    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

                    if(googleSignInAccount != null )
                    {
                      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

                      GoogleAuthCredential credential = GoogleAuthProvider.credential(
                      accessToken: googleSignInAuthentication.accessToken,
                      idToken: googleSignInAuthentication.idToken,
                    );
                    UserCredential result = await _auth.signInWithCredential(credential);
                    User user = result.user;
                          if(user!=null)
                          {
                            print(user.uid);
                            profile_filled = false;
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage(user:user)));
                          }
                          else{
                            print("Error");
                          }
                  }},
                  ),
                ), 
                Container(height:40,child: Text("OR",style:TextStyle(fontFamily: 'Merienda',fontSize: 30,fontWeight: FontWeight.w900)),),
                Container(
                  margin: EdgeInsets.only(top:20),
                      width:300,
                      // color: Colors.grey.shade900,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        border: Border.all(color: Colors.grey.shade800),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextField(
                        controller: phonecontroller,
                        style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                        decoration: InputDecoration(
                        hintText: "+91----------",
                        labelText: "Phone",
                        hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.white),
                        labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.white),
                        prefixIcon: Icon(Icons.call,color:Color(0xFFE64141))
                      ),
                      )
                      ),

                Container(height:30),

                RaisedButton(
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Color(0xFFE64141),
                  padding: EdgeInsets.only(top:10,bottom: 10,left:50,right:50),
                  onPressed: (){
                    final phone = phonecontroller.text.trim();
                    loginUser(phone, context);
                  },
                  child: Text("LOGIN",style: TextStyle(color: Colors.white,fontFamily:'Merienda', fontSize: 20),),),
              ],
            ),
          ),
        ),);
  }

 
}