import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: Colors.blueGrey, child: ListView.builder(itemBuilder: (context, index) => MenuOption(),),);
  }
}

class MenuOption extends StatelessWidget {
  const MenuOption({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}