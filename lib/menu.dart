import 'package:chess/routes.dart';
import 'package:flutter/material.dart';

class IMenuTitle {
  final String title;
  final String image;
  final VoidCallback callback;
  const IMenuTitle({required this.title, required this.image, required this.callback});
}


List<IMenuTitle> _titles = [
  IMenuTitle(title: "Play", 
  image: "assets/menu/button_play.png",
  callback: () {
    routers.goNamed(AppRoutes.game.name);
  }),
  // IMenuOption(title: "Two Players", callback: () => print("hello")),
  // IMenuOption(title: "Options", callback: () {}),
  // IMenuOption(title: "Quit", callback: () => SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop')),
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
          const MenuHeader(),
          Center(
            child: SizedBox(
              width: 250,
              child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _titles.length,
                    itemBuilder: (context, index) => MenuOption(option: _titles[index],),
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
  final IMenuTitle option;
  const MenuOption({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: option.callback,
      child: Image.asset(option.image, fit: BoxFit.contain,)
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MenuHeaderIcon(icon: "assets/menu/button_music.png", callback: () {}, ),
            const SizedBox(width: 10),
            MenuHeaderIcon(icon: "assets/menu/button_sound.png", callback: () {}, ),
            const Spacer(),
            MenuHeaderIcon(icon: "assets/menu/button_settings.png", callback: () {}, ),
          ],
        ),
      ),
    );
  }
}

class MenuHeaderIcon extends StatelessWidget {
  final String icon;
  final VoidCallback callback;
  const MenuHeaderIcon({super.key, required this.icon, required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Image.asset(icon, ),
    );
  }
}