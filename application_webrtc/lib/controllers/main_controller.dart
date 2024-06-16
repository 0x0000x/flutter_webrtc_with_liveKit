import '../core/app_export.dart';

class MainController extends GetxController {
  // instances
  final _firestoreRepo = FirestoreRepository.instance;
  Signaling signaling = Signaling();
  // vars
  final roomNameField = TextEditingController();
  final roomKey = GlobalKey<FormState>();
  final roomID = ''.obs;
  final rooms = RxList<RoomModel>();

  // RTCVideoRenderer localRenderer = RTCVideoRenderer();
  // RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  // state
  final isInProcess = false.obs;

  /// [createRoom] -- New Room
  Future<void> createRoom(String roomName) async {
    // cancel creation if the fields is empty
    if (roomKey.currentState?.validate() == false || isInProcess.isTrue) return;
    isInProcess.value = true;
    // إنشاء الغرفة
    await LiveKitAPI().connectToRoom(roomName);
    //  await  LiveKitAPI().roomInfo();

    // await _firestoreRepo.createRoom(
    //   room: RoomModel(
    //     // creatorID: yaUser.value?.$id,
    //     roomName: roomNameField.text,
    //   ),
    // );
    isInProcess.value = false;
    if (Get.isDialogOpen == true) {
      Get.back(closeOverlays: true);
    }
  }

  /// [streamListOfRooms] -- return a list of rooms
  Stream<List<RoomModel>> streamListOfRooms() =>
      _firestoreRepo.streamListOfRooms();

  @override
  void onInit() async {
    // localRenderer.initialize();
    // remoteRenderer.initialize();

    // signaling.onAddRemoteStream = ((stream) {
    //   remoteRenderer.srcObject = stream;
    //   update();
    // });

    // await signaling.openUserMedia(
    //   localRenderer,
    //   remoteRenderer,
    // );
    super.onInit();
  }

  @override
  void onReady() {
    rooms.bindStream(streamListOfRooms());

    rooms.listen((_) {
      update(['rooms-list']);
    });
    super.onReady();
  }

  // @override
  // void dispose() {
  //   localRenderer.dispose();
  //   remoteRenderer.dispose();
  // super.dispose();
  // }
}
