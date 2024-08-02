import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:where_hearts_meet/utils/consts/images_const.dart';

class GetPersonalWishScreen extends StatefulWidget {
  const GetPersonalWishScreen({super.key});

  @override
  State<GetPersonalWishScreen> createState() => _GetPersonalWishScreenState();
}

class _GetPersonalWishScreenState extends State<GetPersonalWishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(image:DecorationImage(image: AssetImage(su1))),
      ),
    );
  }
}
