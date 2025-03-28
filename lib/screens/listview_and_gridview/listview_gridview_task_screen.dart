import 'package:flutter/material.dart';

class ListviewAndGridviewTaskScreen extends StatefulWidget {
  const ListviewAndGridviewTaskScreen({super.key});

  @override
  State<ListviewAndGridviewTaskScreen> createState() =>
      _ListviewAndGridviewTaskScreenState();
}

class _ListviewAndGridviewTaskScreenState
    extends State<ListviewAndGridviewTaskScreen> {
  int _bottomNavigationCurrentIndex = 0;

  final List<String> _dummyUserList = [
    "Carmine Shuttlewood",
    "Georgiana Meritt",
    "Jelene Monnery",
    "Markos Charge",
    "Nicky Swainger",
    "Myca Allbrook",
    "Natalie Hakewell",
    "Kaja Silvester",
    "Paulette Champney",
    "Nina Burehill",
    "Scott Winton",
    "Candide Mixon",
    "Peter Piggott",
    "Gloria Hynam",
    "Jewel Cuerda",
    "Chucho Hughes",
    "Hetty Addicott",
    "Elroy Pentony",
    "Brandice Newns",
    "Kane Skitterel",
    "Craggie Bogies",
    "Nanon Axby",
    "Courtnay Sphinxe",
    "Veronike Sheran",
    "Laina Rankine",
    "Abie Sertin",
    "Dorthea Krammer",
    "Lucio Cauley",
    "Idell Le Fleming",
    "Deane Tulloch",
    "Nert Pepper",
    "Les Amis",
    "Paloma Bexley",
    "Donall Ozelton",
    "Cesya Walkingshaw",
    "Riordan Oates",
    "Xymenes Morad",
    "Darbie Doyley",
    "Ewell Olenikov",
    "Roley Hammarberg",
    "Virgie Labrone",
    "Sara Pittson",
    "Britt Kirwin",
    "Liza Fairholme",
    "Fitz Thick",
    "Elyse Harrold",
    "Durward Barbe",
    "Grenville Hibling",
    "Audrie Cabrera",
    "Kass Studdal",
  ];

  AppBar _buildHeader() {
    return AppBar(title: Text("Listview & Gridview"));
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future(
          () => setState(() {
            _dummyUserList.shuffle();
          }),
        );
      },
      child: switch (_bottomNavigationCurrentIndex) {
        0 => _buildListviewScreen(),
        1 => _buildGridviewScreen(),
        _ => Placeholder(),
      },
    );
  }

  void showSnackBar(String name) {
    final snackBar = SnackBar(
      content: Text('Hey 👋, I am $name.'),
      duration: Durations.short3,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildListviewScreen() {
    return ListView.builder(
      addRepaintBoundaries: true,
      itemExtent: 60,
      cacheExtent: 100,
      physics: PageScrollPhysics(),
      itemCount: _dummyUserList.length,
      itemBuilder: (context, index) {
        final name = _dummyUserList[index];
        return ListTile(
          key: Key(name),
          onTap: () => showSnackBar(name),
          trailing: Icon(Icons.arrow_forward),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(radius: 30, child: Text(name[0])),
          ),
          title: Text(name),
        );
      },
    );
  }

  Widget _buildGridviewScreen() {
    return GridView.builder(
      itemCount: _dummyUserList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        final name = _dummyUserList[index];
        return GestureDetector(
          onTap: () => showSnackBar(name),
          child: Card(
            key: Key(name),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(radius: 30, child: Text(name[0])),
                  SizedBox(height: 10),
                  Text(name, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _bottomNavigationCurrentIndex,
      onTap: (value) {
        setState(() {
          _bottomNavigationCurrentIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Listview'),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_on_rounded),
          label: 'Gridview',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildHeader(),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
    );
  }
}
