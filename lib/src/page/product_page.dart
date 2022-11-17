import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shop/src/model/product.dart';
import 'package:shop/src/page/single_product_page.dart';
import 'package:shop/src/utils/constant.dart';
import 'package:shop/src/utils/route_helper.dart';

class ProductPage extends StatefulWidget {
  final int categoryId;
  const ProductPage({super.key, required this.categoryId});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> asynData;
  @override
  initState() {
    widget.categoryId;
    asynData = initProduct();
    super.initState();
  }

  Future<List<Product>> initProduct() async {
    var parse =
        Uri.https(baseUrl, "/api/v1/categories/${widget.categoryId}/products");
    final res = await http.get(parse);
    final jsonMap = jsonDecode(res.body) as List;
    final data = jsonMap.map((e) => Product.fromJson(e)).toList();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: asynData,
          builder: (context, snap) {
            if (snap.hasError) return Text(snap.error!.toString());
            if (snap.connectionState != ConnectionState.done)
              return CircularProgressIndicator();
            return ListView(
              children: [
                for (final item in snap.data!)
                  ListTile(
                    onTap: () {
                      pushNewPage(
                          context,
                          SingleProductPage(
                            product: item,
                          ));
                    },
                    title: Text(item.title),
                    subtitle: Text(item.category.name),
                  )
              ],
            );
          }),
    );
  }
}
