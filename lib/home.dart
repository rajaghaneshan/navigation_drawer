import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    onPageChanged(int pageIndex) {
      setState(() {
        this.pageIndex = pageIndex;
      });
    }

    //Page navigation with animation
    onTap(int pageIndex) {
      _pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }

    //Drawer navigates to page and closes
    drawerNavigate(int index) {
      onTap(index);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Page ${pageIndex + 1}'),
        centerTitle: true,
      ),
      //Drawer menu
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            DrawerItems(
              pageIndex: pageIndex,
              pageNumber: 'One',
              currentIndex: 0,
              onTap: () => drawerNavigate(0),
            ),
            DrawerItems(
              pageIndex: pageIndex,
              pageNumber: 'Two',
              currentIndex: 1,
              onTap: () => drawerNavigate(1),
            ),
            DrawerItems(
              pageNumber: 'Three',
              currentIndex: 2,
              pageIndex: pageIndex,
              onTap: () => drawerNavigate(2),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: [
          PageContainer(
              goToPage: 2, color: Colors.red, function: () => onTap(1)),
          PageContainer(
              goToPage: 3, color: Colors.yellow, function: () => onTap(2)),
          PageContainer(
              goToPage: 1, color: Colors.greenAccent, function: () => onTap(0)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

//Drawer items 
class DrawerItems extends StatelessWidget {
  const DrawerItems({
    Key? key,
    required this.pageIndex,
    required this.onTap,
    required this.pageNumber,
    required this.currentIndex,
  }) : super(key: key);

  final int pageIndex;
  final int currentIndex;
  final String pageNumber;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Page $pageNumber',
        style: TextStyle(
          color: pageIndex == currentIndex ? Colors.red : Colors.black54,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}

//Pages i.e. Screens
class PageContainer extends StatelessWidget {
  final int goToPage;
  final Color color;
  final VoidCallback function;

  const PageContainer({
    Key? key,
    required this.goToPage,
    required this.color,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: ElevatedButton(
          child: Text('Go to Page $goToPage'),
          onPressed: function,
        ),
      ),
    );
  }
}
