import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Body extends StatefulWidget {
  Body({Key key, this.theme}) : super(key: key);

  final ThemeData theme;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedIndex = 0;
  bool isEmpty = false;
  var songsMap = Map<String, dynamic>();
  AudioPlayer audioPlayer = AudioPlayer();
  var cloudStore = FirebaseFirestore.instance.collection("songs");

  void play(String path) async {
    var durataion = audioPlayer.setFilePath("$path");
    audioPlayer.play();
  }

  Future<String> get _externalPath async {
    final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  String _cleanURL(String fullURL) {
    String res;
    if (fullURL.contains('https://www.youtube.com/watch?v=')) {
      res = fullURL.replaceAll('https://www.youtube.com/watch?v=', '');
    } else if (fullURL.contains('https://m.youtube.com/watch?v=')) {
      res = fullURL.replaceAll('https://m.youtube.com/watch?v=', '');
    } else if (fullURL.contains('https://youtu.be/')) {
      res = fullURL.replaceAll('https://youtu.be/', '');
    } else if (fullURL.length == 11) {
      res = fullURL;
    } else {
      res = 'Unable URL';
    }
    return res;
  }

  Future<void> downloadMP3(String url, String path) async {
    var yt = YoutubeExplode();
    var vid = _cleanURL(url);
    var manifest = await yt.videos.streamsClient.getManifest('$vid');
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    var size = streamInfo.size;
    writeStream(streamInfo, '$path');
    print("다운로드 완료");
  }

  Future<void> writeStream(var streamInfo, String path) async {
    if (streamInfo != null) {
      var yt = YoutubeExplode();
      var stream = yt.videos.streamsClient.get(streamInfo);
      var file = File('$path');
      var fileStream = file.openWrite();
      await stream.pipe(fileStream);
      await fileStream.flush();
      await fileStream.close();
    }
  }

  Future<void> getData() {
    for (int i = 0; i < 10; i++) {
      print("${songsMap[i]}");
    }
  }

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      var songMap = Map<String, dynamic>();
      cloudStore.doc("song$i").get().then((doc) {
        songMap = doc.data();
        songsMap['$i'] = songMap;
        setState(() {
          isEmpty = true;
        });
      }).catchError((error) => print(error));
    }
    super.initState();
    // print(songsMap);
  }

  @override
  Widget build(BuildContext context) {
    var theme = widget.theme;
    // cloudStore = widget.store;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              "내 취향인 가수의 노래",
              style: theme.textTheme.headline3,
            ),
          ),
          TasteCategories(
            cartegoriesMap: songsMap,
          ),
          TextButton(
            child: Text("youtube url 재생"),
            onPressed: () {
              if (audioPlayer.playing == true) {
                audioPlayer.pause();
              } else {
                audioPlayer.play();
              }
            },
          ),
          TextButton(
            child: Text("cloud store test"),
            onPressed: () => getData(),
          ),
          TextButton(
            child: Text("downlaod music"),
            onPressed: () async {
              var path = "${await _externalPath}/filename.m4a";
              downloadMP3("https://youtu.be/Tch_MpMRu_g", path);
              play(path);
            },
          ),
        ],
      ),
      // bottomNavigationBar: buildBottomNavigationBar(),
    );
    ;
  }

  // BottomNavigationBar buildBottomNavigationBar() {
  //   return BottomNavigationBar(
  //       onTap: (value) {
  //         setState(() {
  //           selectedIndex = value;
  //         });
  //       },
  //       type: BottomNavigationBarType.fixed,
  //       currentIndex: selectedIndex,
  //       items: [
  //         BottomNavigationBarItem(icon: Icon(Icons.error), label: "h"),
  //         BottomNavigationBarItem(icon: Icon(Icons.error), label: "h"),
  //         BottomNavigationBarItem(icon: Icon(Icons.error), label: "h"),
  //       ]);
  // }
}

class TasteCategories extends StatefulWidget {
  TasteCategories({Key key, this.cartegoriesMap}) : super(key: key);

  Map<String, dynamic> cartegoriesMap;

  @override
  _TasteCategoriesState createState() => _TasteCategoriesState();
}

class _TasteCategoriesState extends State<TasteCategories> {
  List<String> cartegoriesList = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    var fwidth = media.size.width;
    var fheight = media.size.height;

    if (0 < cartegoriesList.length) {
      for (var i = 0; i < widget.cartegoriesMap.length; i++) {
        cartegoriesList.removeAt(0);
      }
    }

    for (var i = 0; i < widget.cartegoriesMap.length; i++) {
      cartegoriesList.add(widget.cartegoriesMap['$i']['title']);
    }

    return ListTile(
      title: Padding(
        padding: EdgeInsets.all(5),
        child: SizedBox(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cartegoriesList.length,
              itemBuilder: (context, index) =>
                  buildCategory(index, fwidth, fheight)),
        ),
      ),
      onTap: () {},
    );
  }

  Widget buildCategory(int index, var width, var height) {
    return Container(
      color: Colors.green,
      width: 250,
      height: 250,
      child: Column(
        children: [
          Container(
              color: Colors.red,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              width: width * 0.5,
              height: height * 0.2,
              child: TextButton(
                onPressed: () {},
                child: Image.asset("assets/images/RandomPlayIcon-nobg.png"),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
            child: Text(
              cartegoriesList[index],
              maxLines: 2,
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
