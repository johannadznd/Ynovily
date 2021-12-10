import 'package:flutter/material.dart';
import 'music.dart';
import 'package:just_audio/just_audio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Ynovify';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<Music> myMusicList = [
    Music('Highway to Hell', 'ACDC', 'assets/images/Box.jpg',
        'https://music.florian-berthier.com/highway_to_hell.mp3'),
    Music('Heat waves', 'Glass animals', 'assets/images/heatWaves.jpg',
        'https://music.florian-berthier.com/heat_waves.mp3'),
    Music('L\'odeur de l\'essence', 'OrelSan', 'assets/images/essence.jpg',
        'https://music.florian-berthier.com/lodeur_de_lessence.mp3')
  ];

  int index = 0;
  bool selected = false;

  String duration = "";

  final _player = AudioPlayer();

  void incrementation() {
    setState(() {
      if (index >= myMusicList.length - 1) {
        index = 0;
      } else {
        index++;
      }
    });
    _init(index);
  }

  void decrementation() {
    setState(() {
      if (index < 1) {
        index = myMusicList.length - 1;
      } else {
        index--;
      }
    });
    _init(index);
  }

  @override
  void initState() {
    super.initState();
    _init(index);
  }

  Future<void> _init(int index) async {
    await _player
        .setAudioSource(AudioSource.uri(Uri.parse(myMusicList[index].urlSong)));

    duration = "${_player.duration!.inMinutes}:${_player.duration!.inSeconds % 60}";

    setState(() {
      duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: const Center(
            child: Text(
              'YNOVIFY',
              style: TextStyle(fontSize: 30),
            ),
          )),
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(30),
          child: Image.asset(
            myMusicList[index].imagePath,
            width: 400,
          ),
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(5),
            child: Text(
              myMusicList[index].title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 35, color: Colors.white),
            )),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child: Text(
              myMusicList[index].singer,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            )),
        Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  child: const Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    decrementation();
                  }),
              TextButton(
                child: Icon(
                  selected ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    selected = !selected;
                    if (selected) {
                      _player.play();
                    } else {
                      _player.pause();
                    }
                  });
                },
              ),
              TextButton(
                  child: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    incrementation();
                  }),
            ],
          ),
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child: Text(
              'Durée : $duration',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ))
      ]),
      backgroundColor: Colors.blueGrey[800],
    );
  }
}
