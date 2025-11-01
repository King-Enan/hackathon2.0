import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hktn/db/db.dart';

import '../ banner/template_green.dart';
import '../component.dart';
import '../widget/support_widget.dart';


class AllVeg extends StatefulWidget {
  @override
  State<AllVeg> createState() => _AllVegState();
}

final vegs = ProductList();
int selectedIndex = 0;
String selectedCategory="All";

class _AllVegState extends State<AllVeg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppWidget().whiteColor,
      appBar: AppBar(
        title: Text(
          "All Vegetavle",
          style: AppWidget.QuickSandGreenSizeBold(24),
        ),
        backgroundColor: AppWidget().whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Category(),
            AppWidget().heightBox(10),
            allDummyProject(),
          ],
        ),
      ),
    );
  }

  Widget Category() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(vegs.categories.length, (index) {
          final data =vegs.categories[index];
          return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory=vegs.categories[index].toString();
                  print(selectedCategory);
                  selectedIndex = index;
                });
              },
              child: RectangleBox(
                name: data,
                isSelect: selectedIndex == index,
              ));
        }),
      ),
    );
  }

  // Future<List<Project>> getAllProjects() async {
  //   List<Project> projectList = [];
  //
  //   try {
  //     final url = Uri.parse("${API.getProject}?selected_category=$selectedCategory");
  //     var response = await http.get(url);
  //
  //     print("Response Status Code: ${response.statusCode}");
  //     print("Response Body: ${response.body}");
  //
  //     if (response.statusCode == 200) {
  //       var responseData = jsonDecode(response.body);
  //
  //       if (responseData["success"] == true) {
  //         for (var eachRecord in (responseData["projectData"] as List)) {
  //           projectList.add(Project.fromJson(eachRecord));
  //         }
  //       } else {
  //         print("API Response: No projects found");
  //       }
  //     } else {
  //       print("Error: ${response.statusCode}");
  //     }
  //   } catch (errorMsg) {
  //     print("Exception: $errorMsg");
  //   }
  //
  //   print("Total Projects: ${projectList.length}");
  //   return projectList;
  // }


  // Widget allProject() {
  //   return FutureBuilder(
  //       future: getAllProjects(),
  //       builder: (context, AsyncSnapshot<List<Project>> dataSnapShot) {
  //         if (dataSnapShot.connectionState == ConnectionState.waiting) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         if (dataSnapShot.data == null) {
  //           return const Center(
  //             child: Text(
  //               "Empty. No data found!",
  //             ),
  //           );
  //         }
  //         if (dataSnapShot.data!.isNotEmpty) {
  //           return Expanded(
  //             child: GridView.builder(
  //               shrinkWrap: true, // Ensures it takes only required space
  //               physics: BouncingScrollPhysics(), // Prevents scrolling inside GridView
  //               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
  //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2, // Two items per row
  //                   crossAxisSpacing: 2.0, // Space between columns
  //                   mainAxisSpacing: 2.0, // Space between rows
  //                   childAspectRatio:
  //                   AppWidget().screenHeight * .00108 // Adjusts item height
  //               ),
  //               itemCount: dataSnapShot.data!.length,
  //               itemBuilder: (context, index) {
  //                 final eachProject = dataSnapShot.data![index];
  //                 Map<String, dynamic> eachProjectMap = eachProject.toJson();
  //                 return TemplateGreen(data: eachProjectMap, index: 1);
  //               },
  //             ),
  //
  //             // ListView.builder(
  //             //   itemCount: dataSnapShot.data!.length,
  //             //   itemBuilder: (context, index) {
  //             //     Project eachProject = dataSnapShot.data![index];
  //             //     Map<String, dynamic> eachProjectMap = eachProject.toJson();
  //             //     return TemplateGreen(data: eachProjectMap, index: 1);
  //             //   },
  //             // ),
  //           );
  //         } else {
  //           return const Center(
  //             child: Text("Empty. No data found!"),
  //           );
  //         }
  //       });
  // }

  Widget allDummyProject() {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true, // Ensures it takes only required space
        physics: BouncingScrollPhysics(), // Prevents scrolling inside GridView
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 2.0, // Space between columns
            mainAxisSpacing: 2.0, // Space between rows
            childAspectRatio:
            AppWidget().screenHeight * .00108 // Adjusts item height
        ),
        itemCount: vegs.items.length,
        itemBuilder: (context, index) {
          final news = vegs.items[index];
          return TemplateGreen(data: news, index: index);
        },
      ),
    );
  }
}
