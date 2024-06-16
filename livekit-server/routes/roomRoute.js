import express from "express"
import {
    createRoom,
    deleteRoom,
    joinRoom,
    listRooms
} from '../controllers/RoomController.js'

const router = express.Router()

// Route to create a new room and return a success message
// router.get('/', createRoom)

// Route to join a room and generate a token for the user
router.get('/', joinRoom)

// Route to retrieve the list of rooms
router.get('/', listRooms)

// Route to delete a room
router.delete('/:roomId', deleteRoom)

export default router
