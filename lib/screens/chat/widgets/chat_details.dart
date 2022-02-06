import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:task_master/others/chat_message_model.dart';

class ChatDetails extends StatefulWidget {
  final String name;
  final String imageUrl;
  const ChatDetails({Key? key, required this.name, required this.imageUrl})
      : super(key: key);

  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          elevation: 0,
          // automaticallyImplyLeading: false,
          // backgroundColor: Colors.white,
          flexibleSpace: Row(
            children: <Widget>[
              const SizedBox(width: 50),
              CircleAvatar(
                backgroundImage: AssetImage(widget.imageUrl),
                maxRadius: 25,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Text(
                      "Online",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(EvaIcons.video),
              tooltip: 'Video call',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(EvaIcons.phone),
              tooltip: 'Voice call',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(EvaIcons.moreVertical),
              tooltip: 'More options',
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            // MESSAGE LIST SECTION
            SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 10, bottom: 75),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                      left: messages[index].messageType == "receiver" ? 14 : 60,
                      right:
                          messages[index].messageType == "receiver" ? 60 : 14,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.blueAccent
                                  : Colors.redAccent),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              messages[index].messageContent,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ),
                          Text(
                            DateTime.now().hour.toString() +
                                ":" +
                                DateTime.now()
                                    .minute
                                    .toString()
                                    .padLeft(2, "0"),
                            style: const TextStyle(color: Colors.black45),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // BOTTOM TEXT BOX
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                height: 60,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 15),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Icon(
                      EvaIcons.attach,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 6, bottom: 6),
                      child: IconButton(
                        onPressed: () {},
                        icon: Transform.rotate(
                          angle: -pi / 4,
                          child: const Icon(Icons.send, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
