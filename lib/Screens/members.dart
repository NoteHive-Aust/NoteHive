import 'package:flutter/material.dart';
import '../widgets/leadingbackButton.dart';
import '../widgets/searchBox.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final List<_MemberData> adminList = [
    _MemberData(name: 'Rahim', uploads: 42, role: 'Admin'),
  ];

  final List<_MemberData> moderatorList = [
    _MemberData(name: 'Rahim', uploads: 42, role: 'Moderator'),
    _MemberData(name: 'Rahim', uploads: 42, role: 'Moderator'),
    _MemberData(name: 'Rahim', uploads: 42, role: 'Moderator'),
  ];

  final List<_MemberData> memberList = [
    _MemberData(name: 'Rahim', uploads: 42, role: 'Member'),
    _MemberData(name: 'Rahim', uploads: 42, role: 'Member'),
    _MemberData(name: 'Rahim', uploads: 42, role: 'Member'),
    _MemberData(name: 'Rahim', uploads: 42, role: 'Member', isKickable: true),
  ];

  String searchQuery = '';

  List<_MemberData> _filterMembers(List<_MemberData> members) {
    if (searchQuery.isEmpty) return members;
    return members
        .where((m) => m.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredAdmins = _filterMembers(adminList);
    final filteredModerators = _filterMembers(moderatorList);
    final filteredMembers = _filterMembers(memberList);

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
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
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
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18),
              children: [
                if (filteredAdmins.isNotEmpty)
                  _buildRoleSection(filteredAdmins),
                if (filteredModerators.isNotEmpty) ...[
                  SizedBox(height: 14),
                  _buildRoleSection(filteredModerators),
                ],
                if (filteredMembers.isNotEmpty) ...[
                  SizedBox(height: 14),
                  _buildRoleSection(filteredMembers),
                ],
                SizedBox(height: 14),
                _buildShowMoreButton(136),
                SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSection(List<_MemberData> members) {
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
          children: List.generate(members.length, (index) {
            return _buildMemberTile(members[index]);
          }),
        ),
      ),
    );
  }

  Widget _buildMemberTile(_MemberData member) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Color(0xFFE6D3BA),
        foregroundImage: AssetImage('assets/image.jpg'),
      ),
      title: Text(
        member.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A1730),
        ),
      ),
      subtitle: Text(
        '${member.uploads} Uploads',
        style: TextStyle(
          fontSize: 13,
          fontFamily: 'paragraph',
          color: Color(0xFF352E60).withOpacity(0.6),
          height: 1.5,
        ),
      ),
      trailing: member.isKickable
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildRoleBadge(member.role, member.role),
                SizedBox(width: 8),
                _buildKickButton(),
              ],
            )
          : _buildRoleBadge(member.role, member.role),
    );
  }

  Widget _buildRoleBadge(String role, String label) {
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (role) {
      case 'Admin':
        bgColor = Color(0xFF8474F0);
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
      case 'Moderator':
        bgColor = Color(0xFF2E2A4A);
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
      default:
        bgColor = Colors.white;
        textColor = Color(0xFF1A1730);
        borderColor = Color(0xFF352E60).withOpacity(0.1);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildKickButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFFCE8EB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Kick',
            style: TextStyle(
              color: Color(0xFFE55D73),
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          SizedBox(width: 4),
          Icon(Icons.close, color: Color(0xFFE55D73), size: 14),
        ],
      ),
    );
  }

  Widget _buildShowMoreButton(int count) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Color(0xFF352E60).withOpacity(.1)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              'Show $count more members',
              style: TextStyle(
                color: Color(0xFF1A1730),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MemberData {
  final String name;
  final int uploads;
  final String role;
  final bool isKickable;

  _MemberData({
    required this.name,
    required this.uploads,
    required this.role,
    this.isKickable = false,
  });
}
