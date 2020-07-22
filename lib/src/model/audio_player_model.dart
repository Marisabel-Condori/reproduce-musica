import 'package:flutter/cupertino.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;
  AnimationController _controller;

  AnimationController get controller => this._controller;
  set controller(AnimationController valor){
    this._controller = valor;
  }
  
}