
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hktn/buyer/all_veg.dart';
import 'package:hktn/buyer/buyer_profile.dart';
import 'package:hktn/buyer/buyer_homepage.dart';
import 'package:hktn/farmer/farmer_dashboard.dart';
import 'package:hktn/farmer/farmer_products.dart';
import 'package:hktn/farmer/farmer_profile.dart';
import 'package:hktn/farmer/farmer_upload_product.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ant_design.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/gg.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/pajamas.dart';

import '../widget/support_widget.dart';


class FarmerBottumNav extends StatefulWidget {
  int? index;
  FarmerBottumNav({super.key,this.index});

  @override
  State<FarmerBottumNav> createState() => _FarmerBottumNavState();
}

class _FarmerBottumNavState extends State<FarmerBottumNav> {



  int? currentTabIndex;
  final GlobalKey<CurvedNavigationBarState> _bottomNavKey = GlobalKey();


  late List<Widget> pages;
  late FarmerDashboard farmerDashboard;
  late FarmerProducts farmerProducts;
  late FarmerProfile farmerProfile;
  //late AllVeg allVeg;
  // late InvestmentPost investmentPost;
  // late News news;
  // late Others others;

  @override
  void initState(){
    currentTabIndex=widget.index ?? 0;
    print(widget.index);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bottomNavKey.currentState?.setPage(currentTabIndex!);
    });

    farmerDashboard = FarmerDashboard();
    farmerProducts = FarmerProducts();
    farmerProfile = FarmerProfile();
    // allVeg = AllVeg();
    // investmentPost = InvestmentPost();
    // news = News();
    // others = Others();
    pages = [farmerDashboard,farmerProducts,farmerProfile];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavKey,
        height: 50,
        backgroundColor: currentTabIndex!=5?AppWidget().whiteColor:AppWidget().primaryColor,
        color:  AppWidget().primaryColor,
        animationDuration:  Duration(milliseconds: (widget.index??0)==0?500:0),  //If widget.index is null, it defaults to 0.
        onTap: (int index) {
          setState(() {
            widget.index=null;
            print(widget.index);
            currentTabIndex = index;
          });
        },
        items:  [
          //Iconify(Mdi.view_dashboard_outline,color: AppWidget().whiteColor,),
          Iconify(Mdi.tablet_dashboard,color: AppWidget().whiteColor,),
          Iconify(AntDesign.upload_outline,color: AppWidget().whiteColor,size: 32,),
          //Icon(Icons.cloud_upload,color: AppWidget().whiteColor,size: 32,),
          //Icon(Icons.home_outlined, color: Colors.white),
          //Icon(Icons.feed_outlined, color: Colors.white),
          Iconify(Pajamas.profile,color: AppWidget().whiteColor,size: 32,),
          //Icon(Icons.newspaper_outlined, color: Colors.white),
          //Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex!],
    );
  }
}