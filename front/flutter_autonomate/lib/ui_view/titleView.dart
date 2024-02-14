import 'package:flutter/material.dart';
import 'package:flutter_autonomate/ui_view/autonomate_app_theme.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final VoidCallback? onTap;

  const TitleView({
    Key? key,
    required this.titleTxt,
    this.subTxt = "",
    this.animationController,
    this.animation,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Vérifie si l'animation est non null avant de l'utiliser.
    final Widget content = Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              titleTxt,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
                color: AutonomateAppTheme.darkerText,
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    subTxt,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: AutonomateAppTheme.nearlygrey,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: AutonomateAppTheme.nearlyBlue,
                    size: 18,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    // Utilise FadeTransition uniquement si animation n'est pas null, sinon retourne le contenu directement.
    return animation != null ? FadeTransition(opacity: animation!, child: content) : content;
  }
}
