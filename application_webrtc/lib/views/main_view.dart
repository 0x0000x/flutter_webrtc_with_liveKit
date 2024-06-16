import '../core/app_export.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  // @override
  // void initState() {
  //   _localRenderer.initialize();
  //   _remoteRenderer.initialize();

  //   signaling.onAddRemoteStream = ((stream) {
  //     _remoteRenderer.srcObject = stream;
  //     setState(() {});
  //   });

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _localRenderer.dispose();
  //   _remoteRenderer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appName,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber.shade400,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         signaling.openUserMedia(_localRenderer, _remoteRenderer);
          //       },
          //       child: Text("Open camera & microphone"),
          //     ),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     ElevatedButton(
          //       onPressed: () async {
          //         roomId = await signaling.createRoom(_remoteRenderer);
          //         textEditingController.text = roomId!;
          //         setState(() {});
          //       },
          //       child: Text("Create room"),
          //     ),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         // Add roomId
          //         signaling.joinRoom(
          //           textEditingController.text.trim(),
          //           _remoteRenderer,
          //         );
          //       },
          //       child: Text("Join room"),
          //     ),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         signaling.hangUp(_localRenderer);
          //       },
          //       child: Text("Hangup"),
          //     )
          //   ],
          // ),

          // Title text
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Available Rooms '),
              ],
            ),
          ),
          // Rooms List View
          // GetBuilder<MainController>(
          //   id: 'rooms-list',
          //   builder: (listController) => ListView.builder(
          //     shrinkWrap: true,
          //     padding: const EdgeInsets.all(7),
          //     itemCount: controller.rooms.length,
          //     itemBuilder: (context, index) => Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: RoomCardWidget(
          //         // onJoin: () async {

          //         //   await listController.signaling.openUserMedia(
          //         //     listController.localRenderer,
          //         //     listController.remoteRenderer,
          //         //   );
          //         //   await listController.signaling.joinRoom(
          //         //     listController.rooms[index].roomID ?? '',
          //         //     listController.remoteRenderer,
          //         //   );
          //         // },
          //         creatorID: controller.rooms[index].creatorID ?? '',
          //         roomID: controller.rooms[index].roomID ?? '',
          //         roomName: controller.rooms[index].roomName ?? '',
          //       ),
          //     ),
          //   ),
          // ),
          // // ,

          const SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'اكتب اسم الغرفة',
                  ),
                  controller: controller.roomNameField,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // await controller.signaling.openUserMedia(
                        //   controller.localRenderer,
                        //   controller.remoteRenderer,
                        // );
                        // _openSheet();
                        await controller.createRoom(
                          'تجريبيه',
                        );
                      },
                      child: Text('دخول الغرفة'),
                    ),
                    // ElevatedButton(
                    //   onPressed: () async {
                        //  await LiveKitAPI().connectToRoom('');
                        // await controller.signaling.openUserMedia(
                        //   controller.localRenderer,
                        //   controller.remoteRenderer,
                        // );
                        // controller.roomID.value =
                        //     await controller.signaling.createRoom(
                        //   controller.remoteRenderer,
                        // );

                        // controller.roomNameField.text = controller.roomID.value;
                        // controller.update();
                        // _openSheet();
                    //   },
                    //   child: Text('Create Room'),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
          //         Expanded(child: RTCVideoView(_remoteRenderer)),
          //       ],
          //     ),
          //   ),
          // ),

          SizedBox(height: 8)
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     await Get.dialog(
      //       _buildCreateRoomDialog(),
      //       barrierColor: Colors.transparent,
      //     );
      //   },
      //   child: const Icon(
      //     Icons.add_circle_outline_outlined,
      //   ),
      // ),
    );
  }

  void _openSheet() {
    Get.bottomSheet(
      Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Get.theme.cardColor,
        ),
        child: Column(
          children: [
            // CloseButton(),
            SizedBox(
              height: 20,
            ),
            IconButton.filled(
              onPressed: () async {
               
                // await controller.signaling.hangUp(controller.localRenderer);
                if (Get.isOverlaysOpen == true) {
                  Get.back(closeOverlays: true);
                }
              },
              // color:Colors.red ,
              style: IconButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              icon: Icon(
                Icons.call_end,
              ),
            ),
            SelectableText(controller.roomID.string),
          ],
        ),
      ),
      isDismissible: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: Colors.transparent,
    );
  }

  // مربع انشاء غرفة
  Widget _buildCreateRoomDialog() {
    return AlertDialog.adaptive(
      content: Form(
        key: controller.roomKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Room Name: "),
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'اكتب اسم الغرفة',
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Enter Room name';
                    }
                    return null;
                  },
                  controller: controller.roomNameField,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            await controller.createRoom(controller.roomNameField.text);
            // await controller.signaling.createRoom(controller.remoteRenderer);
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
