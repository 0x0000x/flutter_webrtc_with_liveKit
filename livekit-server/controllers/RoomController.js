import { throwIfMissing } from "../utils.js";
import LivekitService from "../livekit/createRoom.js";
import { RoomServiceClient } from "livekit-server-sdk";
import { generateToken } from "../livekit/joinRoom.js";
import roomService from "../roomService.js";

const deleteRoom = async ({ req, res, log, error }) => {
    try {
        // Check for required environment variables
        const requiredEnvVariables = [
            "LIVEKIT_HOST",
            "LIVEKIT_API_KEY",
            "LIVEKIT_API_SECRET",
        ];
        throwIfMissing(process.env, requiredEnvVariables);

        const roomServiceClient = new RoomServiceClient(
            process.env.LIVEKIT_HOST,
            process.env.LIVEKIT_API_KEY,
            process.env.LIVEKIT_API_SECRET
        );

        console.log(roomServiceClient);

        // Log the request
        log(req);

        // Check if the requester is the room admin
        const roomAdminUid = req.headers["x-appwrite-user-id"];
        if (appwriteRoom.adminUid !== roomAdminUid) {
            log("User not room admin");
            return res.status(403).json({ msg: "User is not room admin" });
        }

        // Delete Appwrite room document
        await databases.deleteDocument(
            process.env.MASTER_DATABASE_ID,
            process.env.ROOMS_COLLECTION_ID,
            appwriteRoomDocId
        );

        // Remove participants from the collection
        const participantColRef = await databases.listDocuments(
            process.env.MASTER_DATABASE_ID,
            process.env.PARTICIPANTS_COLLECTION_ID,
            [Query.equal("roomId", [appwriteRoomDocId])]
        );

        // Log participantColRef
        log(participantColRef);

        // Delete each participant document
        await Promise.all(participantColRef.documents.map(async (participant) => {
            await databases.deleteDocument(
                process.env.MASTER_DATABASE_ID,
                process.env.PARTICIPANTS_COLLECTION_ID,
                participant.$id
            );
        }));

        // Delete Livekit room
        // await roomServiceClient.deleteRoom(appwriteRoomDocId);

        // Respond with success
        return res.json({ msg: "Room deleted successfully" });
    } catch (e) {
        // Log the error and respond with an error message
        console.log(String(e));
        return res.status(e.statusCode || 500).json({ msg: "Room deletion failed" });
    }
};

const joinRoom = async ({ req, res, log, error }) => {
    try {
        // Check for required environment variables
        const requiredEnvVariables = [
            "LIVEKIT_API_KEY",
            "LIVEKIT_API_SECRET",
            "LIVEKIT_SOCKET_URL",
        ];
        throwIfMissing(process.env, requiredEnvVariables);

        // Validate request body
        const { roomName, uid: userId } = JSON.parse(req.body);
        throwIfMissing({ roomName, userId }, ["roomName", "uid"]);

        // Log the request
        log(req);

        // Generate access token
        const accessToken = generateToken(process.env, roomName, userId, false);

        // Respond with success
        return res.json({
            msg: "Success",
            livekit_socket_url: process.env.LIVEKIT_SOCKET_URL,
            access_token: accessToken,
        });
    } catch (e) {
        // Log the error and respond with an error message
        console.log(String(e));
        return res.status(e.statusCode || 500).json({ msg: "Error joining room" });
    }
};

// Function to list existing rooms
const listRooms = async (req, res) => {
    try {
        const rooms = await listRooms(req.body);
        res.json({ rooms });
    } catch (error) {
        console.error('Error listing rooms', error);
        res.status(500).json({ error: 'Failed to list rooms' });
    }
};


export {
    createRoom,
    deleteRoom,
    joinRoom,
    listRooms
}
