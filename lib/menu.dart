import 'package:chess/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IMenuOption {
  final String title;
  final VoidCallback callback;
  const IMenuOption({required this.title, required this.callback});
}


List<IMenuOption> options = [
  IMenuOption(title: "Play", callback: () {
    routers.goNamed(AppRoutes.game.name);
  }),
  // IMenuOption(title: "Two Players", callback: () => print("hello")),
  // IMenuOption(title: "Options", callback: () {}),
  IMenuOption(title: "Quit", callback: () => SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop')),
];

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              width: 250,
              child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (context, index) => MenuOption(option: options[index],),
                  ),
            ),
          ),
          const Spacer()
        ],
      )
    );
  }
}

class MenuOption extends StatelessWidget {
  final IMenuOption option;
  const MenuOption({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: option.callback,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                3.0,
                3.0,
              ),
              blurRadius: 1.0,
            )
          ]
        ),
        height: 50,
        child: Text(option.title),
      ),
    );
  }
}