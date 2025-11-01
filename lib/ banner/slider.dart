import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../widget/support_widget.dart';


class SliderBar extends StatefulWidget {
  const SliderBar({super.key});

  @override
  State<SliderBar> createState() => _SliderBarState();
}

class _SliderBarState extends State<SliderBar> {
  @override
  int currentPosterIndex = 0;

  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        CarouselSlider(
          items: [
            banner1(),
            banner2(size),
            banner3(size),
          ],
          options: CarouselOptions(
            autoPlay: true,
            height: 150,
            viewportFraction: 1.0,
            initialPage: currentPosterIndex,
            onPageChanged: (index, reason) {
              setState(() {
                currentPosterIndex = index;
              });
            },
          ),
        ),
        AppWidget().heightSpace,
        AppWidget().heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
                (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: AppWidget().fixPadding / 4),
                height: 8.0,
                width: currentPosterIndex == index ? 25.0 : 8.0,
                decoration: BoxDecoration(
                  color:
                  currentPosterIndex == index ? AppWidget().primaryColor : AppWidget().greyD9Color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

Widget banner3(Size size) {
  return Container(
    padding: EdgeInsets.only(right: size.width * 0.13),
    margin: EdgeInsets.symmetric(horizontal: AppWidget().fixPadding * .3),
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: DecorationImage(
        image: AssetImage("assets/homebanner/seed.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    alignment: Alignment.centerRight,
    // child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text(
    //       "HOT\nOFFER",
    //       style: AppWidget().extrabold28White.copyWith(height: 1.2),
    //       textAlign: TextAlign.center,
    //     ),
    //     AppWidget().heightSpace,
    //     Container(
    //       padding: EdgeInsets.symmetric(
    //           horizontal: AppWidget().fixPadding *.03, vertical: AppWidget().fixPadding * 0.6),
    //       decoration: BoxDecoration(
    //           color: AppWidget().primaryColor, borderRadius: BorderRadius.circular(5.0)),
    //       child: Text(
    //         "Invest Now",
    //         style: AppWidget().extrabold16White,
    //         textAlign: TextAlign.center,
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //     )
    //   ],
    // ),
  );
}

Widget banner2(Size size) {
  return Container(
    padding: EdgeInsets.only(left: size.width * 0.12),
    margin: EdgeInsets.symmetric(horizontal: AppWidget().fixPadding * .3),
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: const DecorationImage(
        image: AssetImage("assets/homebanner/carrot.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    alignment: Alignment.centerLeft,
    // child: Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Text(
    //       "Delicious\nFood Menu",
    //       style: AppWidget().extrabold28White.copyWith(height: 1.2),
    //       textAlign: TextAlign.center,
    //     ),
    //     AppWidget().heightSpace,
    //     Container(
    //       padding: EdgeInsets.symmetric(
    //           horizontal: AppWidget().fixPadding * 2.0, vertical: AppWidget().fixPadding * 0.6),
    //       decoration: BoxDecoration(
    //           color: AppWidget().primaryColor, borderRadius: BorderRadius.circular(5.0)),
    //       child: Text(
    //         "Order Now",
    //         style: AppWidget().extrabold16White,
    //         textAlign: TextAlign.center,
    //         overflow: TextOverflow.ellipsis,
    //       ),
    //     )
    //   ],
    // ),
  );
}

Widget banner1() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: AppWidget().fixPadding * 1.0),
    margin:  EdgeInsets.symmetric(horizontal: AppWidget().fixPadding * .3),
    width: double.maxFinite,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      image: const DecorationImage(
        image: AssetImage("assets/homebanner/all.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    alignment: Alignment.centerRight,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "HOT\nDEAL",
          style: AppWidget().extrabold30White,
        ),
        AppWidget().height5Space,
        Text(
          "INVEST NOW",
          style: AppWidget().medium16White,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
}