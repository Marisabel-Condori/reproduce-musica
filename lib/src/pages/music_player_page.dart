import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpel/helpers.dart';
import 'package:music_player/src/model/audio_player_model.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Background(),
            Column(
              children: [
                CustomAppBarWidget(),
                _ImagenDiscoDuracion(),
                _TituloPlay(),
                Expanded(child: Lyrics()),
              ],
            ),
          ],
        ),
      )
    );
  }
}

class Background extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height *0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28)
          ]
        )
      ),
    );
  }
}

class Lyrics extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return Container(
      child: ListWheelScrollView(
        itemExtent: 42, 
        diameterRatio: 1.5,
        children: lyrics.map(
          (linea) => Text(linea, style: TextStyle(fontSize: 20.0, color: Colors.white.withOpacity(0.8)),)).toList()
      ),
    );
  }
}

class _TituloPlay extends StatefulWidget {

  @override
  __TituloPlayState createState() => __TituloPlayState();
}

class __TituloPlayState extends State<_TituloPlay> with SingleTickerProviderStateMixin{
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController playAnimation;
  final assetAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() { 
    playAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }
  @override
  void dispose() {
    playAnimation.dispose();
    super.dispose();
  }

  void open(){
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'));
    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playinAudio) {
      audioPlayerModel.songDuration = playinAudio.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('Far Away', style: TextStyle(fontSize: 30.0, color: Colors.white.withOpacity(0.8)),),
              Text('-Breaking Benjamin-', style: TextStyle(fontSize: 15.0, color: Colors.white.withOpacity(0.5)),)
            ],
          ),
          FloatingActionButton(
            backgroundColor: Color(0xffF8CB58),
            elevation: 0,
            highlightElevation: 0,
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause, 
              progress: playAnimation),
            onPressed: (){
              final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);
              if (this.isPlaying) {
                playAnimation.reverse();
                this.isPlaying = false;
                audioPlayerModel.controller.stop();
              }else{
                playAnimation.forward();
                this.isPlaying = true;
                audioPlayerModel.controller.reverse();
              }

              if (firstTime) {
                this.open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            }
          )
        ],
      ),
    );
  }
}

class _ImagenDiscoDuracion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _ImagenDisco(),
        _BarraProgreso(),
      ],
    );
  }
}

class _BarraProgreso extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;
    return Container(
      child: Column(
        children: [
          Text('00:00'),
          SizedBox(height: 10.0,),
          Stack(
            children: [
              Container(
                width: 3.0, height: 250.0,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3.0, height: 150.0*porcentaje,
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0,),
          Text('${audioPlayerModel.songDuration}')
        ],
      ),
    );
  }
}

class _ImagenDisco extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    return Container(
      padding: EdgeInsets.all(20.0),
      width: 250.0, height: 250.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
              duration: Duration(seconds: 2),
              infinite: false,
              manualTrigger: true,
              controller: (animationController) => audioPlayerModel.controller = animationController,
              child: Image(image: AssetImage('assets/aurora.jpg'))
            ),
            Container(
              width: 25.0, height: 25.0,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(25.0)
              ),
            ),
            Container(
              width: 18.0, height: 18.0,
              decoration: BoxDecoration(
                color: Color(0xff1C1C25),
                borderRadius: BorderRadius.circular(25.0)
              ),
            )
          ],
        )
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        gradient: LinearGradient(
          colors: [
            Color(0xff484750),
            Color(0xff1E1C24)
          ]
        )
      ),
    );
  }
}