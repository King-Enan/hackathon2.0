
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hktn/buyer/buyer_dashboard.dart';
import 'package:hktn/buyer/buyer_homepage.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../widget/support_widget.dart';


class BottomNav extends StatefulWidget {
  int? index;
  BottomNav({super.key,this.index});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {



  int? currentTabIndex;
  final GlobalKey<CurvedNavigationBarState> _bottomNavKey = GlobalKey();


  late List<Widget> pages;
  late BuyerHomepage buyerHomePage;
  late BuyerDashboard buyerDashboard;
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

    buyerHomePage = BuyerHomepage();
    buyerDashboard = BuyerDashboard();
    // investmentPost = InvestmentPost();
    // news = News();
    // others = Others();
    pages = [buyerHomePage,buyerDashboard];
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
          Iconify(Ep.home_filled,color: AppWidget().whiteColor,),
          Iconify(Mdi.list_box_outline,color: AppWidget().whiteColor,),
          //Icon(CupertinoIcons.news_solid,color: AppWidget().whiteColor,),
          //Icon(Icons.home_outlined, color: Colors.white),
          //Icon(Icons.feed_outlined, color: Colors.white),
          //Icon(Icons.newspaper_outlined, color: Colors.white),
          //Icon(Icons.person_outline, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex!],
    );
  }
}