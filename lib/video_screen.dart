import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              RemoteViewWidget(),
              LocalViewWidget(),
              ControlViewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ControlViewWidget extends StatelessWidget {
  const ControlViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 26),
        width: MediaQuery.of(context).size.width,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          RawMaterialButton(
            shape: CircleBorder(),
            elevation: 2,
            fillColor: Colors.blueGrey,
            onPressed: () {},
            child: Icon(Icons.mic),
          ),
          RawMaterialButton(
            shape: CircleBorder(),
            elevation: 2,
            fillColor: Colors.red,
            onPressed: () {
              Navigator.pop(context);
            },
            constraints: BoxConstraints(minWidth: 100.0, minHeight: 56.0),
            child: Icon(Icons.call),
          ),
          RawMaterialButton(
            shape: CircleBorder(),
            elevation: 2,
            fillColor: Colors.blueGrey,
            onPressed: () {},
            child: Icon(Icons.switch_camera),
          ),
        ]),
      ),
    );
  }
}

class LocalViewWidget extends StatelessWidget {
  const LocalViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.height / 4,
        color: Colors.black,
      ),
    );
  }
}

class RemoteViewWidget extends StatelessWidget {
  const RemoteViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.amber,
    );
  }
}
