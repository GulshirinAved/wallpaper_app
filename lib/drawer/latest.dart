import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tazewallpaper/product_profile/image_profile.dart';

class Latest extends StatefulWidget {
  final String appbarname;
  final String pagename;

  const Latest({Key key, this.appbarname, this.pagename}) : super(key: key);

  @override
  State<Latest> createState() => _LatestState();
}

class _LatestState extends State<Latest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarlatest(),
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
              return const Text("Maglumat yok");
            } else {
              final data1 = streamSnapshot.data.docs;
              return StaggeredGridView.countBuilder(
                itemCount: data1.length,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ImageProfile(
                            imageUrl: data1[index]["image"],
                            pagename: data1[index]["name"],
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          child: Image.network(
                            data1[index]["image"] ?? 0,
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

  AppBar appbarlatest() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        widget.appbarname,
        style: const TextStyle(color: Colors.black, fontFamily: "gilroy-bold", fontSize: 25),
      ),
    );
  }
}
