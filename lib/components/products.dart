import 'package:ecommerce/pages/products_Details.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Red Dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 100,
      "price": 50,
    },
    {
      "name": "Black Dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": 100,
      "price": 50,
    },
    {
      "name": "Pink Shoes",
      "picture": "images/products/hills1.jpeg",
      "old_price": 100,
      "price": 50,
    },
    {
      "name": "Red Shoes",
      "picture": "images/products/hills2.jpeg",
      "old_price": 80,
      "price": 60,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Single_product(
            product_name: product_list[index]['name'],
            product_pic: product_list[index]['picture'],
            product_old_price: product_list[index]['old_price'],
            product_new_price: product_list[index]["price"],
          );
        });
  }
}

class Single_product extends StatelessWidget {
  final product_name;
  final product_pic;
  final product_old_price;
  final product_new_price;

  Single_product({
    this.product_name,
    this.product_pic,
    this.product_old_price,
    this.product_new_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: product_name,
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                    product_detail_name: product_name,
                    product_detail_pic: product_pic,
                    product_detail_old_price: product_old_price,
                    product_detail_new_price: product_new_price,
                  ))),
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      product_name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text(
                      "\$$product_new_price",
                      style: TextStyle(color: Colors.red),
                    ),
                    subtitle: Text(
                      "\$$product_old_price",
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ),
                child: Image.asset(product_pic, fit: BoxFit.cover),
              ),
            ),
          )),
    );
  }
}
