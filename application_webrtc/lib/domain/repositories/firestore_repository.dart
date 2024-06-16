import 'package:application_webrtc/configs/config.dart';
import 'package:application_webrtc/domain/models/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';

import '../../core/logger.dart';

class FirestoreRepository extends GetxController {
  static FirestoreRepository get instance => Get.find();

  /// instances
  final _db = FirebaseFirestore.instance;


  /// [streamListOfRooms] -- return List of rooms
  Stream<List<RoomModel>>  streamListOfRooms() {
    try {
      return _db.collection(roomsCollection).snapshots().map((docs) {
        List<RoomModel> rooms = [];
        for (final doc in docs.docs) {
          final r = RoomModel.fromDoc(doc.data());
          rooms.add(r);
        }
        return rooms;
      });
    } catch (e) {
      Logger.debugPrintError('Error: FirestoreRepository.streamListOfRooms -> $e');
      return Stream.error(e);
    }
  }

  /// [createRoom] -- إنشاء غرفة جديدة
  Future<String> createRoom({required RoomModel room}) async {
    try {
      final roomRef = _db.collection(roomsCollection).doc();
      Logger.debugPrint('New Room: ${room.toDoc()}');

      // انشاء الغرفة
      await roomRef.set(room.toDoc());

      // تحديث معرف الغرفة
      await roomRef.update({
        'roomID': roomRef.id,
      });
      return roomRef.id;
    } catch (e) {
      final _ = 'Error occured:createRoom -> failed to create room \n$e';
      Logger.debugPrintError(_);
      return Future.error(_);
    }
  }
 
  /// [addSdpOfferAnswer] -- Add SDP (Offer and Answer)
  Future<void> addSdpOfferAnswer(
      String roomId, String userId, String offer, String answer) async {
    await FirebaseFirestore.instance
        .collection(signalingDataCollection)
        .doc(roomId)
        .collection(membersCollection)
        .doc(userId)
        .set({
      'offer': offer,
      'answer': answer,
    });
  }

  /// [addIceCandidate] Add ICE candidate
  Future<void> addIceCandidate(
    String roomId,
    String userId,
    RTCIceCandidate candidate,
  ) async {
    await FirebaseFirestore.instance
        .collection(signalingDataCollection)
        .doc(roomId)
        .collection(membersCollection)
        .doc(userId)
        .collection(iceCandidatesCollection)
        .doc()
        .set(candidate.toMap());
  }

  /// [joinRoom] -- Join selected room
  Future<void> joinRoom(String roomID) async {}

  /// [exitRoom] -- Exit the current room
  Future<void> exitRoom(String roomID) async {
    var roomRef = _db.collection(roomsCollection).doc(roomID);
    var calleeCandidates = await roomRef.collection('calleeCandidates').get();
    calleeCandidates.docs.forEach((document) => document.reference.delete());

    var callerCandidates = await roomRef.collection('callerCandidates').get();
    callerCandidates.docs.forEach((document) => document.reference.delete());

    await roomRef.delete();
  }
}
