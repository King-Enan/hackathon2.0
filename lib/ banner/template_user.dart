import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hktn/buyer/buyer_visit_farmer.dart';

import '../widget/support_widget.dart';



class TemplateUser extends StatefulWidget {
  final Map<String, dynamic> data; // Ensure data is a Map
  int index;

  TemplateUser({super.key, required this.data,required this.index});

  @override
  State<TemplateUser> createState() => _TemplateUserState();
}

class _TemplateUserState extends State<TemplateUser> {
  // final bookednews=BookmarkedNews();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(BuyerVisitFarmer());
        // Get.to(NewsDetails(data: widget.data,index: widget.index,));
      },
      child: Container(
        width: 180,
        margin: EdgeInsets.only(right:  AppWidget().fixPadding,bottom: 15),
        padding: EdgeInsets.all(AppWidget().fixPadding),
        decoration: BoxDecoration(
          color: AppWidget().whiteColor,
          //color: AppWidget().primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: AppWidget().boxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageWidget(
                widget.data
                // ,
                //     () {
                //   if(widget.data['bookmarked'])
                //   {
                //     bookednews.removeNewsById(widget.data['id']);
                //   }
                //   else{
                //     bookednews.addNews(widget.data);
                //   }
                //   print(bookednews.bookmarkedNewsList.length);
                //   setState(() {
                //     if (widget.data.containsKey('bookmarked') && widget.data['bookmarked'] is bool) {
                //       widget.data['bookmarked'] = !(widget.data['bookmarked'] as bool);
                //     }
                //   });
                // }
            ),
            AppWidget().heightSpace,
            Text(
              widget.data['name']?.toString() ?? 'No Name',
              style: AppWidget().semibold14Black,
              overflow: TextOverflow.ellipsis,
            ),
            AppWidget().heightBox(AppWidget().fixPadding * 0.3),
            Text(
              widget.data['location']?.toString() ?? 'No Description',
              style: AppWidget().medium12Primary,
              overflow: TextOverflow.ellipsis,
            ),
            AppWidget().heightBox(AppWidget().fixPadding * 0.3),
            Text(
              widget.data['sellerType']?.toString() ?? 'No Description',
              style: AppWidget().medium12Grey,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              softWrap: true,
            ),
            AppWidget().heightBox(AppWidget().fixPadding * 0.3),
            Row(
              children: [
                Text(
                  widget.data['phoneNumber']?.toString() ?? 'No Description',
                  style: AppWidget().medium12Grey,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget imageWidget(Map<String, dynamic> itemData
    // , Function() onTap
    ) {
  return Container(
    padding: EdgeInsets.all(AppWidget().fixPadding * 0.5),
    width: 160,
    height: AppWidget().screenHeight/12,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      image: DecorationImage(
        image: AssetImage(itemData['image']?.toString() ?? ''),
        fit: BoxFit.cover,
      ),
    ),
    alignment: Alignment.topRight,
    // child: GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     height: 25.0,
    //     width: 25.0,
    //     decoration: BoxDecoration(
    //       color: AppWidget().primaryColor.withOpacity(0.4),
    //       borderRadius: BorderRadius.circular(5.0),
    //     ),
    //     child: Icon(
    //       itemData['bookmarked'] == true
    //           ? CupertinoIcons.bookmark_fill
    //           : CupertinoIcons.bookmark,
    //       color: AppWidget().whiteColor,
    //       size: 20.0,
    //     ),
    //   ),
    // ),
  );
}
