import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/widgets/profile_card_widget.dart';

class DialogTabbarNavigationbarCsutomWidgetTaskScreen extends StatefulWidget {
  const DialogTabbarNavigationbarCsutomWidgetTaskScreen({super.key});

  @override
  State<DialogTabbarNavigationbarCsutomWidgetTaskScreen> createState() =>
      _DialogTabbarNavigationbarCsutomWidgetTaskScreenState();
}

class _DialogTabbarNavigationbarCsutomWidgetTaskScreenState
    extends State<DialogTabbarNavigationbarCsutomWidgetTaskScreen>
    with TickerProviderStateMixin {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const snackBar = SnackBar(
            duration: Durations.short1,
            content: Text('You pressed on the snackbar button!'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Icon(Icons.radio_button_checked),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          print("$currentIndex is");
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "A"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "B"),
        ],
      ),
      body: SafeArea(
        child: switch (currentIndex) {
          0 => AScreen(),
          1 => BScrren(context),
          _ => Placeholder(),
        },
      ),
    );
  }
}

class AScreen extends StatefulWidget {
  const AScreen({super.key});

  @override
  State<AScreen> createState() => _AScreenState();
}

class _AScreenState extends State<AScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final maleProfileCards = [
    ProfileCard(
      name: "John Dave",
      isMale: true,
      username: "johndave",
      bio: "I love to travel a lot.",
      moreDescription: "I've travelled a lot of places.",
      imageURL:
          "https://t4.ftcdn.net/jpg/06/08/55/73/360_F_608557356_ELcD2pwQO9pduTRL30umabzgJoQn5fnd.jpg",
    ),

    ProfileCard(
      name: "Alex Costa",
      isMale: true,
      username: "alexcosta",
      bio: "I am a youtuber.",
      moreDescription: "I've a lot of subscribers in my youtube channel.",
      imageURL:
          "https://pbs.twimg.com/profile_images/1776266802684706816/c4tndfbA_400x400.jpg",
    ),
  ];

  final femaleProfileCards = [
    ProfileCard(
      name: "Allen Cara",
      isMale: false,
      username: "allencara",
      bio: "i love to cook and dance.",
      moreDescription: "I am a first price winner in America's got talent.",
      imageURL:
          "https://thumbs.dreamstime.com/b/profile-picture-young-indian-woman-renter-headshot-portrait-confident-tenant-pose-modern-own-new-apartment-house-226719004.jpg",
    ),

    ProfileCard(
      name: "Hanna Lancasters",
      isMale: false,
      username: "itshannh",
      bio: "I like to write.",
      moreDescription:
          "Sometimes I think a lot and couldn't able to write anything.",
      imageURL:
          "https://media.istockphoto.com/id/1320811419/photo/head-shot-portrait-of-confident-successful-smiling-indian-businesswoman.jpg?s=612x612&w=0&k=20&c=bCUTB8vd8MnzZFIq-x645-SmLNk2sQzOvOvWCPGDfZ4=",
    ),
  ];

  Widget showProfileCards(List<ProfileCard> profileCards) {
    return ListView.builder(
      itemCount: profileCards.length,
      itemBuilder: (context, index) {
        return profileCards[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar.secondary(
          controller: _tabController,
          tabs: [Tab(icon: Icon(Icons.male)), Tab(icon: Icon(Icons.female))],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              showProfileCards(maleProfileCards),
              showProfileCards(femaleProfileCards),
            ],
          ),
        ),
      ],
    );
  }
}

class BScrren extends StatelessWidget {
  final BuildContext context;
  const BScrren(this.context, {super.key});

  void showBottomSheet(int itemIndex) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Center(child: Text("This is the item number $itemIndex.")),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () => showBottomSheet(index),
            leading: Icon(Icons.person),
            title: Text("This is person ${index + 1}"),
            trailing: Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }
}
