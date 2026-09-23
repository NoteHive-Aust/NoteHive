import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notehive/widgets/cards.dart';
import 'package:notehive/widgets/leadingbackButton.dart';

class RoomSettings extends StatefulWidget {
  final String? roomId;
  const RoomSettings({super.key, this.roomId});

  @override
  State<RoomSettings> createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  TextEditingController roomNameController = TextEditingController();
  TextEditingController institutionController = TextEditingController();


  String? selectedDepartment;
  String? selectedBatchYear;

  bool privateRoom = true;
  bool onlyModeratorUpload = false;
  bool isLoading = false;
  bool isSaving = false;
  bool hadAllCategory = false;

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

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _loadRoomSettings();
  }

  Future<void> _loadRoomSettings() async {
    if (widget.roomId == null) return;
    setState(() {
      isLoading = true;
    });
    try {
      final doc = await FirebaseFirestore.instance
          .collection('Rooms')
          .doc(widget.roomId)
          .get();
      if (doc.exists && mounted) {
        final data = doc.data()!;
        roomNameController.text = data['Name'] ?? '';
        institutionController.text = data['SchoolName'] ?? '';

        final dept = data['Department'] as String?;
        if (dept != null && dept.isNotEmpty) {
          if (!departments.contains(dept)) {
            departments.insert(0, dept);
          }
          selectedDepartment = dept;
        }

        final batch = (data['BatchYear'] ?? data['Batch']) as String?;
        if (batch != null && batch.isNotEmpty) {
          if (!batchYears.contains(batch)) {
            batchYears.insert(0, batch);
          }
          selectedBatchYear = batch;
        }

        if (data['IsPublic'] != null) {
          privateRoom = !(data['IsPublic'] as bool);
        }
        if (data['OnlyModeratorUpload'] != null) {
          onlyModeratorUpload = data['OnlyModeratorUpload'] as bool;
        }

        final rawCategories = (data['Categories'] as List<dynamic>?) ?? [];
        hadAllCategory = rawCategories.contains('All');
        categories = rawCategories
            .where((c) => c.toString() != 'All')
            .map((c) => c.toString())
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading room settings: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _saveSettings() async {
    if (widget.roomId == null) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      isSaving = true;
    });
    try {
      List<String> toSaveCategories = [];
      if (hadAllCategory) {
        toSaveCategories.add('All');
      }
      for (var cat in categories) {
        if (cat != 'All' && !toSaveCategories.contains(cat)) {
          toSaveCategories.add(cat);
        }
      }

      Map<String, dynamic> updateData = {
        'Name': roomNameController.text.trim(),
        'SchoolName': institutionController.text.trim(),
        'IsPublic': !privateRoom,
        'OnlyModeratorUpload': onlyModeratorUpload,
        'Categories': toSaveCategories,
      };
      if (selectedDepartment != null) {
        updateData['Department'] = selectedDepartment;
      }
      if (selectedBatchYear != null) {
        updateData['BatchYear'] = selectedBatchYear;
      }

      await FirebaseFirestore.instance
          .collection('Rooms')
          .doc(widget.roomId)
          .update(updateData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Changes saved successfully')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save changes: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    roomNameController.dispose();
    institutionController.dispose();

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
                final newCat = newCategoryController.text.trim();
                if (newCat.isNotEmpty &&
                    !categories.contains(newCat) &&
                    newCat != 'All') {
                  setState(() {
                    categories.add(newCat);
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
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                  onPressed: isSaving ? null : _saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8474F0),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isSaving
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
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
