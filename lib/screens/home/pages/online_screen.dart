import 'package:flutter/material.dart';
import 'package:walmart/models/Product.dart';
import 'package:walmart/screens/home/components/categories_row.dart';
import 'package:walmart/screens/home/components/item_list.dart';

class OnlineScreen extends StatefulWidget {
  const OnlineScreen({super.key});

  @override
  State<OnlineScreen> createState() => _OnlineScreenState();
}

class _OnlineScreenState extends State<OnlineScreen> {
  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(content: Text("!Yay Profile"));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40, left: 12, right: 12),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          height: kTextTabBarHeight,
                          child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Search something here...."),
                              textCapitalization: TextCapitalization.sentences,
                              cursorColor: Colors.grey)),
                      InkWell(
                        onTap: () => {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar)
                        },
                        child: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                CategoryRow(),
                CategoryItemList(
                  categoryName: "Furniture",
                  items: products,
                ),
                CategoryItemList(
                  categoryName: "Clothes",
                  items: products,
                ),
                CategoryItemList(
                  categoryName: "Sports",
                  items: products,
                ),
              ],),)
        ],
      ),
    );
  }
}
