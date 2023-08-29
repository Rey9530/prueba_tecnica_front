import 'package:flutter/material.dart';
import 'package:prueba_tecnica/src/pages/pages.dart';
import 'package:prueba_tecnica/src/utils/utils.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  static const List<Widget> _pages = <Widget>[
    InventarioPage(),
    ProductoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Prueba Técnica"),
      body: Center(
        child: _pages.elementAt(index), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.inventory,
            ),
            label: "Inventario",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Productos",
          ),
        ],
        onTap: (value) {
          index = value;
          setState(() {});
        },
      ),
    );
  }
}
