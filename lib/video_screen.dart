import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';

const APP_ID = 'ce2f97e3020246f9a8b7597848c494a4';
const Token =
    '006ce2f97e3020246f9a8b7597848c494a4IABgv/p/HhbSxQvLx5tUEVWlTwdAKE8IyFh6Iqdsll9DbAx+f9gAAAAAEAAJCiqYurQtYgEAAQC4tC1i';

class VideoScreen extends StatefulWidget {
  String user_id;
  String receiver_id;
  String channel_name;
  VideoScreen(
      {Key? key,
      required this.user_id,
      required this.channel_name,
      required this.receiver_id})
      : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  bool _joined = false;
  bool _switch = false;
  int _remoteUid = 0;
  late RtcEngine engine;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // Create RTC client instance
//RtcEngineContext context = RtcEngineContext(APP_ID);
    // var engine = await RtcEngine.createWithContext(context);
    RtcEngineContext context = RtcEngineContext(APP_ID);
    engine = await RtcEngine.createWithContext(context);

    // await engine.enableVideo();
    // await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    // await engine.setClientRole(ClientRole.Broadcaster);

    // Define event handling logic
    engine.setEventHandler(
        RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
      print('joinChannelSuccess ${channel} ${uid}');
      setState(() {
        _joined = true;
        _remoteUid = uid;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      print('userJoined 1 ${widget.user_id}');
      print('userJoined 1 ${widget.receiver_id}');
      setState(() {
        // _remoteUid = int.parse(widget.user_id);
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Enable video
    await engine.enableVideo();
    // Join channel with channel name as 123debug()
    debugPrint("!@#56dyd");
    debugPrint(Token);
    debugPrint(widget.channel_name);
    debugPrint(widget.user_id);
    try {
      await engine.joinChannel(
          Token, widget.channel_name, null, int.parse(widget.user_id));
    } catch (e) {
      print("error with agora = ");
      print("$e");
      print("error printeddddd");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _remoteUid = 0;
    engine.leaveChannel();
    engine.destroy();

    debugPrint("DIS");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.amber,
                child: _remoteUid != 0
                    ? RtcRemoteView.SurfaceView(
                        uid: int.parse(widget.receiver_id),
                        channelId: widget.channel_name,
                      )
                    : Center(
                        child: CircularProgressIndicator(color: Colors.green)),
              ),
              LocalViewWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 26),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          constraints:
                              BoxConstraints(minWidth: 100.0, minHeight: 56.0),
                          child: Icon(Icons.call),
                        ),
                        RawMaterialButton(
                          shape: CircleBorder(),
                          elevation: 2,
                          fillColor: Colors.blueGrey,
                          onPressed: () {
                            engine.switchCamera();
                          },
                          child: Icon(Icons.switch_camera),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
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
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 4,
        color: Colors.black,
        child: RtcLocalView.SurfaceView(),
      ),
    );
  }
}
