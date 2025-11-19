import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hktn/buyer/my_cart.dart';
import 'package:hktn/local_db/user/local_user.dart';
import 'package:hktn/local_db/user/user_cart.dart';
import 'package:hktn/models/cart_model.dart';
import 'package:hktn/models/order_model.dart';
import 'package:hktn/services/order_service.dart';
import 'package:hktn/services/product_service.dart';
import '../widget/support_widget.dart';


class VegDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  int index;
  VegDetails({super.key, required this.data,required this.index});

  @override
  State<VegDetails> createState() => _VegDetailsState();
}

class _VegDetailsState extends State<VegDetails> {

  final box=GetStorage();
  final TextEditingController quantityController = TextEditingController();
  //List<CartItem>? to_transectionn;
  List<Map<String, dynamic>> cart = CartStorage.getCart();
  Map<String,dynamic> to_transection=
  {
    'productId' : '',
    "productName": "",
    "category": "",
    "imgURL" : "",
    "buyerUid" : "",
    "sellerUid": "",
    "quantity": 0,
    "price": 0,
    // "roi": 0,
    "ordering" : 0,
    "totalPrice" : 0,
    "status": "pending",
    "Date" : "Jan 01,2025",
    "GateWay" : "",
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    available = widget.data['stock'];
    fix_available = available;
    quantityController.text = (fix_available-available).toString();
    to_transection['productId']=widget.data['productId'];
    to_transection['productName']=widget.data['productName'];
    to_transection['imageURL']=widget.data['imageURL'];
    to_transection['sellerUid']=widget.data['sellerUid'];
    to_transection['category']=widget.data['category'];
    to_transection['price']=widget.data['price'];


  }
  // final favinvestment=FavInvestment();
  // final reviews=Reviews();
  late int fix_available ;
  String temp_quantity="";
  String last_value="0";
   int selectTitle = 0;
  int quantity = 0;
  // late int available;
  int available = 0;
  bool agree =false;
  bool left_review=true;
  // @override
  Widget build(BuildContext context) {
    //available=widget.data['project_total_share_numbers']-widget.data['project_share_sold'];
    // List<Widget> titels = [
    //   Text("Description", style: selectTitle == 0 ? AppWidget.QuickSandWhiteSizeBold(12) : AppWidget.QuickSandGreenSizeBold(12)),
    //   Text("Details", style: selectTitle == 1 ? AppWidget.QuickSandWhiteSizeBold(12) : AppWidget.QuickSandGreenSizeBold(12)),
    //   Text("Review", style: selectTitle == 2 ? AppWidget.QuickSandWhiteSizeBold(12) : AppWidget.QuickSandGreenSizeBold(12)),
    // ];

    return Scaffold(
      backgroundColor: AppWidget().whiteColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(),
            AppWidget().heightSpace,
            BasicDetails(),
            AppWidget().heightSpace,
            // SegmentedControl(titels),
            // AppWidget().heightSpace,
            // SegmentBoxs(),
            // AppWidget().heightSpace,
            PayementBox(),
          ],
        ),
      ),
    );
  }

  // Widget SpareImageWidget() {
  //   return Container(
  //     padding: EdgeInsets.only(top: 35, left: 15, right: 20, bottom: 15),
  //     width: AppWidget().screenWidth,
  //     height: AppWidget().screenHeight / 2.5,
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: NetworkImage(widget.data['imageURL'].toString() ?? ""),
  //         fit: BoxFit.cover,
  //         opacity: .8,
  //       ),
  //       borderRadius: BorderRadius.only(
  //           bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
  //       boxShadow: AppWidget().boxShadow15,
  //     ),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             GestureDetector(
  //               onTap: () {
  //                 Get.back();
  //               },
  //               child: Icon(
  //                 CupertinoIcons.back,
  //                 color: AppWidget().whiteColor.withOpacity(.7),
  //                 size: 36,
  //               ),
  //             ),
  //             Text("Details", style: AppWidget.QuickSandWhiteSize(24)),
  //             GestureDetector(
  //               // onTap: () {
  //               //   if(widget.data['isFavorite']){
  //               //     favinvestment.removeInvestmentById(widget.data['id']);
  //               //   }
  //               //   else {
  //               //     favinvestment.addInvestment(widget.data);
  //               //   }
  //               //   print(favinvestment.favoriteInvestments.length);
  //               //   setState(() {
  //               //     if (widget.data.containsKey('isFavorite') &&
  //               //         widget.data['isFavorite'] is bool) {
  //               //       widget.data['isFavorite'] =
  //               //       !widget.data['isFavorite'] as bool;
  //               //     }
  //               //   });
  //               // },
  //               child: Icon(
  //                 widget.data['isFavorite'] == true
  //                     ? CupertinoIcons.heart_fill
  //                     : CupertinoIcons.heart,
  //                 color: AppWidget().whiteColor,
  //                 size: 34.0,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.star_border_purple500_rounded,
  //                   color: AppWidget().yellowColor,
  //                   size: 25.0,
  //                 ),
  //                 AppWidget().widthBox(AppWidget().fixPadding * 0.3),
  //                 Text(
  //                   widget.data['risk']?.toString() ?? '0.0',
  //                   style: GoogleFonts.quicksand(
  //                     color: widget.data['risk'] == "Low"
  //                         ? AppWidget().primaryColor
  //                         : widget.data['risk'] == "Medi.."
  //                         ? AppWidget().yellowColor
  //                         : AppWidget().redColor,
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               children: [
  //                 Text(
  //                   "Status :",
  //                   style: AppWidget.QuickSandWhiteSizeBold(18),
  //                 ),
  //                 AppWidget().width5Space,
  //                 Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
  //                   height: 30,
  //                   decoration: BoxDecoration(
  //                     color: widget.data["investmentStatus"] == "Completed"
  //                         ? AppWidget().primaryColor
  //                         : widget.data["investmentStatus"] == "Running"
  //                         ? AppWidget().yellowColor
  //                         : AppWidget().greyColor,
  //                     borderRadius: BorderRadius.circular(16),
  //                   ),
  //                   child: Text(
  //                     widget.data["investmentStatus"],
  //                     style: AppWidget.QuickSandWhiteSize(18),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget ImageWidget() {
    return Container(
      padding: EdgeInsets.only(top: 35, left: 15, right: 20, bottom: 15),
      width: AppWidget().screenWidth,
      height: AppWidget().screenHeight / 2.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.data['imageURL'].toString() ?? ""),
          fit: BoxFit.cover,
          opacity: .8,
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: AppWidget().boxShadow15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
             mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: AppWidget().whiteColor.withOpacity(.7),
                  size: 36,
                ),
              ),
              Text("Details", style: AppWidget.QuickSandWhiteSize(24)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star_border_purple500_rounded,
                    color: AppWidget().yellowColor,
                    size: 25.0,
                  ),
                  AppWidget().widthBox(AppWidget().fixPadding * 0.3),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        widget.data['category'],
                        style: GoogleFonts.quicksand(
                          color: AppWidget().primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Status :",
                    style: AppWidget.QuickSandWhiteSizeBold(18),
                  ),
                  AppWidget().width5Space,
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  //   height: 30,
                  //   decoration: BoxDecoration(
                  //     color: widget.data["project_status"] == "Completed"
                  //         ? AppWidget().primaryColor
                  //         : widget.data["project_status"] == "Running"
                  //         ? AppWidget().yellowColor
                  //         : AppWidget().greyColor,
                  //     borderRadius: BorderRadius.circular(16),
                  //   ),
                  //   child: Text(
                  //     widget.data["project_status"],
                  //     style: AppWidget.QuickSandWhiteSize(18),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget BasicDetails() {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 20.0, right: 20, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data['productName'],
            style: AppWidget.QuickSandBlackSizeBold(28),
            overflow: TextOverflow.values[1],
          ),
          AppWidget().height5Space,
          Row(
            children: [
              Icon(
                CupertinoIcons.building_2_fill,
                color: AppWidget().primaryColor.withOpacity(.8),
                size: 26,
              ),
              AppWidget().widthSpace,
              Text(
                widget.data['sellerUid'].toString(),
                style: AppWidget.QuickSandGreenSizeBold(20),
              ),
            ],
          ),
          AppWidget().height5Space,
          Row(
            children: [
              Icon(
                CupertinoIcons.placemark_fill,
                color: AppWidget().greyColor.withOpacity(.8),
                size: 18,
              ),
              AppWidget().widthBox(20),
              Text(
                "ase ekta",
                //widget.data['location'],
                style: AppWidget.QuickSandGreySizeBold(14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget PayementBox(){
    void increaseQuantity() {
      setState(() {
        available--;
        quantity++;
      });
      print(available);
    }

    void decreaseQuantity() {
      if (quantity > 0) {
        setState(() {
          available++;
          quantity--;
        });
      }
      print(available);
    }

    return Container(
      margin: const EdgeInsets.only(top: 8, left: 20.0, right: 20, bottom: 0),
      //padding: EdgeInsets.all(12),
      child: Column(
        children: [
          //available units
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Available Units",style: AppWidget.QuickSandBlackSizeBold(22),),
              Text(available.toString()+" KG",style: AppWidget.QuickSandGreenSizeBold(26),),
            ],
          ),
          AppWidget().heightSpace,
          AppWidget().heightSpace,
          //total
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppWidget().primaryColor.withOpacity(.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppWidget().width5Space,
                    Text("Total Cost",style: AppWidget.KumbhSansBlack87SizeBold(16),),
                    Text(((fix_available-available)*widget.data['price']).toStringAsFixed(2)+" Tk",style: AppWidget.KumbhSansGreenSizeBold(16),),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 50, // Adjust height as needed
                  child: VerticalDivider(
                    color: Colors.grey, // Divider color
                    thickness: 1, // Divider thickness
                    width: 20, // Space around the divider
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppWidget().width5Space,
                    Text("Total Weight",style: AppWidget.KumbhSansBlack87SizeBold(16),),
                    Text((fix_available-available).toStringAsFixed(0)+"KG",style: AppWidget.KumbhSansGreenSizeBold(16),),

                  ],
                ),
              ],
            ),
          ),
          AppWidget().heightSpace,
          AppWidget().heightSpace,
          // (+,_)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //AppWidget().heightBox(15),
              Text("You are Ordering",style: AppWidget.QuickSandBlackSizeBold(18)),
              Container(
                width: 150,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Outer border radius
                  border: Border.all(
                    color: AppWidget().blackColor.withOpacity(.8),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40, // Match parent height
                      width: 40, // Square button
                      decoration: BoxDecoration(
                        color: AppWidget().primaryColor.withOpacity(.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8), // Match outer radius
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove, size: 16),
                        onPressed: (){
                          decreaseQuantity();
                          setState(() {
                            quantityController.text = (fix_available-available).toString();
                          });
                        }
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical:6),
                      child: Container(
                        width: 50,
                        child: TextField(
                          onChanged: (text){

                            if(temp_quantity.length>text.length)
                              {
                                if(text.isEmpty || text ==null)
                                {
                                  available = fix_available;
                                }
                                else {
                                  print("minus");
                                  int? lst = int.tryParse(text);
                                  available = fix_available - lst!;
                                  quantity = lst;
                                }
                              }
                            else
                              {
                                print("plus");
                                int? lst = int.tryParse(text);
                                available = fix_available - lst!;
                                quantity = lst;
                              }
                            temp_quantity = text;
                            int value = int.tryParse(text) ?? 0;
                            if(value>fix_available)
                              quantityController.text= fix_available.toString();

                            if(available>fix_available)
                              available=fix_available;
                            if(available<0)
                              available = 0;
                            setState(() {
                              available = available;
                              quantity =quantity;

                            });
                          },
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: AppWidget.QuickSandBlackSize(20),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppWidget().primaryColor.withOpacity(.2),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8), // Match outer radius
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add, size: 16),
                        onPressed: () {
                          if (available> 0) {
                            increaseQuantity();
                            setState(() {
                              quantityController.text = (fix_available-available).toString();
                            });
                          } else {
                            //Get.snackbar("Stock Finished", "No more items available!");
                          }
                        },

                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
          AppWidget().heightSpace,
          AppWidget().heightSpace,
          Terms_Agreement(),
          AppWidget().heightSpace,
          //order now
          GestureDetector(
            onTap: ()async{
              await ProductService().increasePurchase(to_transection["productId"]);
              to_transection["quantity"] = fix_available-available;
              double totalPrice = to_transection["quantity"] * widget.data['price'];
              to_transection["totalPrice"] = totalPrice;
              to_transection["buyerUid"] = getLocalUser()!.email;
              // print(to_transection["ordering"]);
              // print(to_transection["total"]);
              if(CartStorage.isExisting(to_transection['productId']))
                {
                  CartStorage.updateCart(to_transection['productId'], to_transection['quantity'],(to_transection['totalPrice'] ?? 0.0).toDouble(),);
                }
              else
                {
                  cart.add(to_transection);
                  CartStorage.saveCartList(cart);
                }
              print(to_transection['buyerEmail']);
              createOrder(to_transection);
              agree ? Get.to(MyCart()) : null;

            },
            child: Container(
              width: AppWidget().screenWidth,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: agree?AppWidget().primaryColor:AppWidget().primaryColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Order Now",style: AppWidget.QuickSandWhiteSizeBold(20),),
                  AppWidget().widthSpace,
                  Icon(CupertinoIcons.arrow_right,weight: 22,color: AppWidget().whiteColor,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void createOrder(Map<String,dynamic> order)async{
    OrderModel orderModel = OrderModel.fromMap(order);
    await OrderService().createOrder(orderModel);
  }
  

  Widget Terms_Agreement(){
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent), // Removes default border of expand tile
      child: ExpansionTile(
        maintainState: true,
        tilePadding: EdgeInsets.zero,
        leading: Checkbox(
          activeColor: AppWidget().primaryColor,
          value: agree,
          onChanged: (value) {
            setState(() {
              agree = value!;
            });
          },
        ),
        title: Row(
          children: [
            Expanded( // Prevents overflow issue
              child: Row(
                children: [
                  Text("Agree with ", style: AppWidget().medium14Black),
                  Text("Terms & Agreement", style: AppWidget().medium14Primary),
                ],
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "1. **Investment Risk**: All investments carry risks, including potential loss of principal.\n\n"
                  "2. **No Guaranteed Returns**: Past performance does not indicate future results. Returns may vary.\n\n"
                  "3. **Withdrawal Restrictions**: Some investments may have lock-in periods. Early withdrawal may incur penalties.\n\n"
                  "4. **Regulatory Compliance**: Investors must comply with applicable financial regulations and tax laws.\n\n"
                  "5. **Market Fluctuations**: Investment values may fluctuate due to market conditions, and returns are not fixed.\n\n"
                  "6. **Due Diligence**: It is your responsibility to research and understand investment opportunities before committing funds.\n\n"
                  "7. **Modification of Terms**: The company reserves the right to update investment policies and conditions at any time.",
              style: AppWidget().medium14Black,
            ),
          ),
        ],
      ),
    );
  }

  int calculateRemaining(int total_share,int remaining_share)
  {
    return total_share-remaining_share;
  }


  //
  // Widget SegmentedControl(List<Widget> titels) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 8, left: 5.0, right: 5, bottom: 0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: AppWidget().screenWidth,
  //           child: CupertinoSegmentedControl(
  //             groupValue: selectTitle,
  //             children: {
  //               0: SizedBox(
  //                 height: 35,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: titels[0],
  //                 ),
  //               ),
  //               1: SizedBox(
  //                 height: 35,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: titels[1],
  //                 ),
  //               ),
  //               2: SizedBox(
  //                 height: 35,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: titels[2],
  //                 ),
  //               ),
  //             },
  //             onValueChanged: (index) {
  //               setState(() {
  //                 selectTitle = index;
  //               });
  //             },
  //             borderColor: AppWidget().primaryColor,
  //             selectedColor: AppWidget().primaryColor.withOpacity(.9),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget SegmentBoxs(){
  //   return Container(
  //     margin: const EdgeInsets.only(top: 8, left: 20.0, right: 20, bottom: 0),
  //     padding: EdgeInsets.all(12),
  //     width: AppWidget().screenWidth,
  //     decoration: BoxDecoration(
  //       color: AppWidget().primaryColor.withOpacity(.3),
  //       borderRadius: BorderRadius.circular(4),
  //       border: Border.all(
  //         color: AppWidget().primaryColor.withOpacity(.8),
  //         width: 2,
  //       ),
  //     ),
  //     child:
  //     selectTitle == 0 ?
  //     Text(widget.data['project_description'],style: AppWidget.KumbhSansBlackSize(14)):
  //     selectTitle==1?
  //     Details()
  //         :Review(),
  //   );
  // }
  //

  //
  //
  // Widget Details(){
  //   return DataTable(
  //     decoration: BoxDecoration(
  //       color:   Colors.grey.shade100,
  //     ),
  //     dataRowHeight: 40,
  //     headingRowHeight: 40,
  //     columns: [
  //       DataColumn(label: Text("Category",style: AppWidget.KumbhSansBlackSizeBold(14),overflow: TextOverflow.ellipsis)),
  //       DataColumn(label: Text(widget.data['project_category_name'].toString(),style: AppWidget.KumbhSansBlackSizeBold(14),overflow: TextOverflow.ellipsis,maxLines: 1,)),
  //     ],
  //     rows: [
  //       DataRow(cells: [
  //         DataCell(Text("Price Per Share",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text(widget.data['project_share_unit_price'].toString()+" TK",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //       DataRow(cells: [
  //         DataCell(Text("ROI",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text(widget.data['project_roi'].toString(),style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //       DataRow(cells: [
  //         DataCell(Text("Return Period",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text(2.toString(),style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //       DataRow(cells: [
  //         DataCell(Text("Number Of Returns",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text(1.toString(),style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //       DataRow(cells: [
  //         DataCell(Text("Total Units",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text(widget.data['project_total_share_numbers	'].toString(),style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //       DataRow(cells: [
  //         DataCell(Text("Remaining Units",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text("${calculateRemaining(widget.data['project_total_share_numbers'], widget.data['project_share_sold']).toString()}",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //       DataRow(cells: [
  //         DataCell(Text("Risk",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text(widget.data['project_risk_types'].toString(),style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //       DataRow(cells: [
  //         DataCell(Text("Status",style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //         DataCell(Text(widget.data['project_status'].toString(),style: AppWidget.KumbhSansBlackSizeBold(14),)),
  //       ]),
  //     ],
  //   );
  // }
  //
  // Widget Review(){
  //   return Container(
  //     //margin: const EdgeInsets.only(top: 8, left: 20.0, right: 20, bottom: 0),
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             GestureDetector(
  //                 onTap: (){
  //                   setState(() {
  //                     left_review = !left_review;
  //                   });
  //                 },
  //                 child: Text("Investment Reviews",style: left_review?AppWidget.KumbhSansBlack87SizeBold(14):AppWidget.KumbhSansGreySizeBold(14))),
  //             Container(
  //               padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
  //               height: 50, // Adjust height as needed
  //               child: VerticalDivider(
  //                 color: Colors.grey, // Divider color
  //                 thickness: 1, // Divider thickness
  //                 width: 20, // Space around the divider
  //               ),
  //             ),
  //             GestureDetector(
  //                 onTap: (){
  //                   setState(() {
  //                     left_review = !left_review;
  //                   });
  //                 },
  //                 child: Text("Company Review",style: !left_review?AppWidget.KumbhSansBlack87SizeBold(14):AppWidget.KumbhSansGreySizeBold(14))),
  //           ],
  //         ),
  //         ReviewContent(),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget ReviewContent(){
  //   return SingleChildScrollView(
  //     physics: BouncingScrollPhysics(),
  //     child: Container(
  //       height: 300,
  //       padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
  //       child: ListView.builder(
  //           itemCount: reviews.investmentReviews.length,
  //           itemBuilder: (context,index){
  //             print(reviews.investmentReviews.length);
  //             final review = reviews.investmentReviews[index];
  //             return ReviewTemplate(review);
  //           }),
  //     ),
  //   );
  // }


}
