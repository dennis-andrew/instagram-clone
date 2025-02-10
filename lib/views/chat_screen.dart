import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        title:
            Text("_my_profile", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.note_alt_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ask Meta AI or search',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    8,
                    (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                "assets/images/insta_logo.png",
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "User ${index + 1}",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15,0),
              child: Row(
                children: [
                  Text(
                    "Messages",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Text(
                    "Requests",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage("assets/images/insta_logo.png"),
                      ),
                      title: Text("User ${index + 1}"),
                      subtitle: Text("Hey, how's it going?"),
                      trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            size: 35,
                          )),
                      onTap: () {
                      },
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
