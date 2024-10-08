// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:where_hearts_meet/utils/consts/color_const.dart';
// import 'package:where_hearts_meet/utils/consts/images_const.dart';
//
// const itemSize = 150.0;
//
// class ShrinkTopListPage extends StatefulWidget {
//   @override
//   _ShrinkTopListPageState createState() => _ShrinkTopListPageState();
// }
//
// class _ShrinkTopListPageState extends State<ShrinkTopListPage> {
//   final scrollController = ScrollController();
//
//   void onListen() {
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     characters.addAll(List.from(characters));
//     scrollController.addListener(onListen);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     scrollController.removeListener(onListen);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Padding(
//         padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
//         child: CustomScrollView(
//           shrinkWrap: true,
//           controller: scrollController,
//           slivers: <Widget>[
//             // SliverToBoxAdapter(
//             //   child: Placeholder(
//             //     fallbackHeight: 100.0,
//             //   ),
//             // ),
//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               title: Text(
//                 'My Characters',
//                 style: TextStyle(color: Colors.black),
//               ),
//               pinned: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//             ),
//             SliverToBoxAdapter(
//               child: const SizedBox(
//                 height: 50,
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                     (context, index) {
//                   final heightFactor = 0.6;
//                   final character = characters[index];
//                   final itemPositionOffset = index * itemSize * heightFactor;
//                   final difference =
//                       scrollController.offset - itemPositionOffset;
//                   final percent =
//                       1.0 - (difference / (itemSize * heightFactor));
//                   double opacity = percent;
//                   double scale = percent;
//                   if (opacity > 1.0) opacity = 1.0;
//                   if (opacity < 0.0) opacity = 0.0;
//                   if (percent > 1.0) scale = 1.0;
//
//                   return
//                   //   Container(
//                   //   width: Get.width*0.6,
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   margin: EdgeInsets.all(10),
//                   //   decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),),
//                   //   child: Column(
//                   //     children: [
//                   //       // Profile section
//                   //       Row(
//                   //         crossAxisAlignment: CrossAxisAlignment.start,
//                   //         children: [
//                   //           CircleAvatar(
//                   //             radius: 20,
//                   //            // backgroundImage: NetworkImage('https://via.placeholder.com/150'),
//                   //             backgroundImage: AssetImage(character.avatar??sun1),
//                   //           ),
//                   //           SizedBox(width: 10),
//                   //           Expanded(
//                   //             child: Column(
//                   //               crossAxisAlignment: CrossAxisAlignment.start,
//                   //               children: [
//                   //                 Row(
//                   //                   children: [
//                   //                     Text(
//                   //                       character.title??"Username",
//                   //                       style: TextStyle(fontWeight: FontWeight.bold),
//                   //                     ),
//                   //                     SizedBox(width: 5),
//                   //                     // Text(
//                   //                     //   character.description??"Description",
//                   //                     //   style: TextStyle(color: Colors.grey),
//                   //                     // ),
//                   //                     Spacer(),
//                   //                     Icon(Icons.more_vert),
//                   //                   ],
//                   //                 ),
//                   //                 SizedBox(height: 5),
//                   //                 Text(
//                   //                   character.description??"Description",
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //           ),
//                   //         ],
//                   //       ),
//                   //       SizedBox(height: 10),
//                   //       // Action buttons
//                   //       Row(
//                   //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //         children: [
//                   //           Icon(Icons.chat_bubble_outline),
//                   //           Icon(Icons.repeat),
//                   //           Icon(Icons.favorite_border),
//                   //           Icon(Icons.share),
//                   //         ],
//                   //       ),
//                   //     ],
//                   //   ),
//                   // );
//
//                     Align(
//                     heightFactor: heightFactor,
//                     child: Opacity(
//                       opacity: opacity,
//                       child: Transform(
//                         alignment: Alignment.center,
//                         transform: Matrix4.identity()..scale(scale, 1.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20.0),
//                               topRight: Radius.circular(20.0),
//                               bottomLeft: Radius.circular(20.0),
//                             ),
//                           //  side:BorderSide(color: primaryColor)
//                           ),
//                           color: primaryColor.withOpacity(0.3),
//                           //Color(character.color!),
//                           child: SizedBox(
//                             height: itemSize,
//                             child: Row(
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(15.0),
//                                   ),
//                                 ),
//                                 Image.asset(character.avatar!),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: characters.length,
//               ),
//             ),
//           ],
//         ),
//       );
//   }
// }