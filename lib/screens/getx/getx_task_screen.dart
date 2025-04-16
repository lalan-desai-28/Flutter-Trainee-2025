import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/screens/getx/controllers/people_controller.dart';
import 'package:flutter_trainee_2025/screens/getx/person_add_update_screen.dart';
import 'package:get/get.dart';

import '../../models/person.dart';

class GetxTaskScreen extends StatefulWidget {
  const GetxTaskScreen({super.key});

  @override
  State<GetxTaskScreen> createState() => _GetxTaskScreenState();
}

class _GetxTaskScreenState extends State<GetxTaskScreen>
    with SingleTickerProviderStateMixin {
  final PeopleController _peopleController = Get.put(PeopleController());
  late final TabController _tabController = TabController(
    length: 2,
    vsync: this,
  );

  Widget _buildPersonCard(Person person, int index) {
    return Card(
      margin: EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          Get.to(
            PersonAddUpdateScreen(),
            arguments: {'isUpdating': true, 'oldPerson': person},
          )!.then((value) {
            if (value != null) _peopleController.updateAt(index, value);
          });
        },
        child: ListTile(
          leading: CircleAvatar(
            child:
                person.isFemale ?? false ? Icon(Icons.girl) : Icon(Icons.boy),
          ),
          title: Text(person.name),
          subtitle: Text(person.emailAddress),
          trailing: IconButton(
            onPressed: () {
              _peopleController.deleteAt(index);
            },
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(bool isFemaleList) {
    return Obx(() {
      final list =
          _peopleController.people
              .where((q) => q.isFemale == isFemaleList)
              .toList();
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _buildPersonCard(list[index], index);
        },
      );
    });
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(icon: Icon(Icons.male, size: 30), text: "Male"),
              Tab(icon: Icon(Icons.female, size: 30), text: "Female"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildListView(false), _buildListView(true)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.to(
          PersonAddUpdateScreen(),
          transition: Transition.rightToLeft,
        )?.then((value) {
          if (value != null) _peopleController.insert(value);
        });
      },
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
