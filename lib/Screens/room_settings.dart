import 'package:flutter/material.dart';
import 'package:notehive/widgets/cards.dart';
import 'package:notehive/widgets/leadingbackButton.dart';

class RoomSettings extends StatefulWidget {
  const RoomSettings({super.key});

  @override
  State<RoomSettings> createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String? selectedDepartment;
  String? selectedBatchYear;

  bool privateRoom = true;
  bool onlyModeratorUpload = false;

  List<String> departments = [
    'Computer Science & Engineering',
    'Electrical & Electronic Engineering',
    'Civil Engineering',
    'Mechanical Engineering',
    'Textile Engineering',
    'Architecture',
    'Business Administration',
  ];

  List<String> batchYears = [
    '1st Year, 1st Semester',
    '1st Year, 2nd Semester',
    '2nd Year, 1st Semester',
    '2nd Year, 2nd Semester',
    '3rd Year, 1st Semester',
    '3rd Year, 2nd Semester',
    '4th Year, 1st Semester',
    '4th Year, 2nd Semester',
    'Batch 2024',
    'Batch 2023',
    'Batch 2022',
  ];

  List<String> categories = ['Note', 'Lab report'];

  @override
  void dispose() {
    roomNameController.dispose();
    institutionController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void addCategoryDialog() {
    TextEditingController newCategoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Add Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1730),
            ),
          ),
          content: TextField(
            controller: newCategoryController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter category name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF352E60)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (newCategoryController.text.trim().isNotEmpty) {
                  setState(() {
                    categories.add(newCategoryController.text.trim());
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8474F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Room Name',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFB5ACF6).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: TextField(
                    controller: roomNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a name for your room',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'paragraph',
                        color: Color(0xFF352E60).withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Institution/ University',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFB5ACF6).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: TextField(
                    controller: institutionController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter institution name',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: 'paragraph',
                        color: Color(0xFF352E60).withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Department',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFB5ACF6).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedDepartment,
                    isExpanded: true,
                    hint: Text(
                      'Select your department',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'paragraph',
                        color: Color(0xFF352E60).withOpacity(0.35),
                      ),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF352E60).withOpacity(0.5),
                    ),
                    items: departments.map((String dept) {
                      return DropdownMenuItem<String>(
                        value: dept,
                        child: Text(dept, style: TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedDepartment = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Batch/ Year',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFB5ACF6).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedBatchYear,
                    isExpanded: true,
                    hint: Text(
                      'Select year',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'paragraph',
                        color: Color(0xFF352E60).withOpacity(0.35),
                      ),
                    ),
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF352E60).withOpacity(0.5),
                    ),
                    items: batchYears.map((String batch) {
                      return DropdownMenuItem<String>(
                        value: batch,
                        child: Text(batch, style: TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedBatchYear = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                'Room Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Color(0xFF352E60).withOpacity(0.1),
                  ),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write room description (Optional)',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'paragraph',
                      color: Color(0xFF352E60).withOpacity(0.35),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              RoomToggleCard(
                privateRoom: privateRoom,
                onPrivateRoomChanged: (bool value) {
                  setState(() {
                    privateRoom = value;
                  });
                },
                onlyModeratorUpload: onlyModeratorUpload,
                onOnlyModeratorUploadChanged: (bool value) {
                  setState(() {
                    onlyModeratorUpload = value;
                  });
                },
              ),
              SizedBox(height: 18),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ...categories.map((String category) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFF352E60).withOpacity(0.15),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1A1730),
                            ),
                          ),
                          SizedBox(width: 6),
                          InkWell(
                            onTap: () {
                              setState(() {
                                categories.remove(category);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Color(0xFF1A1730),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  InkWell(
                    onTap: addCategoryDialog,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(0xFF1A1730),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8474F0),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 70,
      titleSpacing: 10,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: LeadingBackButton(context),
      ),
      title: Text(
        'Room Settings',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A1730),
        ),
      ),
    );
  }
}
