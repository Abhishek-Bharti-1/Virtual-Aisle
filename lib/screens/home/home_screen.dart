import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:walmart/screens/home/pages/online_screen.dart';
import 'package:walmart/screens/home/pages/visit_store_screen.dart';

import '../onboarding/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin  {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(content: Text("!Yay Profile"));
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Container(
          margin: EdgeInsets.only(left: 0, right: 8),
          width: 36,
          height: 36,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(250) , border: Border.all(color: Colors.amber,width: 2)),
          child: InkWell(
            onTap: () => {
               ScaffoldMessenger.of(context).showSnackBar(snackBar)
            },
            child: Icon(Icons.person,size: 30,))),
            Text("Welcome Abhishek !",style: TextStyle(color: Colors.white),),
            SizedBox(width: 60),
            IconButton(
              icon: Icon(Icons.logout, size: 20),
              onPressed: () async {
                // Sign out from Firebase
                await FirebaseAuth.instance.signOut();

                // Navigate to the login screen or another screen after logout
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 0),
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.blue,
            //child: Text("Abhi"),
            child: Column(
              children: [
                Container(
                  
                  decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 2),borderRadius: BorderRadius.circular(14),color: Colors.grey[200]),
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'Shop Online'),
                      Tab(text: 'Visit a Store'),
                    ],
                    indicator: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                       // Color when selected
                    ),
                    unselectedLabelColor: Colors.black, // Color of unselected labels
                    labelColor: Colors.white, // Color of selected label text
                    labelPadding: EdgeInsets.symmetric(horizontal: 4),
                    indicatorPadding: EdgeInsets.zero,
                    isScrollable: false,
                    indicatorWeight: 0,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
               ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(), // Disable swipe
        children: [
          OnlineScreen(),
          VisitStoreScreen(),
        ],
      ),
    );
  }
}

// Container(
                
//                 margin: EdgeInsets.only(top: 12),
//                 padding: EdgeInsets.all(12),
//                 width: MediaQuery.of(context).size.width-20,
//                 decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2),borderRadius: BorderRadius.circular(14)),
//                 child: Row(
//                   children: [
//                     SizedBox(width: MediaQuery.of(context).size.width - 100,
//                       height: kTextTabBarHeight,
//                       child: TextField(textCapitalization:  TextCapitalization.sentences,cursorColor: Colors.white,)),
//                     InkWell(
//                       onTap: () => {
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar)
//                       },
//                       child:Icon(Icons.search),),
//                   ],
//                 ),)