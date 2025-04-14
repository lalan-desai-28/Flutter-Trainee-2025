import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SliversTaskScreen extends StatefulWidget {
  const SliversTaskScreen({super.key});

  @override
  State<SliversTaskScreen> createState() => _SliversTaskScreenState();
}

class _SliversTaskScreenState extends State<SliversTaskScreen> {
  final GlobalKey<SliverAnimatedListState> _listKey = GlobalKey();
  final List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void initState() {
    super.initState();
  }

  void _insertNewItem() {
    setState(() {
      final index = _items.length;
      _items.add('Item ${index + 1}');
      _listKey.currentState?.insertItem(index);
    });
  }

  void _removeItem() {
    final index = _items.length - 1;
    final removedItem = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => FadeTransition(
        opacity: animation,
        child: _buildCardItem(removedItem),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: "Remove",
          onPressed: () => _removeItem(),
          child: Icon(Icons.remove),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          heroTag: "Add",
          key: Key("Add"),
          onPressed: () => _insertNewItem(),
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildCardItem(String text) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(child: ListTile(title: Text(text))),
      ),
    );
  }

  Widget _buildSilverAppBar() {
    return SliverAppBar.large(
      leading: Icon(
        Icons.local_grocery_store_outlined,
        size: 30,
        color: Colors.white,
      ),
      actions: [
        Row(
          spacing: 10,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.home),
            ),
            CircleAvatar(child: Icon(Icons.notifications)),
          ],
        ),
      ],

      title: SizedBox(
        height: 40,
        child: SearchBar(
          backgroundColor: WidgetStateProperty.all<Color>(
            Colors.white,
          ),
          hintText: "Search...",
          leading: Icon(Icons.search),
        ),
      ),

      actionsPadding: const EdgeInsets.only(right: 10),
      pinned: true,
      floating: true,
      snap: false,

      backgroundColor: Colors.black,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),

      collapsedHeight: 100,
      expandedHeight: 250,

      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        background: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              right: -90,
              left: 0,
              child: Image.network(
                fit: BoxFit.cover,
                "https://img.freepik.com/premium-photo/tropical-fruits-passion-fruit-pineapple-dragon-fruit-kiwi-cactus-black-background-top-view-free-space-text_756748-57611.jpg",
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning! Lalan Desai 👋",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Text(
                      "Do you need any help?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesListView() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Services",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return SizedBox(height: 100, width: 100, child: Card());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSilverAnimatedList() {
    return SliverAnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: _buildCardItem("Item ${index + 1}"),
        );
      },
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        _buildSilverAppBar(),
        _buildServicesListView(),
        SliverPersistentHeader(pinned: true, delegate: _MyHeaderDelegate()),
        _buildSilverAnimatedList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}

class _MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: 100,
      child: Card(
        color: Colors.blue,
        child: Center(
          child: ListTile(
            title: Text(
              "Ready to hire?",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            trailing: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                alignment: Alignment.center,
              ),
              onPressed: () {},
              child: Text("Get Started", style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
