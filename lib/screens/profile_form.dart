import 'package:demo/screens/profile_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FormPage extends StatefulWidget {
  User user;
  FormPage({this.user});
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String email,name,phone,city,state,country,pincode;
  CollectionReference user_collection = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Center(child:Text("DEMO APP",style: TextStyle(fontFamily: 'Merienda'),),),
        backgroundColor: Colors.grey.shade800,
        automaticallyImplyLeading: false,),
        
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFE64141),
          child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 13,),

                        Container(
                          width:300,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            autofocus: false,
                          style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                          decoration: InputDecoration(
                            hintText: "eg. Alice",
                            labelText: "Name",
                            hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200,fontSize: 15),
                            labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200),
                            prefixIcon: Icon(Icons.person,color: Color(0xFFE64141))
                          ),
                          onChanged: (input){
                            name = input;
                          }
                          ,),),

                          Container(height: 10,),
                          // Container(height: 5,),
                          Container(
                          width:300,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                          style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                          decoration: InputDecoration(
                            hintText: "eg. example@gmail.com",
                            labelText: "Email",
                            hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200,fontSize: 15),
                            labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200),
                            prefixIcon: Icon(Icons.email,color: Color(0xFFE64141))
                          ),
                          onChanged: (input){
                            email = input;
                          }
                          ,),),

                          Container(height: 10,),

                          Container(
                          width:300,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                          style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                          decoration: InputDecoration(
                            hintText: "eg. +91----------",
                            labelText: "PhoneNumber",
                            hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200,fontSize: 15),
                            labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200),
                            prefixIcon: Icon(Icons.phone,color: Color(0xFFE64141))
                          ),
                          onChanged: (input){
                            phone = input;
                          }
                          ,),),

                          Container(height: 10,),

                          Container(
                          width:300,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                          style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                          decoration: InputDecoration(
                            hintText: "eg. Indore",
                            labelText: "City",
                            hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200,fontSize: 15),
                            labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200),
                            prefixIcon: Icon(Icons.location_city,color: Color(0xFFE64141))
                          ),
                          onChanged: (input){
                            city = input;
                          }
                          ,),),

                          Container(height: 10,),

                          Container(
                          width:300,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
                          style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                          decoration: InputDecoration(
                            hintText: "eg. Madhya Pradesh",
                            labelText: "State",
                            hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200,fontSize: 15),
                            labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200),
                            prefixIcon: Icon(Icons.map,color: Color(0xFFE64141))
                          ),
                          onChanged: (input){
                            state = input;
                          }
                          ,),),

                          Container(height: 10,),

                          Container(
                          width:300,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                          style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                          decoration: InputDecoration(
                            hintText: "eg. India",
                            labelText: "Country",
                            hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200,fontSize: 15),
                            labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200),
                            prefixIcon: Icon(Icons.place,color: Color(0xFFE64141))
                          ),
                          onChanged: (input){
                            country = input;
                          }
                          ,),),

                          Container(height: 10,),

                          Container(
                          width:300,
                          decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          border: Border.all(color: Colors.grey.shade800),
                          borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                          style: TextStyle(color: Colors.grey.shade200, fontFamily: 'Merienda'),
                          decoration: InputDecoration(
                            hintText: "eg. 413142",
                            labelText: "Pincode",
                            hintStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200,fontSize: 15),
                            labelStyle: TextStyle(fontFamily:'Merienda',color: Colors.grey.shade200),
                            prefixIcon: Icon(Icons.pin_drop,color: Color(0xFFE64141))
                          ),
                          onChanged: (input){
                            pincode = input;
                          }
                          ,),),

                          Container(height: 20,),

                          RaisedButton(
                            color: Colors.grey.shade800,
                            onPressed: (){
                              print(widget.user.uid.toString());
                              user_collection.doc(widget.user.uid.toString()).collection('Personal').add({
                                'name':name,
                                'email':email,
                                'phone':phone,
                                'city':city,
                                'state':state,
                                'country':country,
                                'pincode':pincode
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Display(uid:widget.user.uid.toString())));
                            },
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.only(top:10,bottom: 10,left:50,right:50),
                            child: Text("SUBMIT",style: TextStyle(color: Colors.white,fontFamily:'Merienda', fontSize: 20)),),
                      ]),
          ),
        ),);
  }
}