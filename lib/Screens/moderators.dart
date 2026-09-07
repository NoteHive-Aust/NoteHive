import 'package:flutter/material.dart';
import 'package:notehive/Screens/add_moderators.dart';
import '../widgets/leadingbackButton.dart';

class ModeratorData {
  final String name;
  final String role;
  final bool isRemovable;

  ModeratorData({
    required this.name,
    this.role = 'Moderator',
    this.isRemovable = false,
  });
}

class ModeratorsScreen extends StatefulWidget {
  const ModeratorsScreen({super.key});

  @override
  State<ModeratorsScreen> createState() => _ModeratorsScreenState();
}

class _ModeratorsScreenState extends State<ModeratorsScreen> {
  List<ModeratorData> moderatorList = [
    ModeratorData(name: 'Rahim'),
    ModeratorData(name: 'Karim'),
    ModeratorData(name: 'Selim'),
    ModeratorData(name: 'Rahim', isRemovable: true),
  ];

  String searchQuery = '';

  List<ModeratorData> get filteredModerators {
    if (searchQuery.isEmpty) return moderatorList;
    return moderatorList
        .where((m) => m.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = filteredModerators;

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
          'Moderators',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddModeratorsScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(0xFF1A1730),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Container(
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
                    hintText: 'Search moderator name',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'paragraph',
                      color: Color(0xFF352E60).withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color(0xFF352E60).withOpacity(0.1),
                      ),
                    ),
                    child: Column(
                      children: List.generate(list.length, (index) {
                        final moderator = list[index];
                        final isLast = index == list.length - 1;

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
                                moderator.name,
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
                                      moderator.role,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (moderator.isRemovable) ...[
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
                                          borderRadius:
                                              BorderRadius.circular(14),
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
