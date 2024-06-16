/*
  Room related models and methods
  

  Author: Amgad Fahd
*/

import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  final String? roomID;
  final String? roomName;
  final String? creatorID;
  final Timestamp? createdAt;

  const RoomModel({
    this.roomID,
    this.roomName,
    this.createdAt,
    this.creatorID,
  });

  /// [toDoc] -- store to firestore document
  Map<String, dynamic> toDoc() => {
        'roomID': roomID,
        'roomName': roomName,
        'creatorID': creatorID,
        'createdAt': Timestamp.now(),
      };

  /// [RoomModel.fromDoc] -- read from the room document in firestore
  factory RoomModel.fromDoc(Map<String, dynamic> doc) => RoomModel(
        roomID: doc['roomID'],
        roomName: doc['roomName'],
        creatorID: doc['creatorID'],
        createdAt: doc['createdAt'],
      );
}


