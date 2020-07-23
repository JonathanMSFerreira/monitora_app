import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:monitora_app/api/localizacao_api.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Location location = Location();

  LocationData _location;
  StreamSubscription<LocationData> _locationSubscription;
  String _error;




  Future<void> _listenLocation() async {
    _locationSubscription =
        location.onLocationChanged.handleError((dynamic err) {
          setState(() {
            _error = err.code;
          });
          _locationSubscription.cancel();
        }).listen((LocationData currentLocation) {
          setState(() {
            _error = null;

            _location = currentLocation;


            print(_location.latitude.toString());
            print(_location.longitude.toString());



             LocalizacaoApi.sendLocalizacao(   _location.latitude.toString(), _location.longitude.toString());






          });
        });
  }

  Future<void> _stopListen() async {
    _locationSubscription.cancel();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(),

        body: Center(
          child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
          Text(
            'Listen location: ' + (_error ?? '${_location ?? "unknown"}'),
            style: Theme.of(context).textTheme.body2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 42),
                child: RaisedButton(
                  child: const Text('Listen'),
                  onPressed: _listenLocation,
                ),
              ),
              RaisedButton(
                child: const Text('Stop'),
                onPressed: _stopListen,
              )
            ],
          ),
      ],
          ),
        )
    );
  }
}
