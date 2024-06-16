import express from 'express';
import { RoomServiceClient, AccessToken } from 'livekit-server-sdk';
import { throwIfMissing } from "./utils.js";
import LivekitService from "./livekit/createRoom.js";
// import generateToken from "./livekit/joinRoom.js";
import configDotenv from 'dotenv';
configDotenv.config()

const initialRooms = [];

const app = express();
const port = process.env.PORT || 3000;
const roomService = new RoomServiceClient( process.env.LIVEKIT_SOCKET_URL, process.env.LIVEKIT_API_KEY,  process.env.LIVEKIT_API_SECRET);

// create token
const createToken = (isRoomAdmin, roomName, participantName) => {
    const at = new AccessToken(process.env.LIVEKIT_API_KEY, process.env.LIVEKIT_API_SECRET, {
        identity: participantName,
    });
    // check if the token for the user or the admin
    if (isRoomAdmin == true) {
        console.log('Creating new room');
        at.addGrant({ 
            room: roomName,
            roomCreate: isRoomAdmin,
            roomAdmin: isRoomAdmin,
            roomJoin: true,
            canPublish: true,
            canPublishData: true,
            canSubscribe: true,
            roomList: true,
        });
        

    } else {
        console.log('Joining room');
        //adding permissions to the access token before converting to jwt
        at.addGrant({
            room: roomName,
            roomCreate: isRoomAdmin,
            roomAdmin: isRoomAdmin,
            roomJoin: true,
            canPublish: true,
            canPublishData: true,
            canSubscribe: true,
            roomList: true,
        });
    }

    return at.toJwt();
};

// For parsing application/json
app.use(express.json());

class ValidationErrors extends Error {
    constructor(errors) {
        super("Validation failed");
        this.name = "ValidationErrors";
        this.errors = errors;
    }
}

// create rooms
const createRoom = async (req, res, log, error) => {
    try {
        throwIfMissing(process.env, [
            "LIVEKIT_API_KEY",
            "LIVEKIT_API_SECRET",
            "LIVEKIT_SOCKET_URL",
        ]);

        if (!res) {
            console.error('Response object is undefined.');
            return;
        }

        // instance of the LivekitService
        // const livekit = new LivekitService();
        console.log(req.body.name);

        // create a new room on appwrite
        const newRoomdata = {
            name: req.body.name,
            adminUid: req.body.adminUid,
            totalParticipants: 20,
        };

        // Perform validation
        if (!newRoomdata.name || !newRoomdata.adminUid) {
            const validationErrors = new ValidationErrors({
                name: req.body.name,
                adminUid: req.body.adminUid || null,
            });
            throw validationErrors;
        }

        // Log newRoomdata to ensure the data is correct
        console.log('New Room Data:', newRoomdata);

        // const room = await livekit.createRoom(newRoomdata);
        const room = await roomService.createRoom(newRoomdata);

        console.log('Room Created:', room);

        // Creating a token for the admin
        const token = createToken(true, req.body.name, req.body.adminUid);
        console.log('Token Generated:', token);

        console.log('livekitRoom:', room);
        console.log('token:', token);

        return res.json({
            msg: "Room created Successfully",
            livekit_room: room,
            livekit_socket_url: `${process.env.LIVEKIT_SOCKET_URL}`,
            access_token: token,
        });
    } catch (e) {
        console.error(String(e));

        if (e instanceof ValidationErrors) {
            return res.status(400).json({ msg: "Validation failed", errors: e.errors });
        } else {
            return res.status(500).json({ msg: "Room creation failed" });
        }
    }
};

// join room
const joinRoom = async (req, res) => {
    // Creating a token for the user
    const token = createToken(false, req.body.name, req.body.userUid,);
    // await generateToken()

    return res.json({
        msg: "Joined Successfully",
        // livekit_room: room,
        livekit_socket_url: `${process.env.LIVEKIT_SOCKET_URL}`,
        access_token: token,
    });
}

// list rooms
const listRooms = async () => {
    try {
        const rooms = await roomService.listRooms();
        console.log('existing rooms', rooms);
        return rooms;
    } catch (error) {
        console.error('Error listing rooms', error);
        throw error; // rethrow the error for the caller to handle
    }
};

// post generate token
app.post('/getToken', (req, res) => {
    try {
        const token = createToken();
        res.json({ token });
    } catch (error) {
        console.error('Error generating token:', error);
        res.status(500).json({ error: 'Failed to generate token' });
    }
});

app.post("/newRoom", async (req, res) => {
    try {
        await createRoom(req, res); // Ensure 'res' is passed
    } catch (error) {
        console.error('Error creating room', error);
        return res.status(500).json({ error: 'Failed to create room', details: error.message });
    }
});

app.post("/joinRoom", async (req, res) => {
    try {
        await joinRoom(req, res); // Ensure 'res' is passed
    } catch (error) {
        console.error('Error joining room', error);
        return res.status(500).json({ error: 'Failed to joing room', details: error.message });
    }
});

app.get("/listRooms", async (req, res) => {
    try {
        const rooms = await listRooms(req.body);
        res.json({ rooms });
    } catch (error) {
        console.error('Error listing rooms', error);
        res.status(500).json({ error: 'Failed to list rooms' });
    }
});

app.listen(port, () => {
    console.log(`Server listening on port ${port}`);
});
