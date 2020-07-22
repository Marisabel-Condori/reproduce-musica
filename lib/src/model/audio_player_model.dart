import 'package:flutter/cupertino.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;
  AnimationController _controller;
  Duration _songDuration = Duration(milliseconds: 0);
  Duration _current = Duration(milliseconds: 0);
  

  String get songTotalDuration => this.printDuration(this._songDuration);
  String get currentSecond     => this.printDuration(this._current);
  double get porcentaje        => (this._songDuration.inSeconds > 0)
                ?  this._current.inSeconds / this._songDuration.inSeconds
                : 0;
  bool get playing => this._playing;
  set playing (valor){
    this._playing = valor;
    notifyListeners();
  }


  
  AnimationController get controller => this._controller;
  set controller(AnimationController valor){
    this._controller = valor;
  }

  Duration get songDuration => this._songDuration;
  set songDuration(Duration valor){
    this._songDuration = valor;
    notifyListeners();
  }

  Duration get current => this._current;
  set current(Duration valor){
    this._current = valor;
    notifyListeners();
  }

  String printDuration(Duration duration){
    String twoDigits(int n){
      if(n >= 10) return "$n";
      return "0$n";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
  
}