/* 
  Contains some configurations related to this app
  9/1/2024


  Author: Amgad Fahd
  
*/

const appName = 'App WebRTC';

// -- Server
const serverURL = 'https://lake-kindhearted-wasabi.glitch.me/';
const lkProjectURL = 'wss://yafamily-ksjcj9bs.livekit.cloud';
const token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ2aWRlbyI6eyJyb29tSm9pbiI6dHJ1ZSwicm9vbSI6InF1aWNrc3RhcnQtcm9vbSJ9LCJpYXQiOjE3MDUyNDQyMjYsIm5iZiI6MTcwNTI0NDIyNiwiZXhwIjoxNzA1MjY1ODI2LCJpc3MiOiJBUElYdkJ1R01DVGRha1QiLCJzdWIiOiJxdWlja3N0YXJ0LXVzZXJuYW1lIiwianRpIjoicXVpY2tzdGFydC11c2VybmFtZSJ9.WL3Ek9RmUmS8im88GTNVfVmIelDovUzoHCJkFedbp70';

// -- Collections
const usersCollection = 'users';
const usersRoomMappingCollection = 'user_room_mapping';
const signalingDataCollection = 'signaling_data';
const iceCandidatesCollection = 'iceCandidates';
const roomsCollection = 'rooms';
const membersCollection = 'members';
const hostCollection = 'hosts';

// -- Shared Preferences Keys
const accessToken = 'accessToken';

// -- Signal Configuration
Map<String, dynamic> configuration = {
  'iceServers': [
    {
      'urls': [
        // 'stun:stun1.l.google.com:19302',
        // 'stun:stun2.l.google.com:19302'
        'stun:freestun.net:3479',
      ]
    }
  ]
};

// This file contains constants that are used throughout the app.

// Appwrite Project Constants
const String appwriteProjectId = "ya-family";
const String appwriteEndpoint = "https://cloud.appwrite.io/v1";

// User related Database Constants
const String userDatabaseID = "65a316421e287883947e";
const String usersCollectionID = "65a31680ba298b7cc201";
const String usernameCollectionID = "65a316b089064a9c6361";
const String userProfileImagePlaceholderUrl =
    "https://cloud.appwrite.io/v1/storage/buckets/64a13095a4c87fd78bc6/files/64a130ec38af1a3f0d61/view?project=64a12ff22a44f02f0545";
const String userProfileImageBucketId = "64a52ab306331f167ce6";

// Rooms related Database Constants
const String masterDatabaseId = "64a521785f5be62b796f";
const String roomsCollectionId = "64a5217e695bf2c4ec9c";
const String participantsCollectionId = "64a63e508145d1084abf";

// Pair chat database constants
const String pairRequestCollectionId = "64d980211f1395263ebe";
const String activePairsCollectionId = "64d980cd65ff2e08ab97";

// Room related cloud function constants
const String createRoomServiceId = "65a3172f62bcebec3599";
const String joinRoomServiceId = "65a317c3bf542bfe0e4c";
const String deleteRoomServiceId = "65a317f89f82ae266264";

// Un used Functions
const String sendOtpFunctionID = "6513e9d40b57c6ec156f";
const String verifyOtpFunctionID = "651303df122abc151bf3";
const String verifyUserFunctionID = "6513df34a0de595ccfb3";
const String updateEmailFunctionID = "64b27d2e813dd152f0edz";

const String emailVerificationDatabaseID = "64a7bfd6b09121548bfe";
const String verificationCollectionID = "64a7c0100eabfe8d3844";

// Github Constants
const String githubRepoUrl = "https://github.com/amgadcyber/ya_family";
