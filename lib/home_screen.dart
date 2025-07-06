import 'package:flutter/material.dart';
import 'package:know_match/game_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title:const Text("Know & Match"),//centerTitle:true ,
      //backgroundColor: Color(0xFF009688),),
      body:GestureDetector(
        onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: 
        (context)=>const GameScreen()));
        },
        child:Image.asset("assets/logo.jpg",fit: BoxFit.cover,width: double.infinity,height: double.infinity,), 
        
      )
     
    );
  }
}
