import 'package:tazewallpaper/constants/packages.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context),
      drawer: drawer(context),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("wallpaper").snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Lottie.asset("asset/animations/1.json", height: 100, reverse: true, repeat: true, fit: BoxFit.cover),
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CategoryProfile(
                                pagename: snapshot.data.docs[index]['name'],
                                appbarname: Get.locale.languageCode == 'en'
                                    ? snapshot.data.docs[index]["nameen"]
                                    : Get.locale.languageCode == 'ru'
                                        ? snapshot.data.docs[index]["nameru"]
                                        : snapshot.data.docs[index]["nametm"],
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
                          margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Opacity(
                                opacity: 0.7,
                                child: Image.network(
                                  snapshot.data.docs[index]["image"],
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Text(
                            Get.locale.languageCode == 'en'
                                ? snapshot.data.docs[index]["nameen"]
                                : Get.locale.languageCode == 'ru'
                                    ? snapshot.data.docs[index]["nameru"]
                                    : snapshot.data.docs[index]["nametm"],
                            style: const TextStyle(color: Colors.white, fontSize: 50, fontFamily: "gilroy-bold", fontWeight: FontWeight.bold),
                          ),
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

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return RatingDialog(
              title: const Text('Rating'),
              message: const Text('Tap a star to set your rating'),
              image: Image.asset('asset/image/Nature/1.jpg'),
              submitButtonText: 'Submit',
              onSubmitted: (response) {
                print("Rating is ${response.rating},Comment is ${(response.comment)}");
                if (response.rating < 3.0) {
                  print("response.rating:${response.rating}");
                } else {
                  Container();
                }
              });
        },
        barrierDismissible: true);
  }

  AppBar appbar(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black, fontSize: 30.0, fontFamily: "gilroy-bold"),
      ),
      actions: [
        PopupMenuButton(
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: const Text("English"),
                onTap: () {
                  controller.changeLocalSettings('en');
                },
              ),
              PopupMenuItem(
                child: const Text("Russian"),
                onTap: () {
                  controller.changeLocalSettings('ru');
                },
              ),
              PopupMenuItem(
                child: const Text("Turkmen"),
                onTap: () {
                  controller.changeLocalSettings('tm');
                },
              ),
            ];
          },
        )
      ],
      centerTitle: true,
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      DrawerHeader(
        child: Stack(
          children: [
            SizedBox(
                width: 160,
                height: 400,
                child: Image.asset(
                  'asset/logo/wallpaperlogo.png',
                  fit: BoxFit.cover,
                )),
            Positioned(
              bottom: 20,
              left: 112,
              child: Container(
                  child: const Text(
                "ALLPAPER",
                style: TextStyle(color: Colors.black, fontSize: 30, letterSpacing: 1),
              )),
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(() => Latest(
                appbarname: drawername[1].tr,
                pagename: "latest",
              ));
        },
        child: Drawerbutton(
          text: drawername[1].tr,
          icon: IconlyLight.folder,
        ),
      ),
      GestureDetector(
        child: Drawerbutton(text: drawername[2].tr, icon: IconlyLight.category),
        onTap: () {
          Get.to(() => CategoryDrawer(
                appbarname: drawername[2].tr,
                pagename: "wallpaper",
              ));
        },
      ),
      GestureDetector(
        child: Drawerbutton(text: drawername[4].tr, icon: IconlyLight.star),
        onTap: () {},
      ),
      GestureDetector(
        child: Drawerbutton(text: drawername[5].tr, icon: IconlyBold.message),
        onTap: () {
          Get.to(() => const AboutChecking());
        },
      )
    ]));
  }
}
