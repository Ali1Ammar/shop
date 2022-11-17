import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/src/model/product.dart';

class SingleProductPage extends StatelessWidget {
  final Product product;
  const SingleProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final img in product.images)
                  Image.network(
                    img,
                    height: 100,
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              product.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "⚪${product.category.name}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  "${product.price}\$",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text("Color "),
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(360)),
              ),
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(360)),
              ),
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(360)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
