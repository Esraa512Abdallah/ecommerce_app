import 'package:ecommerce_app/helper/constance.dart';
import 'package:flutter/material.dart';

class CustomeAppBar extends StatefulWidget{

  int indexVal = 0;

  CustomeAppBar(int indexVal
  );



  @override
  State<CustomeAppBar> createState() => _CustomeAppBarState(indexVal: indexVal);
}

class _CustomeAppBarState extends State<CustomeAppBar> {

  int indexVal = 0;
  _CustomeAppBarState({required this.indexVal} );

  int _tabBarIndex = 0;

  @override
  AppBar build(BuildContext context)  {
    // TODO: implement build

    return
       (indexVal == 0)?  AppBar(

        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(

          isScrollable: true,
          indicatorColor: PinkColor,
          onTap: (value) {
            setState(() {
              _tabBarIndex = value;
            });
          },
          tabs: <Widget>[
            Text(
              'Primer',
              style: TextStyle(
                color: _tabBarIndex == 0 ? TealColor : Teal2Color,
                fontSize: _tabBarIndex == 0 ? 20 : 16,
                fontWeight: _tabBarIndex == 0 ? FontWeight.bold : null,
              ),
            ),
            Text(
              'Eyeshadow',
              style: TextStyle(
                color: _tabBarIndex == 1 ? TealColor : Teal2Color,
                fontSize: _tabBarIndex == 1 ? 20 : 16,
                fontWeight: _tabBarIndex == 1 ? FontWeight.bold : null,
              ),
            ),
            Text(
              'Mascara',
              style: TextStyle(
                color: _tabBarIndex == 2 ? TealColor : Teal2Color,
                fontSize: _tabBarIndex == 2 ? 20 : 16,
                fontWeight: _tabBarIndex == 2 ? FontWeight.bold : null,
              ),
            ),
            Text(
              'Concealer',
              style: TextStyle(
                color: _tabBarIndex == 3 ? TealColor : Teal2Color,
                fontSize: _tabBarIndex == 3 ? 20 : 16,
                fontWeight: _tabBarIndex == 3 ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
      ):(indexVal == 1)?AppBar():(indexVal == 2)?AppBar():AppBar();




  }
}