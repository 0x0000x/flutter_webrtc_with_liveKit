import '../../core/app_export.dart';

class RoomCardWidget extends StatelessWidget {
  const RoomCardWidget({
    super.key,
    required this.creatorID,
    required this.roomID,
    required this.roomName,
    this.onJoin,
  });

  final String roomName;
  final String roomID;
  final String creatorID;
  final VoidCallback? onJoin;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      // color: Colors.transparent,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          // onTap: () {
          //   //
          // },
          // dense: true,
          minVerticalPadding: 10,

          tileColor: Colors.amberAccent.withOpacity(0.2),

          title: Text(roomName),
          subtitle: Text('id: $roomID'),
          trailing: TextButton(
            onPressed:onJoin,
            child: const Text('Join'),
          ),
        ),
      ),
    );
  }
}
