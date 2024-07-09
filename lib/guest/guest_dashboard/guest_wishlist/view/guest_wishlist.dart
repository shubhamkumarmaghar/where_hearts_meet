import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/consts/images_const.dart';
import '../../../../utils/routes/routes_const.dart';

class GuestWishList extends StatefulWidget {
  final String title;
   GuestWishList({Key? key, required this.title}) : super(key: key);


  @override
  _GuestWishListState createState() => _GuestWishListState();
}

class _GuestWishListState extends State<GuestWishList>
    with TickerProviderStateMixin {

  bool _canShowButton = true;
  bool _canShowLine = false;
  bool _canShowCircle1 = false;
  bool _canShowCircle2 = false;
  bool _nextButton = true;
  bool _nextButton1 = false;
  bool _screenMaterial1 = true;
  bool _screenMaterial2 = true;
  bool _screenMaterial3 = true;
  bool _screenMaterial4 = true;
  bool _screenMaterial5 = true;
  bool _screenMaterial6 = true;
  bool _screenMaterial7 = true;
  bool _side1 = false;
  bool _side2 = false;
  bool _canShowText = false;

  double width = 135.0,
      height = 135.0;
  late Offset position1, position2, position3;

  late AnimationController controller;
  late Animation<double> animation;
  late AnimationController controller1;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();
    position1 = Offset(400, 55);
    position2 = Offset(150, 55);
    position3 = Offset(183, 240);
  }

  // @override
  // Widget build(BuildContext context) {
  //   SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
  //
  //
  //   // SystemChrome.setPreferredOrientations([
  //   //   DeviceOrientation.landscapeLeft,
  //   //   DeviceOrientation.landscapeRight,
  //   // ]);
  //
  //   return Scaffold(
  //     body: Stack(
  //       children: <Widget>[
  //         Container(
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: AssetImage("assets/squashcar.jpg"),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           top: 0,
  //           bottom: 0,
  //           left: 0,
  //           child: _side1? Transform.translate(
  //             child: Image.asset(
  //               'assets/curtain1.jpg',
  //               width: 391,
  //               height: double.infinity,
  //               fit: BoxFit.cover,
  //             ),
  //             offset: Offset(animation.value,0.0),
  //           ):SizedBox(),
  //
  //         ),
  //
  //         Positioned(
  //           top: 0,
  //           bottom: 0,
  //           right: 0,
  //           child: _side1? Transform.translate(
  //             child: Image.asset(
  //               'assets/curtain1.jpg',
  //               width: 391,
  //               height: double.infinity,
  //               fit: BoxFit.cover,
  //             ),
  //             offset: Offset(animation1.value,0.0),
  //           ):SizedBox(),
  //
  //         ),
  //         Positioned(
  //           top: 20,
  //           left: 250,
  //           child:_canShowText?Container(
  //               color: Colors.black54,
  //               height: 30.0,
  //               width: 300.0,
  //               child:Center(child: Text('   1/5 place line through centre of each wheel',style: TextStyle(color: Colors.amber),))
  //           ):SizedBox(),
  //         ),
  //         Positioned(
  //           top: 30,
  //           left: 13,
  //           child:_screenMaterial1? Container(
  //               color: Colors.black,
  //               child: Icon(Icons.volume_up)):SizedBox(),
  //         ),
  //         Positioned(
  //           bottom: 10,
  //           left: 13,
  //           child: _screenMaterial2? Container(
  //               color: Colors.black,
  //
  //               child: Icon(Icons.info_outline)):SizedBox(),
  //         ),
  //         Positioned(
  //           bottom: 10,
  //           left: 65,
  //           child:_screenMaterial3?  Image.asset(
  //             'assets/facebook.png',
  //             height: Theme.of(context).iconTheme.size,
  //             width: Theme.of(context).iconTheme.size,
  //           ):SizedBox(),
  //         ),
  //         // Positioned(
  //         //   bottom: 15,
  //         //   left: 120,
  //         //   child: _screenMaterial4?  Image.asset(
  //         //     'assets/twitter.png',
  //         //     height: Theme.of(context).iconTheme.size - 12,
  //         //     width: Theme.of(context).iconTheme.size,
  //         //   ):SizedBox(),
  //         // ),
  //         Positioned(
  //           top: 100,
  //           right: 41,
  //           child:_screenMaterial5?Container(
  //
  //             color: Colors.black,
  //             child: Icon(
  //               Icons.photo_camera,
  //             ),
  //           ):SizedBox(),
  //         ),
  //         Positioned(
  //           top: 145,
  //           right: 41,
  //           child:_screenMaterial6?Container(
  //             color: Colors.black,
  //             child: Icon(
  //               Icons.folder_open,
  //             ),
  //           ):SizedBox(),
  //         ),
  //         Positioned(
  //           top: 190,
  //           right: 41,
  //           child:_screenMaterial7?Container(
  //             color: Colors.black,
  //             child: Icon(
  //               Icons.cached,
  //               color: Colors.red,
  //             ),
  //           ):SizedBox(),
  //         ),
  //         Positioned(
  //           top: 235,
  //           right: 41,
  //           child:_nextButton?Container(
  //             color: Colors.black,
  //             child: IconButton(
  //               iconSize:33,
  //               icon: Icon(Icons.forward,
  //                 color: Colors.greenAccent,),
  //               onPressed: (){
  //                 setState(() {
  //                   _canShowLine=false;
  //                   _canShowText=false;
  //                   _canShowCircle1=!_canShowCircle1;
  //                   _canShowCircle2=!_canShowCircle2;
  //                   _nextButton1=!_nextButton1;
  //                   _nextButton=!_nextButton;
  //                 });
  //               },
  //             ),
  //           ):SizedBox(),
  //         ),
  //         Positioned(
  //           top: 245,
  //           right: 30,
  //           child:_nextButton1? IconButton(
  //             iconSize: 50,
  //             icon: Icon(Icons.forward,
  //               color: Colors.greenAccent,),
  //             onPressed: (){
  //               setState(() {
  //                 _nextButton1=_nextButton1;
  //                 _canShowCircle1=!_canShowCircle1;
  //                 _canShowCircle2=!_canShowCircle2;
  //                 _screenMaterial1=_screenMaterial1;
  //                 _screenMaterial2=_screenMaterial2;
  //                 _screenMaterial3=!_screenMaterial3;
  //                 _screenMaterial4=!_screenMaterial4;
  //                 _screenMaterial5=_screenMaterial5;
  //                 _screenMaterial6=_screenMaterial6;
  //                 _screenMaterial7=_screenMaterial7;
  //                 _side1=!_side1;
  //                 _side2=!_side2;
  //                 controller = new AnimationController(
  //                     duration: Duration(seconds: 3), vsync: this)..addListener(() =>
  //                     setState(() {}))..addStatusListener((status){
  //                   if(status==AnimationStatus.completed){controller.reverse();}
  //                 });
  //                 animation = Tween(begin: -400.0, end: 0.0).animate(controller);
  //                 controller.forward();
  //                 controller1 = new AnimationController(
  //                     duration: Duration(seconds: 3), vsync: this)..addListener(() =>
  //                     setState(() {}))..addStatusListener((status){
  //                   if(status==AnimationStatus.completed){controller1.reverse();}
  //                 });
  //                 animation1 = Tween(begin: 400.0, end: 0.0).animate(controller1);
  //                 controller1.forward();
  //               });
  //             },
  //           ):SizedBox(),
  //         ),
  //         Positioned(
  //           bottom: 20,
  //           right: 110,
  //           child:_canShowButton ?ClipOval(
  //             child: Container(
  //               color: Colors.black,
  //               height: 122.0,
  //               width: 122.0,
  //               child: Center(
  //                 child: ClipOval(
  //                   child: Container(
  //                     // #980F10
  //                     color: Color.fromRGBO(152, 15, 16, 1),
  //                     height: 78,
  //                     width: 78,
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         {
  //                           setState(() {
  //                             _canShowButton = !_canShowButton;
  //                             _canShowLine=true;
  //                             _canShowText=true;
  //                           });
  //
  //
  //                         }
  //
  //
  //
  //
  //                       },
  //                       child: Center(
  //                         child: Text(
  //                           "START",
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           )
  //               : SizedBox(),
  //         ),
  //         Positioned(
  //           left: position3.dx,
  //           top: position3.dy,
  //           child: _canShowLine ?GestureDetector(
  //               onPanUpdate: (details) {
  //                 setState(() {
  //                   position3 = Offset(position3.dx + details.delta.dx, position3.dy + details.delta.dy);
  //                 });
  //               },
  //               child:
  //               Container(
  //                 height:5.0,
  //                 width:400.0,
  //                 color:Colors.lightBlue,)
  //           ):SizedBox(),
  //
  //
  //         ),
  //         Positioned(
  //           left: position2.dx,
  //           top: position2.dy,
  //           child: _canShowCircle1?GestureDetector(
  //             onPanUpdate: (details) {
  //               setState(() {
  //                 position2 = Offset(position2.dx + details.delta.dx, position2.dy + details.delta.dy);
  //               });
  //             },
  //             child: Container(
  //               width: width,
  //               height: height,
  //               decoration: BoxDecoration(
  //                 color: Colors.blue.withOpacity(0.6),
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //           ):SizedBox(),
  //
  //
  //         ),
  //         Positioned(
  //           left: position1.dx,
  //           top: position1.dy,
  //           child: _canShowCircle2?GestureDetector(
  //             onPanUpdate: (details) {
  //               setState(() {
  //                 position1 = Offset(position1.dx + details.delta.dx, position1.dy + details.delta.dy);
  //               });
  //             },
  //             child: Container(
  //               width: width,
  //               height: height,
  //               decoration: BoxDecoration(
  //                 color: Colors.blue.withOpacity(0.6),
  //                 shape: BoxShape.circle,
  //               ),
  //             ),
  //           ):SizedBox(),
  //
  //
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

//}
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Birthday Post'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile section
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 20,
//                   backgroundImage: AssetImage(sun1)
//                   //NetworkImage(
//                     //  'https://via.placeholder.com/150'),
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   'sunandaaryan',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Spacer(),
//                 Icon(Icons.more_vert),
//               ],
//             ),
//             SizedBox(height: 10),
//             // Image section
//             Container(
//               height: 300,
//
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage(sun1),
//                   //NetworkImage('https://via.placeholder.com/300'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             // Action buttons
//             Row(
//               children: [
//                 Icon(Icons.favorite_border),
//                 SizedBox(width: 10),
//                 Icon(Icons.comment_outlined),
//                 SizedBox(width: 10),
//                 Icon(Icons.send),
//                 Spacer(),
//                 Icon(Icons.bookmark_border),
//               ],
//             ),
//             SizedBox(height: 10),
//             // Likes
//             Text(
//               'Liked by user1, user2 and 100 others',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5),
//             // Caption
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: 'username ',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                   TextSpan(
//                     text: 'This is the caption of the post.',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 5),
//             // Comments
//             Text(
//               'View all 20 comments',
//               style: TextStyle(color: Colors.grey),
//             ),
//             SizedBox(height: 5),
//             Text(
//               '1 hour ago',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// twitter
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Twitter Post'),
//         centerTitle: true,
//       ),
//       body:
//       Container(
//         width: Get.width*0.8,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               // Profile section
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: NetworkImage('https://via.placeholder.com/150'),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               'username',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               '@handle · 1h',
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                             Spacer(),
//                             Icon(Icons.more_vert),
//                           ],
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           'This is the content of the tweet. It can be multiple lines long and contain various types of content.',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               // Action buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Icon(Icons.chat_bubble_outline),
//                   Icon(Icons.repeat),
//                   Icon(Icons.favorite_border),
//                   Icon(Icons.share),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//}

// thread
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: GestureDetector(
            onTap: (){

            },
              child: Icon(Icons.arrow_back)),
          onPressed: () {
            // Action for back button
          },
        ),
        title: GestureDetector(onTap: (){
          GetStorage().erase();
          Get.offAllNamed(RoutesConst.dashboardScreen);
        },child: Text('New Thread')),
        actions: [
          TextButton(
            onPressed: () {
              // Action for Post button
            },
            child: Text(
              'Post',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://your-profile-picture-url.com'),
                  radius: 24,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'What’s happening?',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: SvgPicture.asset('assets/icons/image.svg'),
                  onPressed: () {
                    // Action for adding an image
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/video.svg'),
                  onPressed: () {
                    // Action for adding a video
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/icons/location.svg'),
                  onPressed: () {
                    // Action for adding location
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}