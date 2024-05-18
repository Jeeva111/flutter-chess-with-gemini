import 'package:flutter/material.dart';

interface class IMenuOption {
  final String title;
  final VoidCallback callback;
  const IMenuOption({required this.title, required this.callback});
}

List<IMenuOption> options = [
  IMenuOption(title: "Play", callback: () {}),
  IMenuOption(title: "Two Players", callback: () {})
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: options.length,
              itemBuilder: (context, index) => MenuOption(option: options[index],),
            ),
      )
    );
  }
}

class MenuOption extends StatelessWidget {
  final IMenuOption option;
  const MenuOption({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Text(option.title),
    );
  }
}