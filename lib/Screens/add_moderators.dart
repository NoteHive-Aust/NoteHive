import 'package:flutter/material.dart';
import 'package:notehive/Screens/members.dart';
import '../widgets/leadingbackButton.dart';

class AddModeratorsScreen extends StatefulWidget {
  const AddModeratorsScreen({super.key});

  @override
  State<AddModeratorsScreen> createState() => _AddModeratorsScreenState();
}

class _AddModeratorsScreenState extends State<AddModeratorsScreen> {
  List<Map<String, dynamic>> currentModerators = [
    {'name': 'Rahim', 'isRemovable': false},
    {'name': 'Rahim', 'isRemovable': false},
    {'name': 'Rahim', 'isRemovable': false},
    {'name': 'Rahim', 'isRemovable': true},
  ];

  List<Map<String, dynamic>> candidateMembers = [
    {'name': 'Rahim', 'uploads': 42},
    {'name': 'Rahim', 'uploads': 42},
    {'name': 'Rahim', 'uploads': 42},
    {'name': 'Rahim', 'uploads': 42},
  ];

  String searchQuery = '';

  List<Map<String, dynamic>> get filteredCandidates {
    if (searchQuery.isEmpty) return candidateMembers;
    return candidateMembers
        .where((m) =>
            m['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final candidates = filteredCandidates;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 70,
        titleSpacing: 10,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: LeadingBackButton(context),
        ),
        title: Text(
          'Add Moderators',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Current Moderators',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF352E60).withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: List.generate(currentModerators.length, (index) {
                    final moderator = currentModerators[index];
                    final isLast = index == currentModerators.length - 1;

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFE6D3BA),
                            foregroundImage: AssetImage('assets/image.jpg'),
                          ),
                          title: Text(
                            moderator['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1730),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF2E2A4A),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'Moderator',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (moderator['isRemovable'] == true) ...[
                                SizedBox(width: 8),
                                InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFCE8EB),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Remove',
                                          style: TextStyle(
                                            color: Color(0xFFE55D73),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.close,
                                          color: Color(0xFFE55D73),
                                          size: 14,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xFF352E60).withOpacity(0.08),
                          ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Add New Moderator',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 12),
              Container(
                height: 52,
                padding: EdgeInsets.symmetric(horizontal: 16),
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
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFF352E60).withOpacity(0.6),
                    ),
                    hintText: 'Search by name',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'paragraph',
                      color: Color(0xFF352E60).withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF352E60).withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: List.generate(candidates.length, (index) {
                    final member = candidates[index];
                    final isLast = index == candidates.length - 1;

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Color(0xFFE6D3BA),
                            foregroundImage: AssetImage('assets/image.jpg'),
                          ),
                          title: Text(
                            member['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1730),
                            ),
                          ),
                          subtitle: Text(
                            '${member['uploads']} Uploads',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'paragraph',
                              color: Color(0xFF352E60).withOpacity(0.6),
                            ),
                          ),
                          trailing: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF352E60).withOpacity(0.2),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Color(0xFF1A1730),
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        if (!isLast)
                          Divider(
                            height: 1,
                            thickness: 1,
                            indent: 16,
                            endIndent: 16,
                            color: Color(0xFF352E60).withOpacity(0.08),
                          ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MembersScreen(),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Color(0xFF352E60).withOpacity(0.12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Show All members',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1730),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
