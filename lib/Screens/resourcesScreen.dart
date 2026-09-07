import 'package:flutter/material.dart';
import 'package:notehive/widgets/leadingbackButton.dart';
import 'package:notehive/widgets/listTileForResources.dart';

class ResourcesScreen extends StatefulWidget {
  final String? filtered;
  const ResourcesScreen({super.key, this.filtered});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  List<String> categories = [
    "All",
    "Science",
    "Math",
    "English",
    "History",
    "Programming",
    "Physics",
  ];
  late String filtered;
  @override
  void initState() {
    if (widget.filtered != null) {
      filtered = " - ${widget.filtered}";
    } else {
      filtered = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources $filtered"),
        leading: LeadingBackButton(context),
        leadingWidth: 70,
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list),
            style: IconButton.styleFrom(
              backgroundColor: Color(0xff8474F0),
              foregroundColor: Colors.white,
            ),
            onSelected: (String value) {
              setState(() {
                filtered=" - $value";
              });

            },
            itemBuilder: (BuildContext context) {
              return categories.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.separated(
          shrinkWrap: true,
          //physics: const NeverScrollableScrollPhysics(),
          //padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
          itemCount: 50,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            return ResourcesListTile(
              context: context,
              title: 'Data Structure - Unit 4',
              subtitle: 'CSE1203.Sem 5.Notes',
            );
          },
        ),
      ),
    );
  }
}
