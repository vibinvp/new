import 'package:flutter/material.dart';
import 'package:paystome/helper/core/color_constant.dart';
import 'package:paystome/helper/storage/local_storage.dart';
import 'package:paystome/model/Refferal/network_model.dart';

class ReferredUsersTreeScreen extends StatefulWidget {
  final List<ReferredUsersTree> referredUsersTree;

  const ReferredUsersTreeScreen({super.key, required this.referredUsersTree});

  @override
  State<ReferredUsersTreeScreen> createState() =>
      _ReferredUsersTreeScreenState();
}

class _ReferredUsersTreeScreenState extends State<ReferredUsersTreeScreen> {
  String name = 'You';

  void getName()async {
    var code = await LocalStorage.getNameSF();
    setState(() {
      name = code??'';
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColoring.kAppWhiteColor),
        backgroundColor: AppColoring.kAppColor,
        title: const Text(
          'Referred Users Tree',
          style: TextStyle(fontSize: 20, color: AppColoring.kAppWhiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              leading: CircleAvatar(
                radius: 20,
                child: Text(name.toString().substring(0, 1).toUpperCase()),
              ),
              title: Text(name),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: refferalList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget refferalList() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.referredUsersTree.length,
        itemBuilder: (context, index) {
          return _buildTree(widget.referredUsersTree[index]);
        });
  }

  Widget _buildTree(ReferredUsersTree tree) {
    return ExpansionTile(
      leading: CircleAvatar(
        child: Text(tree.title.toString().substring(0, 1).toUpperCase()),
      ),
      title: Text(tree.title ?? ''),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildChildrenTree(tree),
          ),
        ),
      ],
    );
  }

  Widget _buildChildrenTree(ReferredUsersTree tree) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tree.children?.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          leading: CircleAvatar(
            child: Text(
                tree.children![index].title.toString().substring(0, 1).toUpperCase()),
          ),
          title: Text(tree.children![index].title ?? ''),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildChildrenTree(
                    tree.children![index]), // Pass the child tree
              ),
            ),
          ],
        );
      },
    );
  }
}
