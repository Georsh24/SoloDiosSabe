import 'dart:io';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:flutter_stickers_internet/app/ui/global_controllers/session_controller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dio/dio.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/stickerPacks.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_meedu/router.dart' as router;

FirebaseFirestore firestore = FirebaseFirestore.instance;
String getuid = '';
String getidcompra = '';
String comprado = "init";

class MyStickerDetails extends StatefulWidget {
  final StickerPacks stickerPacks;
  MyStickerDetails({required this.stickerPacks}) : super();
  @override
  _MyStickerDetailsState createState() => _MyStickerDetailsState();
}

class _MyStickerDetailsState extends State<MyStickerDetails> {
  bool isLoading = true, isDownloading = true;
  List<String> downloadList = [];
  List<String> stickerImageList = [];
  static const MethodChannel stickerMethodChannel = const MethodChannel(
      'com.viztushar.flutter.flutter_stickers_internet/sharedata');

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      getCompras();
    });
  }

  @override
  Widget build(BuildContext context) {
    final logoimg = Theme.of(context).brightness == Brightness.dark
        ? 'assets/logoblack.png'
        : 'assets/logowhite.png';
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.15,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Colors.grey.shade400,
            size: size.width * 0.1,
          ),
          onPressed: () {
            router.pop();
          },
        ),
        centerTitle: true,
        title: Image.asset(
          '$logoimg',
          fit: BoxFit.contain,
          height: size.height * 0.09,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                stops: [
                  0.1,
                  0.80,
                ],
                colors: [
                  HexColor('00ff00'),
                  HexColor('05d0ae'),
                ]),
            border: Border(
                bottom: BorderSide(
                    width: 3, color: Colors.grey, style: BorderStyle.none)),
          ),
        ),
        elevation: 4,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Consumer(
              builder: (_, watch, __) {
                final user = watch(sessionProvider).user!;

                getuid = user.uid;
                getidcompra = widget.stickerPacks.identiFier;
                return SizedBox.shrink();
              },
            ),
            Flexible(
              flex: 5,
              child: Container(
                color: Colors.red,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                spreadRadius: -8),
                          ],
                          image: DecorationImage(
                            image:
                                NetworkImage(widget.stickerPacks.trayimagefile),
                            // image:
                            //     AssetImage('assets/Sticker7.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Text(
                      widget.stickerPacks.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 20,
              fit: FlexFit.tight,
              child: Container(
                color: Colors.yellow,
                child: GridView.builder(
                  shrinkWrap: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 8.0 / 9.0,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: widget.stickerPacks.sticker.length,
                  itemBuilder: (context, i) {
                    return Image.network(
                      widget.stickerPacks.sticker[i].imageFile,
                      height: 50.0,
                      width: 50.0,
                    );
                  },
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SizedBox.expand(
                      child: MaterialButton(
                        padding: EdgeInsets.all(15.0),
                        onPressed: () {
                          if (getCompras() == "comprado") {
                            if (!downloadList
                                .contains(widget.stickerPacks.identiFier)) {
                              isDownloading = false;
                              print(isLoading);
                              downloadSticker(widget.stickerPacks, context);
                            } else if (downloadList
                                .contains(widget.stickerPacks.identiFier)) {
                              addToWhatsapp(widget.stickerPacks);
                            }
                          } else {
                            print("Valor if");
                            print(comprado);
                            comprar(context);
                          }
                        },
                        color: Colors.black,
                        child: Text(
                          "I want it",

                          // 'Add to WhatsApp',
                          //  comprado == "comprado"
                          //     ? 'Comprado'
                          //     : "Por Favor Comprame",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addToWhatsapp(StickerPacks s) async {
    try {
      stickerMethodChannel.invokeMapMethod("addStickerPackToWhatsApp",
          {"identifier": s.identiFier, "name": s.name});
    } on PlatformException catch (e) {
      print(e.details);
    }
  }

  Future<void> downloadSticker(StickerPacks s, context) async {
    showDialogs(context);
    stickerImageList.clear();
    if (!downloadList.contains(s.identiFier)) {
      await Permission.storage.request();
      di.Dio dio = di.Dio();
      var dirToSave = await getApplicationDocumentsDirectory();
      var path = await Directory(dirToSave.path +
              "/" +
              "stickers_asset" +
              "/" +
              s.identiFier +
              "/")
          .create(recursive: true);
      var trypath = await Directory(dirToSave.path +
              "/" +
              "stickers_asset" +
              "/" +
              s.identiFier +
              "/try/")
          .create(recursive: true);
      print(path.path + "\n" + trypath.path);

      String tryFilePath = trypath.path + basename(s.trayImageFile);
      print(tryFilePath);
      await dio.download(s.trayImageFile, tryFilePath,
          onReceiveProgress: (rec, total) {
        print((rec / total) * 100);
        print("try image downloaded");
      });

      for (int i = 0; i < s.sticker.length; i++) {
        String imageFilePath = path.path + basename(s.sticker[i].imageFile);
        stickerImageList.add(basename(s.sticker[i].imageFile));
        await dio.download(s.sticker[i].imageFile, imageFilePath,
            onReceiveProgress: (rec, total) {
          print((rec / total) * 100);
        });
      }

      try {
        stickerMethodChannel.invokeMapMethod("addTOJson", {
          "identiFier": s.identiFier,
          "name": s.name,
          "publisher": s.publisher,
          "trayimagefile": basename(s.trayImageFile),
          "publisheremail": s.publisherEmail,
          "publisherwebsite": s.publisherWebsite,
          "privacypolicywebsite": s.privacyPolicyWebsite,
          "licenseagreementwebsite": s.licenseAgreementWebsite,
          "sticker_image": stickerImageList,
        });
      } on PlatformException catch (e) {
        print(e.details);
      }
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {
        isDownloading = true;
        if (!downloadList.contains(s.identiFier)) {
          downloadList.add(s.identiFier);
        }
      });
    } else {
      print("not");
    }
  }

  Future<void> showDialogs(context) {
    CupertinoAlertDialog s = CupertinoAlertDialog(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text("Downloading..."),
        ],
      ),
    );

    AlertDialog a = AlertDialog(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            width: 10,
          ),
          Text("Downloading..."),
        ],
      ),
    );

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        if (Platform.isAndroid)
          return a;
        else
          return s;
      },
    );
  }
}

void addUserr() {
  firestore
      .collection("Compras")
      .add({"Usuario": getuid, "StickerCompra": getidcompra}).then((value) {
    print(value.id);
  });
}

String getCompras() {
  firestore
      .collection("Compras")
      .where('Usuario', isEqualTo: getuid)
      .where('StickerCompra', isEqualTo: getidcompra)
      .get()
      .then(
    (querySnapshot) {
      comprado = "comprar";
      querySnapshot.docs.forEach(
        (result) {
          comprado = "comprado";
          print(result.data());
        },
      );
      print(getidcompra);
      print("Comprado:");
      print(comprado);
    },
  );

  return comprado;
}

void comprar(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Hola'),
          actions: [
            MaterialButton(
                child: Text('comprar'),
                onPressed: () {
                  addUserr();
                })
          ],
        );
      });
}

void descargar(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Hola'),
          actions: [MaterialButton(child: Text('Descargar'), onPressed: () {})],
        );
      });
}
