import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:where_hearts_meet/utils/consts/color_const.dart';

class AnimatedHearts extends StatefulWidget {
  final Offset beginOffset;
  final Offset endOffset;
  const AnimatedHearts({Key? key,required this.beginOffset,required this.endOffset}) : super(key: key);

  @override
  State<AnimatedHearts> createState() => _AnimatedHeartsState();
}

class _AnimatedHeartsState extends State<AnimatedHearts> with TickerProviderStateMixin{
  final _mainHeight = Get.height;
  //final _mainWidth = Get.width;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      )..forward();
      _animation = Tween<Offset>(
        begin: widget.beginOffset,
        end: widget.endOffset
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCubic,
      ));
      _controller.repeat(reverse: true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      transformHitTests: true,
      textDirection: TextDirection.ltr,
      child: Icon(Icons.heart_broken,color: redColor,size: _mainHeight*0.15,),
    );
  }
}
