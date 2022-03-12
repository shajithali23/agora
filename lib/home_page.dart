import 'package:agora_user/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _channelName = TextEditingController();
  final _userId = TextEditingController();
  final _receiverId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _userId,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "User Id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _receiverId,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Receiver Id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _channelName,
              decoration: InputDecoration(
                  hintText: "Channel Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                      borderSide: BorderSide(color: Colors.black))),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await [Permission.camera, Permission.microphone].request();
              var statusCamera = await Permission.camera.status;
              var statusMic = await Permission.microphone.status;

              debugPrint(
                "User Id ${_userId.text} , Receiver Id ${_receiverId.text} Channel Name ${_channelName.text}, Camera Status $statusCamera Microphone Status $statusMic",
              );
              if (statusCamera.isDenied || statusMic.isDenied) {
                debugPrint("Please enable camera or mic permission");
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoScreen(
                          user_id: _userId.text,
                          channel_name: _channelName.text,
                          receiver_id: _receiverId.text,
                        )));
              }
            },
            child: Text("JOIN"),
          ),
        ],
      ),
    );
  }
}
