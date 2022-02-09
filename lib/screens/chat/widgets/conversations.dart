import 'package:flutter/material.dart';
import 'package:task_master/others/chat_users_model.dart';
import 'package:task_master/screens/chat/widgets/chat_details.dart';
import 'package:task_master/screens/profile_screen.dart';

class Conversations extends StatefulWidget {
  const Conversations({Key? key}) : super(key: key);

  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header UI
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Text(
              "Messages",
              style: TextStyle(fontSize: 52, fontWeight: FontWeight.bold),
            ),
          ),
          // Search bar
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade300,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                ),
              ),
            ),
          ),
          //conversation list view
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: chatUsers.length,
              padding: const EdgeInsets.only(top: 20, bottom: 80),
              itemBuilder: (context, index) {
                return ConversationList(
                  user: chatUsers[index],
                  isMessageRead: (index % 3 == 0) ? true : false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationList extends StatefulWidget {
  final ChatUsers user;
  final bool isMessageRead;
  const ConversationList({
    Key? key,
    required this.isMessageRead,
    required this.user,
  }) : super(key: key);
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatDetails(user: widget.user))),
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(user: widget.user),
            ),
          );
        },
        child: Stack(
          children: [
            CircleAvatar(
                backgroundImage: AssetImage(widget.user.imageURL),
                maxRadius: 35),
            if (widget.isMessageRead == false)
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
      title: Text(
        widget.user.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        widget.user.messageText,
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight:
                widget.isMessageRead ? FontWeight.bold : FontWeight.normal),
      ),
      trailing: Text(
        widget.user.time,
        style: TextStyle(
            fontSize: 12,
            fontWeight:
                widget.isMessageRead ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
