import 'package:cloud_firestore/cloud_firestore.dart';

class UserDoc {
  final String uid;
  final String name;
  final String profileUrl;
  final int totalUploads;

  UserDoc({
    required this.uid,
    required this.name,
    required this.profileUrl,
    required this.totalUploads,
  });

  factory UserDoc.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data() ?? {};
    return UserDoc(
      uid: snap.id,
      name: data['Name'] ?? 'Unknown',
      profileUrl: data['ProfileImage'] ?? '',
      totalUploads: (data['TotalUploads'] ?? 0) as int,
    );
  }
}

class RoomMembersData {
  final UserDoc admin;
  final List<UserDoc> moderators;
  final List<UserDoc> members;

  RoomMembersData({
    required this.admin,
    required this.moderators,
    required this.members,
  });
}

Future<RoomMembersData> getRoomMembers({required String roomId}) async {
  final roomSnap = await FirebaseFirestore.instance
      .collection('Rooms')
      .doc(roomId)
      .get();

  final data = roomSnap.data();
  if (data == null) throw Exception('Room not found: $roomId');

  final DocumentReference<Map<String, dynamic>> adminRef =
      data['Admin'] as DocumentReference<Map<String, dynamic>>;

  final List<DocumentReference<Map<String, dynamic>>> modRefs =
      List<DocumentReference<Map<String, dynamic>>>.from(
          data['Moderators'] ?? []);

  final List<DocumentReference<Map<String, dynamic>>> memberRefs =
      List<DocumentReference<Map<String, dynamic>>>.from(
          data['Members'] ?? []);

  final Set<String> privilegedUids = {
    adminRef.id,
    ...modRefs.map((r) => r.id),
  };

  final results = await Future.wait([
    adminRef.get(),
    ...modRefs.map((r) => r.get()),
    ...memberRefs
        .where((r) => !privilegedUids.contains(r.id))
        .map((r) => r.get()),
  ]);

  int cursor = 0;

  final UserDoc admin = UserDoc.fromSnapshot(
    results[cursor++] as DocumentSnapshot<Map<String, dynamic>>,
  );

  final List<UserDoc> moderators = [];
  for (int i = 0; i < modRefs.length; i++) {
    moderators.add(UserDoc.fromSnapshot(
      results[cursor++] as DocumentSnapshot<Map<String, dynamic>>,
    ));
  }

  final List<UserDoc> members = [];
  while (cursor < results.length) {
    members.add(UserDoc.fromSnapshot(
      results[cursor++] as DocumentSnapshot<Map<String, dynamic>>,
    ));
  }

  return RoomMembersData(admin: admin, moderators: moderators, members: members);
}

Future<void> kickMember({
  required String roomId,
  required String memberUid,
}) async {
  await FirebaseFirestore.instance.collection('Rooms').doc(roomId).update({
    'Members': FieldValue.arrayRemove([
      FirebaseFirestore.instance.collection('Users').doc(memberUid),
    ]),
  });
}
