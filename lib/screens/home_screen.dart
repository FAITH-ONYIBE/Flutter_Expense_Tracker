import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        // title: Text("Welcome, ${widget.user['username']}"),
      ),
      floatingActionButton: Container(
       decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
           colors: [
              Color(0xFF00B2E7),
              Color(0xFFE064F7),
              Color(0xFFFF8D6C),
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
        
        )
       ),
       child: FloatingActionButton(
        onPressed: () {
          
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: CircleBorder(),
        child: Icon(Icons.add,
        color: Colors.white,),
       ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), 
        color: Colors.grey[200],
        notchMargin: 6,
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            IconButton(onPressed: () {}, icon: Icon(Icons.analytics, ),),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings, ))
          ],
        ),
      ),
    );
    
    
  }
}
