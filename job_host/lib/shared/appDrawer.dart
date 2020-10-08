import 'package:flutter/material.dart';

Widget appDrawer(context) {
  var _currentRoute = ModalRoute.of(context).settings.name;

  dynamic routeProperties = {
    'home': {'title': 'Home', 'route': '/'},
    'user-profile': {'title': 'My Profile', 'route': '/user-profile'},
  };
  return SafeArea(
    child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: routeProperties.length,
              itemBuilder: (BuildContext context, int index) {
                String key = routeProperties.keys.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                  child: Container(
                    color: _currentRoute == routeProperties[key]['route']
                        ? Colors.greenAccent[100]
                        : Colors.white,
                    child: ListTile(
                      title: Text(routeProperties[key]['title']),
                      onTap: () {
                        // Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          routeProperties[key]['route'],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget appDrawer(context) {
//   var _currentRoute = ModalRoute.of(context).settings.name;

//   dynamic routeProperties = {
//     'home': {'title': 'Home', 'route': '/'},
//     'user-profile': {'title': 'User Profile', 'route': '/user-profile'},
//   };
//   return Drawer(
//     child: ListView(
//       padding: EdgeInsets.zero,
//       children: <Widget>[
//         DrawerHeader(
//           child: Text('Drawer Header'),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//           ),
//         ),
//         Container(
//           color: _currentRoute == '/' ? Colors.greenAccent[100] : Colors.white,
//           child: ListTile(
//             title: Text('Home'),
//             onTap: () {
//               // Navigator.pop(context);
//               Navigator.pushNamed(context, '/');
//             },
//           ),
//         ),
//         // Container(
//         //   color: Colors.white,
//         //   child: ListTile(
//         //     title: Text('My Profile'),
//         //     onTap: () {
//         //       Navigator.pushNamed(context, '/user-profile');
//         //     },
//         //   ),
//         // ),
//       ],
//     ),
//   );
// }
