// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

Widget buildTaskItem() => Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('8:00pm'),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Text('go to gem',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Text('jan 20 ,2024'),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.check_box)),
          IconButton(onPressed: () {}, icon: Icon(Icons.archive)),
        ],
      ),
    );
