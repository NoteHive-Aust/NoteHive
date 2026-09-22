import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../widgets/leadingbackButton.dart';
import 'dart:typed_data';

import 'package:notehive/FirebaseOperations/firebase_storage_services.dart';

class ResourceUploadScreen extends StatefulWidget {
  const ResourceUploadScreen({super.key});

  @override
  State<ResourceUploadScreen> createState() => _ResourceUploadScreenState();
}

class _ResourceUploadScreenState extends State<ResourceUploadScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedCategory;

  PlatformFile? selectedFile;
  bool isUploading = false;
  String? titleError;
  String? categoryError;
  String? descriptionError;
  String? fileError;
  final List<String> categories = [
    'Notes',
    'Question Bank',
    'Lab Report',
    'Book / Reference',
    'Lecture Slides',
  ];
  Future<void> pickPdfFile() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result.isNotEmpty && result.single.bytes != null) {
        setState(() {
          selectedFile = result.single;
          fileError = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error selecting file: $e')));
      }
    }
  }

  bool validateForm() {
    setState(() {
      titleError = _titleController.text.trim().isEmpty
          ? 'Title is required'
          : null;

      categoryError = selectedCategory == null
          ? 'Please select a category'
          : null;

      descriptionError = _descriptionController.text.trim().isEmpty
          ? 'Description is required'
          : null;

      fileError = selectedFile == null
          ? 'Please select a PDF file to upload'
          : null;
    });

    return titleError == null &&
        categoryError == null &&
        descriptionError == null &&
        fileError == null;
  }

  Future<void> handleSubmit() async {
    if (!validateForm()) {
      return;
    }

    setState(() {
      isUploading = true;
    });

    final String fileName = selectedFile!.name;
    final Uint8List fileBytes = selectedFile!.bytes!;

    final String? downloadUrl = await FirebaseStorageService.instance
        .uploadFile(fileBytes, fileName);

    setState(() {
      isUploading = false;
    });

    if (downloadUrl != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Resource uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to upload file. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final double kb = bytes / 1024;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    final double mb = kb / 1024;
    return '${mb.toStringAsFixed(1)} MB';
  }

  Widget errorText(String? errorText) {
    if (errorText == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6, left: 4),
      child: Text(
        errorText,
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        leading: LeadingBackButton(context),
        title: const Text(
          'Upload Resource',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel('Title'),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _titleController,
              hintText: 'Enter your title',
            ),
            errorText(titleError),
            const SizedBox(height: 20),
            _buildFieldLabel('Category'),
            const SizedBox(height: 8),
            _buildCategoryDropdown(),
            const SizedBox(height: 20),
            _buildFieldLabel('Description'),
            const SizedBox(height: 8),
            _buildDescriptionField(),
            const SizedBox(height: 24),
            _buildDropzoneArea(),
            const SizedBox(height: 16),
            _buildUploadedFileCard(),
            const SizedBox(height: 32),
            _buildSubmitButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1A1730),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF352E60).withOpacity(0.03),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              fontFamily: 'paragraph',
              color: const Color(0xFF352E60).withOpacity(0.35),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF352E60).withOpacity(0.03),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          hint: Text(
            'Select resource category',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'paragraph',
              color: const Color(0xFF352E60).withOpacity(0.35),
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: const Color(0xFF352E60).withOpacity(0.5),
          ),
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(
                category,
                style: const TextStyle(fontSize: 14, color: Color(0xFF1A1730)),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCategory = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: TextField(
        controller: _descriptionController,
        maxLines: 5,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Write down resource description...',
          hintStyle: TextStyle(
            fontSize: 14,
            fontFamily: 'paragraph',
            color: const Color(0xFF352E60).withOpacity(0.35),
          ),
        ),
      ),
    );
  }

  Widget _buildDropzoneArea() {
    return GestureDetector(
      onTap: pickPdfFile,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF352E60).withOpacity(0.02),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: fileError != null
                ? Colors.red.withOpacity(
                    0.5,
                  ) // [ADDED: Highlight border on error]
                : const Color(0xFF352E60).withOpacity(0.12),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFF352E60).withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.file_upload_outlined,
                color: Color(0xFF352E60),
                size: 28,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Drop file here or Browse',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1730),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Supports PDF, DOC, DOCX, PPT, PPTX (max 25 MB)',
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'paragraph',
                color: const Color(0xFF352E60).withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: pickPdfFile,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: const Color(0xFF352E60).withOpacity(0.15),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text(
                'Choose File',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedFileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF352E60).withOpacity(0.08),
              ),
            ),
            child: const Icon(
              Icons.insert_drive_file_outlined,
              color: Color(0xFF352E60),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CSE_lecture_note.pdf',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1730),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '3.2 MB . PDF',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'paragraph',
                    color: const Color(0xFF352E60).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8474F0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Submit For Review',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
