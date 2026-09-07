import 'package:flutter/material.dart';
import 'package:notehive/widgets/leadingbackButton.dart';
import 'package:notehive/widgets/listTileForResources.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resources"),
      leading: LeadingBackButton(context),
        leadingWidth: 70,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: ListView.separated(
            shrinkWrap: true,
            //physics: const NeverScrollableScrollPhysics(),
            //padding: EdgeInsets.only(top: 45, bottom: 100, left: 20, right: 20),
            itemCount: 50,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {

              return ResourcesListTile(context:context,title: 'Data Structure - Unit 4',subtitle: 'CSE1203.Sem 5.Notes');
            },
          ))
    );
  }
}
