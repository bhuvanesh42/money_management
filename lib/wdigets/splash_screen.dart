import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/main.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> rotation;
  Animation<double> animation_in;
  Animation<double> animation_out;
  double initialradius = 30.0;
  double radius = 0.0;

  @override
  void initState() {
    _splashpage().then((value) => _navigator());
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    rotation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_in = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_out = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      print('step1');
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          radius = animation_in.value * initialradius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          radius = animation_out.value * initialradius;
        }
      });
    });
    controller.repeat();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> _splashpage() async {
    await Future.delayed(Duration(milliseconds: 5000), () {
      /* Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Myhomepage()));*/
    });
    return true;
  }

  void _navigator() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Myhomepage()));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, contraints) {
      return Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.fromLTRB(0, contraints.maxHeight * 0.2, 0, 0),
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/images/expenses.jpg'),
              ),
              SizedBox(
                height: contraints.maxHeight * 0.10,
              ),
              Container(
                width: contraints.maxHeight * 0.10,
                height: contraints.maxHeight * 0.10,
                child: Center(
                  child: RotationTransition(
                    turns: rotation,
                    child: Stack(
                      children: <Widget>[
                       /* Dot(
                          radius: 20.0,
                          color: Colors.red[600],
                        ),*/
                        Transform.translate(
                          offset: Offset(radius * cos(pi / 4),
                              radius * sin(pi / 4)),
                          child: Dot(
                            radius: 10.0,
                            color: Colors.blue,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(radius * cos(2 * pi / 4),
                              radius * sin(2 * pi / 4)),
                          child: Dot(
                            radius: 9.0,
                            color: Colors.blue,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(radius * cos(3 * pi / 4),
                              radius * sin(3 * pi / 4)),
                          child: Dot(
                            radius: 8.0,
                            color: Colors.blue,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(radius * cos(4 * pi / 4),
                              radius * sin(4 * pi / 4)),
                          child: Dot(
                            radius: 7.0,
                            color: Colors.blue,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(radius * cos(5 * pi / 4),
                              radius * sin(5 * pi / 4)),
                          child: Dot(
                            radius: 6.0,
                            color: Colors.blue,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(radius * cos(6 * pi / 4),
                              radius * sin(6 * pi / 4)),
                          child: Dot(
                            radius: 5.0,
                            color: Colors.blue,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(radius * cos(7 * pi / 4),
                              radius * sin(7 * pi / 4)),
                          child: Dot(
                            radius: 4.0,
                            color: Colors.blue,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(radius * cos(8 * pi / 4),
                              radius * sin(8 * pi / 4)),
                          child: Dot(
                            radius: 3.0,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: contraints.maxHeight * 0.11,
              ),
              Container(
                child: Shimmer.fromColors(
                    child: Text(
                      'Money Management',
                      style: TextStyle(fontSize: 30, fontFamily: 'Boogaloo'),
                    ),
                    baseColor: Colors.blue,
                    highlightColor: Colors.blueAccent),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.color, this.radius});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
      ),
    );
  }
}
