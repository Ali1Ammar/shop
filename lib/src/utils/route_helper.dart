import 'package:flutter/material.dart';

pushNewPage(BuildContext context, Widget newPage) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return newPage;
  }));
}
