import 'package:app/app.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/navigation/desk_ui/theme_model_switch_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class UnitRailNavigation extends StatefulWidget {
  final ValueChanged<int> onItemClick;
  final int selectedIndex;
  final Map<String, IconData> itemData;

  const UnitRailNavigation(
      {Key? key,
      required this.onItemClick,
      required this.selectedIndex,
      required this.itemData})
      : super(key: key);

  @override
  State<UnitRailNavigation> createState() => _UnitRailNavigationState();
}

class _UnitRailNavigationState extends State<UnitRailNavigation>
    with TickerProviderStateMixin {
  late List<AnimationController> _destinationControllers;
  late List<Animation<double>> _destinationAnimations;

  List<String> get info => widget.itemData.keys.toList();

  List<IconData> get icons => widget.itemData.values.toList();

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _destinationControllers =
        List<AnimationController>.generate(widget.itemData.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });

    _destinationAnimations = _destinationControllers
        .map((AnimationController controller) => controller.view)
        .toList();
    _destinationControllers[widget.selectedIndex].value = 1.0;
  }

  void _rebuild() {
    setState(() {
      // Rebuilding when any of the controllers tick, i.e. when the items are
      // animating.
    });
  }

  @override
  void didUpdateWidget(UnitRailNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // No animated segue if the length of the items list changes.
    if (widget.itemData.length != oldWidget.itemData.length) {
      _resetState();
      return;
    }

    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _destinationControllers[oldWidget.selectedIndex].reverse();
      _destinationControllers[widget.selectedIndex].forward();
      return;
    }
  }

  void _resetState() {
    _disposeControllers();
    _initControllers();
  }

  void _disposeControllers() {
    for (final AnimationController controller in _destinationControllers) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
   Color? divColor = Theme.of(context).dividerTheme.color;
    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(right: 1),
        width: 130,
        decoration:  BoxDecoration(color: const Color(0xff2C3036), boxShadow: [
          BoxShadow(color: divColor!, offset: const Offset(1, 0), blurRadius: 2)
        ]),
        child: Column(
          children: [
            const Wrap(
              direction: Axis.vertical,
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CircleImage(
                  image: AssetImage('assets/images/icon_head.webp'),
                  size: 60,
                ),
                Text(
                  '张风捷特烈',
                  style: TextStyle(color: Colors.white70),
                )
              ],
            ),
            buildIcons(),
            const Divider(
              color: Colors.white,
              height: 1,
              endIndent: 20,
            ),
//          SizedBox(height: 60,),
            Expanded(
              flex: 5,
              child: Center(
                  //const Size(120, 35)
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: info
                    .asMap()
                    .keys
                    .map((int index) => _UnitRailMenu(
                          animation: _destinationControllers[index],
                          onTap: () {
                            widget.onItemClick.call(index);
                          },
                          selected: widget.selectedIndex == index,
                          width: 130,
                          height: 46,
                          activeColor: Theme.of(context).primaryColor,
                          inactiveColor: Colors.white.withAlpha(33),
                          icon: icons[index],
                          label: info[index],
                        ))
                    .toList(),
              )),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            const Divider(
              indent: 20,
              color: Colors.white,
              height: 1,
            ),

            Wrap(
              spacing: 12,
              children: [
                const ThemeModelSwitchIcon(),
                Builder(
                  builder: (ctx) => FeedbackWidget(
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 16, top: 16),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIcons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Wrap(
        spacing: 8,
        children: [
          FeedbackWidget(
            onPressed: () => _launchURL("http://blog.toly1994.com"),
            child: const Icon(
              TolyIcon.icon_item,
              color: Colors.white,
            ),
          ),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("https://github.com/toly1994328/FlutterUnit"),
            child: const Icon(
              TolyIcon.icon_github,
              color: Colors.white,
            ),
          ),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("https://juejin.im/user/5b42c0656fb9a04fe727eb37"),
            child: const Icon(
              TolyIcon.icon_juejin,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}

class _UnitRailMenu extends StatefulWidget {
  final VoidCallback onTap;
  final bool selected;
  final Color activeColor;
  final Color inactiveColor;
  final double width;
  final double height;
  final IconData icon;
  final String label;
  final Animation<double> animation;

   const _UnitRailMenu({
    Key? key,
    required this.onTap,
    required this.selected,
    required this.width,
    required this.activeColor,
    required this.inactiveColor,
    required this.height,
    required this.animation,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  State<_UnitRailMenu> createState() => _UnitRailMenuState();
}

class _UnitRailMenuState extends State<_UnitRailMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 10),
          child: AnimatedBuilder(
            animation: widget.animation,
            builder: (BuildContext context, Widget? child) => _buildItem(),
          ),
        ));
  }

  late ColorTween colorTween = ColorTween(begin: widget.inactiveColor, end: widget.activeColor);

  Widget _buildItem() {
    double iconSize = _sizeTween.transform(widget.animation.value);
    Color? color = colorTween.transform(widget.animation.value);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(widget.height / 2),
              bottomRight: Radius.circular(widget.height / 2))),
      width: _widthTween.transform(widget.animation.value) * widget.width,
      height: widget.height,
      child: Wrap(
        spacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: iconSize,
            color: widget.selected ? Colors.white : Colors.white70,
          ),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              color: widget.selected ? Colors.white : Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

final Tween<double> _widthTween = Tween(begin: 0.82, end: 0.95);
final Tween<double> _sizeTween = Tween(begin: 18.0, end: 20.0);
