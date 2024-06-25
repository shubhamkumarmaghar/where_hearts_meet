import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuestWishList extends StatefulWidget {
  final String title;
   GuestWishList({Key? key, required this.title}) : super(key: key);


  @override
  _GuestWishListState createState() => _GuestWishListState();
}

class _GuestWishListState extends State<GuestWishList>
    with TickerProviderStateMixin{

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
  bool _side1=false;
  bool _side2=false;
  bool _canShowText = false;

  double width = 135.0, height = 135.0;
  late Offset position1,position2,position3 ;
  late AnimationController controller;
  late Animation<double> animation;
  late AnimationController controller1;
  late Animation<double> animation1;
  @override
  void initState() {
    super.initState();
    position1 = Offset(400, 55);
    position2=Offset(150, 55);
    position3=Offset(183,240);

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);


    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/squashcar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: _side1? Transform.translate(
              child: Image.asset(
                'assets/curtain1.jpg',
                width: 391,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              offset: Offset(animation.value,0.0),
            ):SizedBox(),

          ),

          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: _side1? Transform.translate(
              child: Image.asset(
                'assets/curtain1.jpg',
                width: 391,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              offset: Offset(animation1.value,0.0),
            ):SizedBox(),

          ),
          Positioned(
            top: 20,
            left: 250,
            child:_canShowText?Container(
                color: Colors.black54,
                height: 30.0,
                width: 300.0,
                child:Center(child: Text('   1/5 place line through centre of each wheel',style: TextStyle(color: Colors.amber),))
            ):SizedBox(),
          ),
          Positioned(
            top: 30,
            left: 13,
            child:_screenMaterial1? Container(
                color: Colors.black,
                child: Icon(Icons.volume_up)):SizedBox(),
          ),
          Positioned(
            bottom: 10,
            left: 13,
            child: _screenMaterial2? Container(
                color: Colors.black,

                child: Icon(Icons.info_outline)):SizedBox(),
          ),
          Positioned(
            bottom: 10,
            left: 65,
            child:_screenMaterial3?  Image.asset(
              'assets/facebook.png',
              height: Theme.of(context).iconTheme.size,
              width: Theme.of(context).iconTheme.size,
            ):SizedBox(),
          ),
          // Positioned(
          //   bottom: 15,
          //   left: 120,
          //   child: _screenMaterial4?  Image.asset(
          //     'assets/twitter.png',
          //     height: Theme.of(context).iconTheme.size - 12,
          //     width: Theme.of(context).iconTheme.size,
          //   ):SizedBox(),
          // ),
          Positioned(
            top: 100,
            right: 41,
            child:_screenMaterial5?Container(

              color: Colors.black,
              child: Icon(
                Icons.photo_camera,
              ),
            ):SizedBox(),
          ),
          Positioned(
            top: 145,
            right: 41,
            child:_screenMaterial6?Container(
              color: Colors.black,
              child: Icon(
                Icons.folder_open,
              ),
            ):SizedBox(),
          ),
          Positioned(
            top: 190,
            right: 41,
            child:_screenMaterial7?Container(
              color: Colors.black,
              child: Icon(
                Icons.cached,
                color: Colors.red,
              ),
            ):SizedBox(),
          ),
          Positioned(
            top: 235,
            right: 41,
            child:_nextButton?Container(
              color: Colors.black,
              child: IconButton(
                iconSize:33,
                icon: Icon(Icons.forward,
                  color: Colors.greenAccent,),
                onPressed: (){
                  setState(() {
                    _canShowLine=false;
                    _canShowText=false;
                    _canShowCircle1=!_canShowCircle1;
                    _canShowCircle2=!_canShowCircle2;
                    _nextButton1=!_nextButton1;
                    _nextButton=!_nextButton;
                  });
                },
              ),
            ):SizedBox(),
          ),
          Positioned(
            top: 245,
            right: 30,
            child:_nextButton1? IconButton(
              iconSize: 50,
              icon: Icon(Icons.forward,
                color: Colors.greenAccent,),
              onPressed: (){
                setState(() {
                  _nextButton1=_nextButton1;
                  _canShowCircle1=!_canShowCircle1;
                  _canShowCircle2=!_canShowCircle2;
                  _screenMaterial1=_screenMaterial1;
                  _screenMaterial2=_screenMaterial2;
                  _screenMaterial3=!_screenMaterial3;
                  _screenMaterial4=!_screenMaterial4;
                  _screenMaterial5=_screenMaterial5;
                  _screenMaterial6=_screenMaterial6;
                  _screenMaterial7=_screenMaterial7;
                  _side1=!_side1;
                  _side2=!_side2;
                  controller = new AnimationController(
                      duration: Duration(seconds: 3), vsync: this)..addListener(() =>
                      setState(() {}))..addStatusListener((status){
                    if(status==AnimationStatus.completed){controller.reverse();}
                  });
                  animation = Tween(begin: -400.0, end: 0.0).animate(controller);
                  controller.forward();
                  controller1 = new AnimationController(
                      duration: Duration(seconds: 3), vsync: this)..addListener(() =>
                      setState(() {}))..addStatusListener((status){
                    if(status==AnimationStatus.completed){controller1.reverse();}
                  });
                  animation1 = Tween(begin: 400.0, end: 0.0).animate(controller1);
                  controller1.forward();
                });
              },
            ):SizedBox(),
          ),
          Positioned(
            bottom: 20,
            right: 110,
            child:_canShowButton ?ClipOval(
              child: Container(
                color: Colors.black,
                height: 122.0,
                width: 122.0,
                child: Center(
                  child: ClipOval(
                    child: Container(
                      // #980F10
                      color: Color.fromRGBO(152, 15, 16, 1),
                      height: 78,
                      width: 78,
                      child: GestureDetector(
                        onTap: () {
                          {
                            setState(() {
                              _canShowButton = !_canShowButton;
                              _canShowLine=true;
                              _canShowText=true;
                            });


                          }




                        },
                        child: Center(
                          child: Text(
                            "START",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
                : SizedBox(),
          ),
          Positioned(
            left: position3.dx,
            top: position3.dy,
            child: _canShowLine ?GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    position3 = Offset(position3.dx + details.delta.dx, position3.dy + details.delta.dy);
                  });
                },
                child:
                Container(
                  height:5.0,
                  width:400.0,
                  color:Colors.lightBlue,)
            ):SizedBox(),


          ),
          Positioned(
            left: position2.dx,
            top: position2.dy,
            child: _canShowCircle1?GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  position2 = Offset(position2.dx + details.delta.dx, position2.dy + details.delta.dy);
                });
              },
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ):SizedBox(),


          ),
          Positioned(
            left: position1.dx,
            top: position1.dy,
            child: _canShowCircle2?GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  position1 = Offset(position1.dx + details.delta.dx, position1.dy + details.delta.dy);
                });
              },
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ):SizedBox(),


          ),

        ],
      ),
    );
  }

}