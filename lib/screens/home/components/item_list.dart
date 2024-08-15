import 'package:flutter/material.dart';
import 'package:walmart/models/Product.dart';
import 'package:walmart/screens/details/details_screen.dart';
import 'package:walmart/screens/search/components/item_card.dart';

class CategoryItemList extends StatelessWidget {
  final String categoryName;
  final List<Product> items;

  CategoryItemList({required this.categoryName, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            categoryName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          color: Colors.white,
          height: 210,
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(
                  product: products[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: products[index],
                      ),
                    ),
                  ),
                );
            }, separatorBuilder: (context,index) => SizedBox(width: 12,),
          ),
        ),
      ],
    );
  }
}

