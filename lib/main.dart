import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(TabbedApp());

class TabbedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabbed App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabbedScreen(),
    );
  }
}

class TabbedScreen extends StatefulWidget {
  @override
  _TabbedScreenState createState() => _TabbedScreenState();
}

class _TabbedScreenState extends State<TabbedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToPage(int pageIndex) {
    setState(() {
      _tabController.animateTo(pageIndex);
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabbed App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Page 1'),
              onTap: () => _navigateToPage(0),
            ),
            ListTile(
              title: Text('Page 2'),
              onTap: () => _navigateToPage(1),
            ),
            ListTile(
              title: Text('Page 3'),
              onTap: () => _navigateToPage(2),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PageWidget(pageIndex: 0),
          PageWidget(pageIndex: 1),
          PageWidget(pageIndex: 2),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (int index) => _navigateToPage(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Page 3',
          ),
        ],
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final int pageIndex;

  const PageWidget({Key? key, required this.pageIndex}) : super(key: key);

  Color getFloatingActionButtonColor(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: getFloatingActionButtonColor(pageIndex),
        child: Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          'Page ${pageIndex + 1}',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}