import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notehive/FirebaseOperations/auth_services.dart';
import 'package:notehive/Structures/resourcesStructure.dart';
import '../FirebaseOperations/getRoomResources.dart';
import '../widgets/leadingbackButton.dart';

class ResourceDetailsScreen extends StatefulWidget {
  final Resource resource;
  final String resourceId;

  const ResourceDetailsScreen({
    super.key,
    required this.resource,
    required this.resourceId,
  });

  @override
  State<ResourceDetailsScreen> createState() => ResourceDetailsScreenState();
}

class ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
  final TextEditingController commentController = TextEditingController();
  bool isDownloading = false;
  bool isPostingComment = false;
  String? downloadError;
  Future<QuerySnapshot>? commentsFuture;

  @override
  void initState() {
    super.initState();
    commentsFuture = getComments(resourceId: widget.resourceId);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  Future<void> handleDownload() async {
    setState(() {
      isDownloading = true;
      downloadError = null;
    });

    try {
      final http.Response response = await http.get(
        Uri.parse(widget.resource.resourceUrl),
      );

      if (response.statusCode == 200) {
        final String fileName = widget.resource.title.replaceAll(' ', '_');
        final String downloadsPath = '/storage/emulated/0/Download';
        final Directory downloadsDir = Directory(downloadsPath);
        if (!await downloadsDir.exists()) {
          await downloadsDir.create(recursive: true);
        }
        final String filePath = '$downloadsPath/$fileName.pdf';
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        await FirebaseFirestore.instance
            .collection('Resources')
            .doc(widget.resourceId)
            .update({'Downloads': FieldValue.increment(1)});

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Downloaded to: $filePath'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 4),
            ),
          );
        }
      } else {
        setState(() {
          downloadError = 'Download failed (${response.statusCode})';
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(downloadError!),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        downloadError = 'Error: $e';
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isDownloading = false);
    }
  }

  Future<void> handlePostComment() async {
    final String text = commentController.text.trim();
    if (text.isEmpty) return;

    setState(() => isPostingComment = true);

    try {
      final String uid = AuthServices.instance.uid;
      final DocumentSnapshot userSnap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .get();

      final Map<String, dynamic> userData =
          userSnap.data() as Map<String, dynamic>;

      await FirebaseFirestore.instance
          .collection('Resources')
          .doc(widget.resourceId)
          .collection('Comments')
          .add({
        'Author': userData['Name'] ?? '',
        'ImageUrl': userData['ProfileImage'] ?? '',
        'Comment': text,
        'time': FieldValue.serverTimestamp(),
      });

      commentController.clear();

      setState(() {
        commentsFuture = getComments(resourceId: widget.resourceId);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Comment posted!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to post comment: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => isPostingComment = false);
    }
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
        title: Text(
          'Resource Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPreviewCard(),
            SizedBox(height: 20),
            buildTitleAndTag(),
            SizedBox(height: 16),
            buildUploaderInfo(),
            SizedBox(height: 20),
            buildDescriptionSection(),
            SizedBox(height: 20),
            buildStatsCard(),
            SizedBox(height: 20),
            buildActionButtons(),
            SizedBox(height: 28),
            buildCommentsSection(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildPreviewCard() {
    return Container(
      width: double.infinity,
      height: 173,
      decoration: BoxDecoration(
        color: Color(0xFFF4F3F8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            size: 64,
            color: Color(0xFF352E60).withOpacity(0.5),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2E2A4A),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Open full preview',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitleAndTag() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.resource.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
            height: 1.2,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF352E60).withOpacity(0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFF352E60).withOpacity(0.1)),
          ),
          child: Text(
            widget.resource.category,
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

  Widget buildUploaderInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFE6D3BA),
          foregroundImage: AssetImage('assets/image.jpg'),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.resource.authorName,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              SizedBox(height: 2),
              Text(
                widget.resource.authorSchoolName,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'paragraph',
                  color: Color(0xFF352E60).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            style: TextStyle(fontFamily: 'paragraph'),
            children: [
              TextSpan(
                text: 'PDF  ',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1730),
                ),
              ),
              TextSpan(
                text: DateTime.now().difference(widget.resource.time).inDays < 1
                    ? '${DateTime.now().difference(widget.resource.time).inHours}h ago'
                    : '${DateTime.now().difference(widget.resource.time).inDays}d ago',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF352E60).withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1730),
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.resource.description,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'paragraph',
            color: Color(0xFF352E60).withOpacity(0.6),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget buildStatsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF352E60).withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Downloads',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1730),
                  ),
                ),
                Text(
                  widget.resource.downloads.toString(),
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
            color: Color(0xFF352E60).withOpacity(0.08),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Views',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1730),
                  ),
                ),
                Text(
                  widget.resource.views.toString(),
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

  Widget buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              onPressed: isDownloading ? null : handleDownload,
              icon: isDownloading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                      size: 22,
                    ),
              label: Text(
                isDownloading ? 'Downloading...' : 'Download',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8474F0),
                disabledBackgroundColor: Color(0xFF8474F0).withOpacity(0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFF352E60).withOpacity(0.1)),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
              color: Color(0xFF1A1730),
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCommentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Comments',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1730),
              ),
            ),
          ],
        ),
        SizedBox(height: 14),
        FutureBuilder<QuerySnapshot>(
          future: commentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Text(
                  'No comments yet. Be the first!',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'paragraph',
                    color: Color(0xFF352E60).withOpacity(0.5),
                  ),
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) => SizedBox(height: 12),
              itemBuilder: (context, index) => buildCommentCard(
                comment: Comment.fromMap(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>,
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFE6D3BA),
              foregroundImage: AssetImage('assets/image.jpg'),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 48,
                padding: EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: Color(0xFF352E60).withOpacity(0.04),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'paragraph',
                      color: Color(0xFF352E60).withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            isPostingComment
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF8474F0),
                    ),
                  )
                : IconButton(
                    onPressed: handlePostComment,
                    icon: Icon(
                      Icons.send_rounded,
                      color: Color(0xFF8474F0),
                      size: 26,
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Widget buildCommentCard({required Comment comment}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFE6D3BA),
          foregroundImage: AssetImage('assets/image.jpg'),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Color(0xFF352E60).withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1730),
                      ),
                    ),
                    Text(
                      DateTime.now().difference(comment.time).inDays < 1
                          ? '${DateTime.now().difference(comment.time).inHours}h ago'
                          : '${DateTime.now().difference(comment.time).inDays}d ago',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'paragraph',
                        color: Color(0xFF352E60).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  comment.comment,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'paragraph',
                    color: Color(0xFF352E60).withOpacity(0.6),
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
