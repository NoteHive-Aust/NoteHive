import 'package:cloud_firestore/cloud_firestore.dart';

class RoomUserData {
  final String id;
  final DocumentReference reference;
  final String name;
  final String? profileImage;
  final int uploads;

  RoomUserData({
    required this.id,
    required this.reference,
    required this.name,
    this.profileImage,
    this.uploads = 0,
  });
}

class RoomModeratorsAndMembers {
  final List<RoomUserData> moderators;
  final List<RoomUserData> candidateMembers;

  RoomModeratorsAndMembers({
    required this.moderators,
    required this.candidateMembers,
  });
}

Future<List<RoomUserData>> getRoomModerators(String roomId) async {
  final roomSnap =
      await FirebaseFirestore.instance.collection('Rooms').doc(roomId).get();
  if (!roomSnap.exists || roomSnap.data() == null) {
    return [];
  }

  List<dynamic> modRefs = roomSnap.data()!['Moderators'] ?? [];
  List<RoomUserData> moderators = [];

  List<Future<void>> futures = modRefs.map((ref) async {
    if (ref is DocumentReference) {
      try {
        final userDoc =
            await (ref as DocumentReference<Map<String, dynamic>>).get();
        if (userDoc.exists && userDoc.data() != null) {
          final userData = userDoc.data()!;
          moderators.add(
            RoomUserData(
              id: userDoc.id,
              reference: userDoc.reference,
              name: userData['Name'] ?? 'No Name',
              profileImage: userData['ProfileImage'],
              uploads: userData['TotalUpLoads'] ?? userData['TotalUploads'] ?? 0,
            ),
          );
        }
      } catch (_) {}
    }
  }).toList();

  await Future.wait(futures);
  return moderators;
}

Future<RoomModeratorsAndMembers> getRoomModeratorsAndMembers(String roomId) async {
  final roomSnap =
      await FirebaseFirestore.instance.collection('Rooms').doc(roomId).get();
  if (!roomSnap.exists || roomSnap.data() == null) {
    return RoomModeratorsAndMembers(moderators: [], candidateMembers: []);
  }

  final data = roomSnap.data()!;
  final dynamic adminRef = data['Admin'];
  String? adminId =
      adminRef is DocumentReference ? adminRef.id : adminRef?.toString();

  List<dynamic> modRefs = data['Moderators'] ?? [];
  List<dynamic> memberRefs = data['Members'] ?? [];

  Set<String> allUserIds = {};
  for (var ref in modRefs) {
    if (ref is DocumentReference) allUserIds.add(ref.id);
  }
  for (var ref in memberRefs) {
    if (ref is DocumentReference) allUserIds.add(ref.id);
  }

  Map<String, RoomUserData> usersMap = {};
  List<Future<void>> futures = allUserIds.map((uid) async {
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        final userData = userDoc.data()!;
        usersMap[uid] = RoomUserData(
          id: uid,
          reference: userDoc.reference,
          name: userData['Name'] ?? 'No Name',
          profileImage: userData['ProfileImage'],
          uploads: userData['TotalUpLoads'] ?? userData['TotalUploads'] ?? 0,
        );
      }
    } catch (_) {}
  }).toList();

  await Future.wait(futures);

  List<RoomUserData> moderators = [];
  Set<String> modIds = {};
  for (var ref in modRefs) {
    if (ref is DocumentReference && usersMap.containsKey(ref.id)) {
      moderators.add(usersMap[ref.id]!);
      modIds.add(ref.id);
    }
  }

  List<RoomUserData> candidateMembers = [];
  for (var ref in memberRefs) {
    if (ref is DocumentReference) {
      String uid = ref.id;
      if (uid != adminId && !modIds.contains(uid) && usersMap.containsKey(uid)) {
        candidateMembers.add(usersMap[uid]!);
      }
    }
  }

  return RoomModeratorsAndMembers(
    moderators: moderators,
    candidateMembers: candidateMembers,
  );
}

Future<void> addModerator(String roomId, DocumentReference userRef) async {
  await FirebaseFirestore.instance.collection('Rooms').doc(roomId).update({
    'Moderators': FieldValue.arrayUnion([userRef]),
  });
}

Future<void> removeModerator(String roomId, DocumentReference userRef) async {
  await FirebaseFirestore.instance.collection('Rooms').doc(roomId).update({
    'Moderators': FieldValue.arrayRemove([userRef]),
  });
}
