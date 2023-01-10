import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../product_profile/image_profile.dart';

class CategoryProfile extends StatefulWidget {
  const CategoryProfile({Key key, this.pagename, this.appbarname, this.imageUrl}) : super(key: key);

  final String pagename;
  final String appbarname;
  final String imageUrl;

  @override
  State<CategoryProfile> createState() => _CategoryProfileState();
}

class _CategoryProfileState extends State<CategoryProfile> {
  List<DocumentSnapshot> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.appbarname.toUpperCase(),
          style: const TextStyle(color: Colors.black, fontFamily: "gilroy-bold", fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(widget.pagename).snapshots(),
          builder: (context, AsyncSnapshot streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("asset/animations/1.json", height: 100, reverse: true, repeat: true, fit: BoxFit.cover),
              );
            } else if (streamSnapshot.hasError) {
              return const Text("Maglumat gelmedi internet yalnyslygy bar");
            } else if (streamSnapshot.data.docs.isEmpty) {
              return Center(
                child: Lottie.asset("asset/animations/1.json", height: 100, reverse: true, repeat: true, fit: BoxFit.cover),
              );
            } else {
              final data1 = streamSnapshot.data.docs;
              images.addAll(data1);
              images.shuffle();
              return StaggeredGridView.countBuilder(
                itemCount: images.length,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ImageProfile(
                            imageUrl: images[index]["image"],
                            pagename: data1[index]["name"],
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          child: Image.network(
                            images[index]["image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.count(1, index % 2 == 0 ? 1.2 : 1.5);
                },
              );
            }
          }),
    );
  }
}
