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
            itemCount: 20,
            separatorBuilder: (context,index)=>SizedBox(height: 10,),
            itemBuilder: (context,index)=>ResourcesListTile(title: 'title', subtitle: 'subtitle'),)),
    );
  }
}
