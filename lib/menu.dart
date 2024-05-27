import 'package:chess/const.dart';
import 'package:chess/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class IMenuTitle {
  final String title;
  final String image;
  final VoidCallback callback;
  const IMenuTitle({required this.title, this.image = "assets/menu/button_empty_5.png", required this.callback});
}


List<IMenuTitle> _titles = [
  IMenuTitle(title: "Play", 
  callback: () {
    routers.goNamed(AppRoutes.game.name);
  }),
  // IMenuOption(title: "Two Players", callback: () => print("hello")),
  // IMenuOption(title: "Options", callback: () {}),
  IMenuTitle(title: "Quit", callback: () => SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop')),
];

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with SingleTickerProviderStateMixin {

   late AnimationController parallexAnim;

  @override
  void initState() {
    parallexAnim = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
    );
    super.initState();
  }

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
          Expanded(
            child: Flow(delegate: BGParallexEffect(animation: parallexAnim), children: [
              Image.asset("assets/background/background.png"),
              Image.asset("assets/background/ground.png"),
            ],),
          )
        ],
      )
    );
  }
}

class BGParallexEffect extends FlowDelegate {

  final Animation<double> animation;
  BGParallexEffect({required this.animation}) : super(repaint: animation);
  @override
  void paintChildren(FlowPaintingContext context) {
    context.paintChild(0, transform: Matrix4.translation(Vector3(0,10,90)));
  }

  @override
  bool shouldRepaint(covariant BGParallexEffect oldDelegate) {
    return animation != oldDelegate.animation;
  }

}

class MenuOption extends StatelessWidget {
  final IMenuTitle option;
  const MenuOption({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: option.callback,
          child: Image.asset(option.image, fit: BoxFit.fitHeight, height: 70,)
        ),
        Text(option.title, style: const TextStyle(color: Menu.textColor, fontSize: 20),),
      ],
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