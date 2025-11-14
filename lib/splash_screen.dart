import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hktn/buyer/buyer_bottum_nav.dart';
import 'package:hktn/farmer/farmer_bottum_nav.dart';
import 'package:hktn/local_db/user/local_user.dart';
import 'package:hktn/sign_in.dart';
import 'package:hktn/widget/support_widget.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final logedIN = box.read('isLoggedIn');
  final userData = getLocalUser();

  startTimer() async{
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        //print(widget.check);
        return logedIN?userData!.role=='buyer'?BuyerBottomNav():FarmerBottumNav():SignIN();
      }));

    });
  }

  @override
  void initState() {     //ininstate function hocche ,application open korle,shobar prothome eta call hobe,startimer er age eta call hove,etar vhitor starttimer call hobe
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppWidget().whiteColor,
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 200,),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:Image.asset(
                "assets/logo/logo.png",
                width: AppWidget().screenWidth,
                height: 150,
                fit: BoxFit.fitHeight,
              ),
            ),

            // ClipOval(
            //   child:Image.asset("assets/images/BMI.png",height: 100,width: 100,),
            //
            // ),
            //Image.asset("assets/images/BMI.png",height: 100,width: 100,),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                //color: Colors.indigo[400],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  "Agro Connect",
                  style: GoogleFonts.bowlbyOne(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppWidget().primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),

            //Spacer(),
            SizedBox(height: 230,),
            Text("সহজ ও নিরাপদ সংযোগ ",style: GoogleFonts.galada(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppWidget().primaryColor,
            )),

          ],
        ),
      ),
    );
  }
}