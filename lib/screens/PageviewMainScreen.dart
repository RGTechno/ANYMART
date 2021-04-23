import 'package:anybuy/screens/Home_Screen.dart';
import 'package:anybuy/screens/Profile_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewMainScreen extends StatefulWidget {
  @override
  _PageViewMainScreenState createState() => _PageViewMainScreenState();
}

class _PageViewMainScreenState extends State<PageViewMainScreen> {
  PageController _pageController;

  int pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }

  void _pageChangeFn(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  void _onTap(int pageIndex) {
    setState(() {
      _pageController.animateToPage(
        pageIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          ProfileScreen(),
        ],
        controller: _pageController,
        onPageChanged: _pageChangeFn,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            label: "Account",
            icon: Icon(Icons.person_outline_rounded),
          ),
        ],
      ),
    );
  }
}
