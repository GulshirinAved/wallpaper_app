import '../constants/packages.dart';

class CategoryDrawer extends StatefulWidget {
  const CategoryDrawer({Key key, this.appbarname, this.pagename, this.imageUrl}) : super(key: key);

  final String appbarname;
  final String pagename;
  final String imageUrl;

  @override
  State<CategoryDrawer> createState() => _CategoryDrawerState();
}

class _CategoryDrawerState extends State<CategoryDrawer> {
  List<DocumentSnapshot> images = [];
  ScrollController scrollController = ScrollController();
  AppBar appbarCategory() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(
        widget.appbarname,
        style: const TextStyle(color: Colors.black, fontFamily: "gilroy-medium", fontSize: 25),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbarCategory(),
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
              images.addAll(data1);
              images.shuffle();
              return GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                controller: scrollController,
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => CategoryProfile(
                                  imageUrl: images[index]["image"],
                                  pagename: data1[index]["name"],
                                  appbarname: Get.locale.languageCode == 'en'
                                      ? data1[index]["nameen"]
                                      : Get.locale.languageCode == 'ru'
                                          ? data1[index]["nameru"]
                                          : data1[index]["nametm"],
                                ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              data1[index]["image"],
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Text(
                          Get.locale.languageCode == 'en'
                              ? data1[index]["nameen"]
                              : Get.locale.languageCode == 'ru'
                                  ? data1[index]["nameru"]
                                  : data1[index]["nametm"],
                          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "gilroy-bold"),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}





// GridView.builder(
//         scrollDirection: Axis.vertical,
//         physics: const BouncingScrollPhysics(),
//         controller: scrollController,
//         itemCount: products.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (BuildContext context, int index) {
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.to(() => CategoryProfile(
//                           pagename: products[index].get("name"),
//                           appbarname: name[index].tr,
//                         ));
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Image.network(
//                       products[index].get("image"),
//                       height: 150,
//                       width: 150,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 color: Colors.white,
//                 child: Text(
//                   catname[index].tr,
//                   style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "gilroy-bold"),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),