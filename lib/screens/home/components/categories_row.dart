import 'package:flutter/material.dart';
import 'package:walmart/screens/search/search_screen.dart';

class CategoryRow extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Food', imageUrl: 'assets/images/bag_1.png'),
    Category(name: 'Sports', imageUrl: 'assets/images/bag_2.png'),
    Category(name: 'Clothes', imageUrl: 'assets/images/bag_3.png'),
    Category(name: 'Furniture', imageUrl: 'assets/images/bag_4.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categories
                .map((category) => CategoryItem(category: category))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SearchScreen()),
)
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(category.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            category.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}
