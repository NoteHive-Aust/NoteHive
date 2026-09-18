import 'package:flutter/material.dart';
import '../widgets/leadingbackButton.dart';

class ResourceDetailsScreen extends StatefulWidget {
  const ResourceDetailsScreen({super.key});

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
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
          'Resource Details',
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
            _buildPreviewCard(),
            const SizedBox(height: 20),
            _buildTitleAndTag(),
            const SizedBox(height: 16),
            _buildUploaderInfo(),
            const SizedBox(height: 20),
            _buildDescriptionSection(),
            const SizedBox(height: 20),
            _buildStatsCard(),
            const SizedBox(height: 20),
            _buildActionButtons(),
            const SizedBox(height: 28),
            _buildCommentsSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      width: double.infinity,
      height: 173,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3F8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            size: 64,
            color: const Color(0xFF352E60).withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2A4A),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Open full preview',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndTag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Structure - Unit 4 Complete Notes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF352E60).withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF352E60).withOpacity(0.1)),
          ),
          child: const Text(
            'Notes',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF352E60),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploaderInfo() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFE6D3BA),
          foregroundImage: AssetImage('assets/image.jpg'),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rahim Ibrahim',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Ahsanullah University',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'paragraph',
                  color: const Color(0xFF352E60).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            style: const TextStyle(fontFamily: 'paragraph'),
            children: [
              const TextSpan(
                text: '3.2 MB  ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              TextSpan(
                text: '2d ago',
                style: TextStyle(
                  fontSize: 13,
                  color: const Color(0xFF352E60).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Comprehensive notes covering trees, graphs, and dynamic programming with solved examples from previous exams. Includes complexity analysis tables.',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'paragraph',
            color: const Color(0xFF352E60).withOpacity(0.6),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Downloads',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1730),
                  ),
                ),
                Text(
                  '340',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1730),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: const Color(0xFF352E60).withOpacity(0.08),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Views',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1730),
                  ),
                ),
                Text(
                  '1.2k',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1730),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.file_download_outlined,
                color: Colors.white,
                size: 22,
              ),
              label: const Text(
                'Download',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8474F0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF352E60).withOpacity(0.1)),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share_outlined,
              color: Color(0xFF1A1730),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Comments (12)',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1730),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF352E60).withOpacity(0.12),
                ),
              ),
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1730),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _buildCommentCard(),
        const SizedBox(height: 12),
        _buildCommentCard(),
        const SizedBox(height: 20),
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE6D3BA),
              foregroundImage: AssetImage('assets/image.jpg'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFF352E60).withOpacity(0.04),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'paragraph',
                      color: const Color(0xFF352E60).withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFE6D3BA),
          foregroundImage: AssetImage('assets/image.jpg'),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF352E60).withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Rahim',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1730),
                      ),
                    ),
                    Text(
                      '1h ago',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'paragraph',
                        color: const Color(0xFF352E60).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Comprehensive notes covering trees, graphs, and dynamic programming with solved examples from previous exams. Includes complexity analysis tables.',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'paragraph',
                    color: const Color(0xFF352E60).withOpacity(0.6),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
