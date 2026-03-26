import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      itemBuilder: (context, index) {
        //list tile
        return ListTile(
          leading: CircleAvatar(radius: 25),
          title: Text('Sara Sanders'),
          subtitle: Text(
            'Hi..How are you?',
            style: TextStyle(color: theme.dividerColor),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '12:33',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
              //notification container
              Container(
                width: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.orangeAccent],
                    begin: AlignmentGeometry.bottomLeft,
                    end: AlignmentGeometry.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    '3',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(indent: 78, thickness: 0.1);
      },
      itemCount: 15,
    );
  }
}
