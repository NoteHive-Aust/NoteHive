import 'package:flutter/material.dart';
import 'package:notehive/FirebaseOperations/getRoomMembers.dart';
import '../widgets/leadingbackButton.dart';

class MembersScreen extends StatefulWidget {
  final String? roomId;
  final String? currentUserUid;

  const MembersScreen({super.key, this.roomId, this.currentUserUid});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  String searchQuery = '';
  late Future<RoomMembersData> _future;

  @override
  void initState() {
    super.initState();
    _future = getRoomMembers(roomId: widget.roomId ?? '');
  }

  void _reload() => setState(() {
        _future = getRoomMembers(roomId: widget.roomId ?? '');
      });

  List<UserDoc> _filter(List<UserDoc> list) {
    if (searchQuery.isEmpty) return list;
    return list
        .where((u) => u.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 70,
        leading: LeadingBackButton(context),
        title: Text(
          'Members',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              height: 55,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xFF352E60).withOpacity(0.05),
              ),
              child: TextField(
                onChanged: (v) => setState(() => searchQuery = v),
                maxLines: 1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: 'Search member name',
                ),
              ),
            ),
          ),
          SizedBox(height: 10),

          Expanded(
            child: widget.roomId == null || widget.roomId!.isEmpty
                ? _buildDummyList()
                : FutureBuilder<RoomMembersData>(
                    future: _future,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snap.hasError) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Text(
                              'Could not load members.\n${snap.error}',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[400]),
                            ),
                          ),
                        );
                      }

                      final data = snap.data!;
                      final uid = widget.currentUserUid ?? '';
                      final bool canKick = data.admin.uid == uid ||
                          data.moderators.any((m) => m.uid == uid);

                      final admins = _filter([data.admin]);
                      final mods = _filter(data.moderators);
                      final members = _filter(data.members);

                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        children: [
                          if (admins.isNotEmpty) ...[
                            _buildSection(admins, 'Admin',
                                canKick: false),
                          ],
                          if (mods.isNotEmpty) ...[
                            SizedBox(height: 14),
                            _buildSection(mods, 'Moderator',
                                canKick: false),
                          ],
                          if (members.isNotEmpty) ...[
                            SizedBox(height: 14),
                            _buildSection(members, 'Member',
                                canKick: canKick,
                                roomId: widget.roomId!),
                          ],
                          if (admins.isEmpty && mods.isEmpty && members.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: Center(
                                child: Text('No members found.',
                                    style: TextStyle(color: Colors.grey)),
                              ),
                            ),
                          SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    List<UserDoc> users,
    String role, {
    bool canKick = false,
    String? roomId,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xFF352E60).withOpacity(.1)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: users.map((u) {
            final ImageProvider avatar = u.profileUrl.isNotEmpty
                ? NetworkImage(u.profileUrl)
                : AssetImage('assets/image.jpg') as ImageProvider;

            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFE6D3BA),
                backgroundImage: avatar,
              ),
              title: Text(
                u.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1730),
                ),
              ),
              subtitle: Text(
                '${u.totalUploads} Uploads',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'paragraph',
                  color: Color(0xFF352E60).withOpacity(0.6),
                  height: 1.5,
                ),
              ),
              trailing: (canKick && role == 'Member')
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _roleBadge(role),
                        SizedBox(width: 8),
                        _kickButton(u.uid, roomId!),
                      ],
                    )
                  : _roleBadge(role),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _roleBadge(String role) {
    final colors = {
      'Admin': (Color(0xFF8474F0), Colors.white, Colors.transparent),
      'Moderator': (Color(0xFF2E2A4A), Colors.white, Colors.transparent),
    };
    final c = colors[role] ??
        (Colors.white, Color(0xFF1A1730), Color(0xFF352E60).withOpacity(0.1));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: c.$1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.$3 as Color, width: 1.5),
      ),
      child: Text(role,
          style: TextStyle(
              color: c.$2 as Color,
              fontSize: 13,
              fontWeight: FontWeight.w700)),
    );
  }

  Widget _kickButton(String memberUid, String roomId) {
    return GestureDetector(
      onTap: () async {
        final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Kick Member'),
            content: Text('Remove this member from the room?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Kick',
                    style: TextStyle(color: Color(0xFFE55D73))),
              ),
            ],
          ),
        );
        if (ok == true) {
          await kickMember(roomId: roomId, memberUid: memberUid);
          _reload();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFFCE8EB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Kick',
                style: TextStyle(
                    color: Color(0xFFE55D73),
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
            SizedBox(width: 4),
            Icon(Icons.close, color: Color(0xFFE55D73), size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildDummyList() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Text(
          'Open this page from inside a room to see members.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
