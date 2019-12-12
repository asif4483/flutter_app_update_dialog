library flutter_app_update_dialog;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';


class Showupdate extends StatefulWidget {

  final GestureTapCallback onTap ;
  final double btnfontsize,contantfontsize,headingfontsize;
  final Color btnfontcolor,contantfontcolor,headingcolor;
  final String heading,contant,btntext;
  final Curve curve;
  final int animationsec;
  final AppBar appBar;

  Showupdate({

    this.onTap,
    this.btnfontsize = 14,
    this.btnfontcolor = Colors.indigo,
    this.contantfontsize = 16,
    this.contantfontcolor = Colors.black54,
    this.heading = 'App Update',
    this.contant = 'Please upgrade to the new version of the application to continue',
    this.headingcolor = Colors.black,
    this.headingfontsize = 17,
    this.btntext = 'UPDATE',
    this.curve = Curves.decelerate,
    this.animationsec = 1100,
    this.appBar,
  });

  @override
  _ShowupdateState createState() => _ShowupdateState(
      onTap: onTap,
    appBar: appBar,
    animationsec: animationsec,
    btnfontcolor: btnfontcolor,
    btnfontsize: btnfontsize,
    btntext: btntext,
    contant: contant,
    contantfontcolor: contantfontcolor,
    contantfontsize: contantfontsize,
    curve: curve,
    heading: heading,
    headingcolor: headingcolor,
    headingfontsize: headingfontsize,

  );
}

class _ShowupdateState extends State<Showupdate> with SingleTickerProviderStateMixin{

  final GestureTapCallback onTap ;
  bool fabclose = false;
  final double btnfontsize,contantfontsize,headingfontsize;
  final Color btnfontcolor,contantfontcolor,headingcolor;
  final String heading,contant,btntext;
  final Curve curve;
  final int animationsec;
  final AppBar appBar;

  _ShowupdateState({

    this.onTap,
    this.btnfontsize = 14,
    this.btnfontcolor = Colors.indigo,
    this.contantfontsize = 16,
    this.contantfontcolor = Colors.black54,
    this.heading = 'App Update',
    this.contant = 'Please upgrade to the new version of the application to continue',
    this.headingcolor = Colors.black,
    this.headingfontsize = 17,
    this.btntext = 'UPDATE',
    this.curve = Curves.decelerate,
    this.animationsec = 1100,
    this.appBar,
  });

  AnimationController controller;
  SequenceAnimation sequenceAnimation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    controller = new AnimationController(vsync: this);

    sequenceAnimation = new SequenceAnimationBuilder()
        .addAnimatable(
        animatable: new Tween<double>(begin: 0.0, end: 1.0),
        from: Duration.zero,
        to: Duration(milliseconds: animationsec),
        curve: curve,
        tag: "opacity"
    ).animate(controller);

    _playAnimation();


  }


  Future<Null> _playAnimation() async {
    try {

      if(fabclose == true){
        await controller.reverse().orCancel;
        setState(() {
          fabclose = false;
        });
      }
      else{
        await controller.forward().orCancel;
        setState(() {
          fabclose = true;
        });
      }

    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }


  Widget _buildAnimation(BuildContext context, Widget child) {



    return new Center(
      child: new Opacity(opacity: sequenceAnimation["opacity"].value,
        child: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.black26,
              body: Center(
                child: Transform.scale(scale: sequenceAnimation["opacity"].value,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    elevation: 18.0,
                    child: Container(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.
                          circular(4.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 20,left: 25),
                              child: Text(heading,style: TextStyle(
                                  fontSize: headingfontsize,
                                  color: headingcolor,
                                  fontWeight: FontWeight.w500
                              ),),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 20,left: 25,right: 25),
                              child: Text(contant,style: TextStyle(
                                  fontSize: contantfontsize,
                                  color: contantfontcolor,
                                  fontWeight: FontWeight.normal
                              ),),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(top: 20,left: 25,right: 10),
                              child: FlatButton(
                                  onPressed: onTap, child: Text(btntext,style: TextStyle(
                                  fontSize: btnfontsize,
                                  color: btnfontcolor,
                                  fontWeight: FontWeight.normal
                              ),)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),),
              ),
            )
          ],
        ),),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: new AnimatedBuilder(animation: controller, builder: _buildAnimation),
    );
  }
}


