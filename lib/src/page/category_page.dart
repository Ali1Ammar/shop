import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:shop/src/model/category.dart';
import 'package:shop/src/utils/constant.dart';
import 'package:shop/src/utils/token.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = true;

  List<Category> datas = [];
  @override
  void initState() {
    initCateogry();
    super.initState();
  }

  initCateogry() async {
    setState(() {
      isLoading = true;
    });
    var parse = Uri.https(baseUrl, "/api/v1/categories", {"limit": "3"});
    final res =
        await http.get(parse, headers: {"Authorization": "Bearer $token"});
    final jsonMap = jsonDecode(res.body) as List;
    final categorys = jsonMap.map((e) => Category.fromJson(e)).toList();
    setState(() {
      datas = categorys;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        initCateogry();
      }),
      appBar: AppBar(),
      body: isLoading
          ? CircularProgressIndicator()
          : ListView(
              children: [for (final item in datas) Text(item.name)],
            ),
    );
  }
}
