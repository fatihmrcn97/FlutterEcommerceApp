import 'package:ecommerce/pages/cart.dart';
import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  @override
  Widget build(BuildContext context) {
    var Products_on_the_Cart = [
      {
        "name": "Blazer",
        "picture": "images/products/blazer1.jpeg",
        "price": 85,
        "Size": "M",
        "Color": "Red",
        "Quantity": 1,
      },
      {
        "name": "Red Dress",
        "picture": "images/products/dress1.jpeg",
        "price": 50,
        "Size": "M",
        "Color": "Red",
        "Quantity": 1,
      },
      {
        "name": "Black Dress",
        "picture": "images/products/dress2.jpeg",
        "price": 50,
        "Size": "M",
        "Color": "Red",
        "Quantity": 1,
      },
      {
        "name": "Hills",
        "picture": "images/products/hills1.jpeg",
        "price": 50,
        "Size": "M",
        "Color": "Red",
        "Quantity": 1,
      }
    ];

    return new ListView.builder(
      itemCount: Products_on_the_Cart.length,
      itemBuilder: (context, index) {
        return Single_cart_product(
          product_name: Products_on_the_Cart[index]["name"],
          product_color: Products_on_the_Cart[index]["Color"],
          product_new_price: Products_on_the_Cart[index]["price"],
          product_pic: Products_on_the_Cart[index]["picture"],
          product_quantity: Products_on_the_Cart[index]["Quantity"],
          product_size: Products_on_the_Cart[index]["Size"],
        );
      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final product_name;
  final product_pic;
  final product_size;
  final product_color;
  final product_quantity;
  final product_new_price;

  Single_cart_product({
    this.product_name,
    this.product_pic,
    this.product_color,
    this.product_size,
    this.product_quantity,
    this.product_new_price,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: new Image.asset(
          product_pic,
          width: 50,
          height: 50,
        ),
        title: Text(product_name),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: new TextStyle(
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: "Size : "),
                        new TextSpan(
                            text: product_size,
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: new TextStyle(
                        color: Colors.grey,
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: "Color : "),
                        new TextSpan(
                            text: product_color,
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 5, 0, 5),
              child: new Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  "\$${product_new_price}",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        trailing:
        FittedBox(
          fit: BoxFit.fill,
          child:
          Column(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_drop_up,color: Colors.red),iconSize: 48, onPressed: () {}),
              Text('$product_quantity',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              IconButton(icon: Icon(Icons.arrow_drop_down,color: Colors.red,),iconSize: 48, onPressed: () {}),

            ],
          ),
        ),
      ),
    );
    
  }
}
