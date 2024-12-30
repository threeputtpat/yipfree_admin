import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:yipfree_admin/views/screens/sidebar_screens/categories_screen.dart';
import 'package:yipfree_admin/views/screens/sidebar_screens/dashboard_screen.dart';
import 'package:yipfree_admin/views/screens/sidebar_screens/manage_banners_screen.dart';
import 'package:yipfree_admin/views/screens/sidebar_screens/orders_screen.dart';
import 'package:yipfree_admin/views/screens/sidebar_screens/products_screen.dart';
import 'package:yipfree_admin/views/screens/sidebar_screens/vendors_screen.dart';
import 'package:yipfree_admin/views/screens/sidebar_screens/withdraw_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

 Widget _selectedScreen = const DashboardScreen();


  screenSelector(item){
    switch (item.route) {
      case DashboardScreen.routeName:
      setState(() {
        _selectedScreen = const DashboardScreen();
      });

      break;

      case VendorsScreen.routeName:
      setState(() {
        _selectedScreen = const VendorsScreen();
      });

      break;

      case WithdrawScreen.routeName:
      setState(() {
        _selectedScreen = const WithdrawScreen();
      });

      break;

      case OrdersScreen.routeName:
      setState(() {
        _selectedScreen = const OrdersScreen();
      });

      break;

      case ProductsScreen.routeName:
      setState(() {
        _selectedScreen = const ProductsScreen();
      });

      break;

      case CategoriesScreen.routeName:
      setState(() {
        _selectedScreen = const CategoriesScreen();
      });

      break;

      case ManageBannersScreen.routeName:
      setState(() {
        _selectedScreen = const ManageBannersScreen();
      });

      break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: const Text('YipFree Admin'),
        backgroundColor: Colors.blue[100],
        ),
      backgroundColor: Colors.white,
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: '/DashboardScreen',
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Vendors',
            route: '/VendorsScreen',
            icon: Icons.person,
          ),
          AdminMenuItem(
            title: 'Withdraw',
            route: '/WithdrawScreen',
            icon: Icons.money,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: '/OrdersScreen',
            icon: Icons.shopping_cart_checkout,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: '/CategoriesScreen',
            icon: Icons.category,
          ),
          AdminMenuItem(
            title: 'Products',
            route: '/ProductsScreen',
            icon: Icons.golf_course,
          ),
          AdminMenuItem(
            title: 'Manage Banners',
            route: '/ManageBannersScreen',
            icon: Icons.flag,
          ),
        ], 
        selectedRoute: '', 
        onSelected: (item){
          screenSelector(item);
        },
      ),
      body: _selectedScreen,
      );
  }
}
