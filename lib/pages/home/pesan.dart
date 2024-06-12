import 'package:digisehat/component.dart';
import 'package:digisehat/helpers.dart';
import 'package:digisehat/theme.dart';
import 'package:flutter/material.dart';

class PesanPage extends StatefulWidget {
  const PesanPage({super.key});

  @override
  State<PesanPage> createState() => _PesanPageState();
}

class _PesanPageState extends State<PesanPage> {
  List<Message> messages = [
    Message(
      senderName: 'Defrizal',
      text:
          'Selamat pagi, Dokter Hanif. Saya adalah Defrizal. Saya ingin meminta bantuan Anda terkait masalah penglihatan yang saya alami.',
      messageType: MessageType.received,
    ),
    Message(
      senderName: 'Dr. Ahmad Hanif',
      text:
          'Selamat pagi, Defrizal. Tentu, saya senang bisa membantu Anda. Silakan jelaskan apa yang Anda rasakan?',
      messageType: MessageType.sent,
    ),
  ];

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: lightColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('assets/ijay.png'),
            ),
            const SizedBox(width: 10),
            Text('Dr. Ahmad Hanif',
                style: lightTextStyle.copyWith(fontSize: 17, fontWeight: bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone, color: lightColor),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.videocam, color: lightColor),
            onPressed: () {},
          ),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: inputColor,
        elevation: 0,
      ),
      body: Container(
        child: Stack(
          children: [
            buildBackground(gradientHomeBoxDecoration),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ChatMessageWidget(message: message);
                },
              ),
            ),
            Positioned(
              top: 16,
              left: 135,
              right: 135,
              child: DateBadgeWidget(date: '20 Februari 2024'),
            ),
            Positioned(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: "Tulis pesan...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: lightColor,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: lightColor,
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            // redirectTo(context, "/input-diagnosa-pasien");
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Icon(
                            Icons.send,
                            color: lightColor,
                          ),
                          backgroundColor: orangeColor,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MessageType { sent, received }

class Message {
  String senderName;
  String text;
  MessageType messageType;

  Message({
    required this.senderName,
    required this.text,
    required this.messageType,
  });
}

class ChatMessageWidget extends StatelessWidget {
  final Message message;

  const ChatMessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSent = message.messageType == MessageType.sent;
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
            top: 10,
            left: isSent ? 10 : 40,
            right: isSent ? 40 : 10,
            bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSent ? primaryColor : inputColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.senderName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: lightColor,
              ),
            ),
            Text(
              message.text,
              style: TextStyle(
                color: lightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateBadgeWidget extends StatelessWidget {
  final String date;

  const DateBadgeWidget({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: darkPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        date,
        style: TextStyle(
          color: lightColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
