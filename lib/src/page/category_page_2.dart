import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shop/src/model/category.dart';
import 'package:shop/src/page/product_page.dart';
import 'package:shop/src/utils/constant.dart';
import 'package:shop/src/utils/route_helper.dart';

class CategoryPage2 extends StatefulWidget {
  const CategoryPage2({super.key});

  @override
  State<CategoryPage2> createState() => _CategoryPage2State();
}

class _CategoryPage2State extends State<CategoryPage2> {
  late Future<List<Category>> asynData;
  @override
  void initState() {
    asynData = initCateogry();
    super.initState();
  }

  Future<List<Category>> initCateogry() async {
    var parse = Uri.https(baseUrl, "/api/v1/categories", {"limit": "3"});
    final res = await http.get(parse);
    final jsonMap = jsonDecode(res.body) as List;
    final categorys = jsonMap.map((e) => Category.fromJson(e)).toList();
    return categorys;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        initCateogry();
      }),
      appBar: AppBar(),
      body: FutureBuilder(
          future: asynData,
          builder: (context, snap) {
            if (snap.hasError) return Text(snap.error!.toString());
            if (snap.connectionState != ConnectionState.done)
              return const CircularProgressIndicator();
            return ListView(
              children: [
                for (final item in snap.data!)
                  ListTile(
                    onTap: () {
                      pushNewPage(
                          context,
                          ProductPage(
                            categoryId: item.id,
                          ));
                    },
                    title: Text(item.name),
                  )
              ],
            );
          }),
    );
  }
}
