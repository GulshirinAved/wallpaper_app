import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';

enum SetWallpaperas { Home, Lock, Both }
final _setAs = {
  SetWallpaperas.Home: WallpaperManager.HOME_SCREEN,
  SetWallpaperas.Lock: WallpaperManager.LOCK_SCREEN,
  SetWallpaperas.Both: WallpaperManager.BOTH_SCREEN,
};

class ImageProfile extends StatefulWidget {
  final String imageUrl;
  final String pagename;

  const ImageProfile({Key key, this.pagename, this.imageUrl}) : super(key: key);

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Center(
                  child: Icon(
                Icons.photo,
                color: Colors.black,
              )),
              backgroundColor: Colors.white,
              onPressed: () async {
                SetWallpaperas option = await showBottomSheet(context);
                if (option != null) {
                  try {
                    String url = widget.imageUrl;
                    var file = await DefaultCacheManager().getSingleFile(url);
                    int location = _setAs[option]; //can be Home/Lock Screen
                    bool result = await WallpaperManager.setWallpaperFromFile(file.path, location);
                    print(result);
                  } on PlatformException {}
                }
              })),
    );
  }
}

bildiris() {
  Get.rawSnackbar(
      borderRadius: 15,
      backgroundColor: Colors.white,
      messageText: Center(
        child: Text(
          "Oboi".tr,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "gilroy-bold"),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM);
}

Future showBottomSheet(BuildContext context) => showModalBottomSheet(
      enableDrag: false,
      isDismissible: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  "Setas".tr,
                  style: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.back(result: SetWallpaperas.Home);
                  bildiris();
                },
                title: Text(
                  "HomeScreen".tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.back(result: SetWallpaperas.Lock);
                  bildiris();
                },
                title: Text(
                  "LockScreen".tr,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              ListTile(
                onTap: () {
                  Get.back(result: SetWallpaperas.Both);
                  bildiris();
                },
                title: Text(
                  "Both".tr,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              )
            ],
          ),
        );
      },
    );
