import 'package:flutter/material.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';

class MusicPlayerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarWidget(),
            _ImagenDiscoDuracion(),
            _TituloPlay()
          ],
        ),
      )
    );
  }
}

class _TituloPlay extends StatelessWidget {

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
            child: Icon(Icons.play_arrow),
            onPressed: (){}
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
  const _BarraProgreso({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  width: 3.0, height: 150.0,
                  color: Colors.white.withOpacity(0.8),
                ),
              )
            ],
          ),
          SizedBox(height: 10.0,),
          Text('00:00')
        ],
      ),
    );
  }
}

class _ImagenDisco extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: 250.0, height: 250.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(image: AssetImage('assets/aurora.jpg')),
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