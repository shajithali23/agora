import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _channelName = TextEditingController();
  final _userId = TextEditingController();

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
            onPressed: () {
              debugPrint(
                  "User Id ${_userId.text} , Channel Name ${_channelName.text}");
            },
            child: Text("JOIN"),
          ),
        ],
      ),
    );
  }
}
