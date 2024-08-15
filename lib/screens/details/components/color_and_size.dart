import 'package:flutter/material.dart';
import 'package:walmart/models/Product.dart';
import 'package:walmart/screens/details/helloworld.dart';

import '../../../constants.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context) {
    var snackBar = SnackBar(content: Text("!Yay"));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text("Color"),
              Row(
                children: <Widget>[
                  ColorDot(
                    color: Color(0xFF356C95),
                    isSelected: true,
                  ),
                  ColorDot(
                    color: Color(0xFFF8C078),
                    isSelected: true,
                  ),
                  ColorDot(color: Color(0xFFA29B9B), isSelected: false),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: kTextColor),
              children: [
                TextSpan(text: "Size\n"),
                TextSpan(
                  text: "${product.size} cm",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      Expanded(
         child: InkWell(
          onTap: () => {
            //  ScaffoldMessenger.of(context).showSnackBar(snackBar)
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HelloWorld()))
          },
           child: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(border: Border.all(width: 1, color: product.color), borderRadius: BorderRadius.circular(8),),
             child: const Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Text("AR Try On"),
                 Icon(Icons.phone_iphone, color: Colors.grey,)
               ],
             ),
           ),
         ),
       ),
       
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({super.key, required this.color, required this.isSelected});

  final Color color;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: kDefaultPaddin / 4,
        right: kDefaultPaddin / 2,
      ),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
