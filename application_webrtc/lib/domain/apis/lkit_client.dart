/* 

  
  Author: Amgad Fahd
  2024
*/

import 'package:livekit_client/livekit_client.dart';

import '../../core/app_export.dart';

/// [HelperKit] - Will help with fetching || saving || loading -> the user token
class HelperKit extends GetxController {
  // instances
  final _connector = _Connector();

  /// [requestAccessToken] -- Request access token
  // Future<void> requestAccessToken() async {
  //   final shP = await SharedPreferences.getInstance();
  //   // -- Check if we already have a token stored
  //   // -- If not = we're going to create a new one
  //   if (!shP.containsKey(accessToken)) {
  //     // -- Get a token
  //     // final t = await _connector.newRoom();
  //     // -- Assign the token to the userToken rxtype
  //     // userToken.value = t.body;
  //     // -- Save the token to the app's storage
  //     await shP.setString(accessToken, userToken.value);

  //     Logger.debugPrint('User Token saved to app storage');
  //     return;
  //   }

  //   // -- Load User Token

  //   final t = shP.getString(accessToken);
  //   // -- Assign the token to the userToken rxtype
  //   userToken.value = t ?? '';
  //   Logger.debugPrint('User Token $t');
  // }

  @override
  void onInit() async {
    Logger.debugPrint('Helper kit started');
    // await requestAccessToken();
    super.onInit();
  }
}

class LiveKitAPI {
  static LiveKitAPI get instance => Get.find();

  final room = Room(
    roomOptions:  RoomOptions(
      adaptiveStream: true,
      dynacast: true,
      // ... your room options
    ),
  );

  /// [connectToRoom] -- esablish a connection with the room
  Future<void> connectToRoom(String roomName) async {
    try {
      // room.list
      // final t = await _Connector().newRoom();
      // -- Connect to the room
      await room.connect(
        lkProjectURL,
        token,
      );

      // room.createListener();

      // await room.disconnect();
      // room.events.listen((p0) => null)
      Logger.debugPrint(room.connectionState.name);

      // Room().
      // video will fail when running in ios simulator
      // await room.localParticipant.setCameraEnabled(true);
    } catch (e) {
      Logger.debugPrintError('Could not Start voice call, error: $e');
    }

// await room.localParticipant.setMicrophoneEnabled(true);
  }

  /// [roomInfo] --  Get room info
  Future roomInfo() async {
    Logger.debugPrint('Getting Room Info');
    Logger.debugPrint(room.name ?? '1');
  }
}

/// [_Connector] - This class is responsable for communicating with our server
class _Connector extends GetConnect {
  /// [newRoom] -- create a new room and return a token
  Future<Response> newRoom() async {
    final response = await get('$serverURL/newRoom');

    // -- 200 indicates connection was successful
    if (response.statusCode == 200) {
      Logger.debugPrint('Successfully-> new User Token was fetched');
      Logger.debugPrint('Token ${response.body}');
    }
    // -- if an error occured
    if (response.hasError) {
      Logger.debugPrintError('Error-> failed to fetch new user token');
    }

    return response;
  }
}
