import 'package:flutter/material.dart';
import 'package:flutter_autonomate/ui_view/autonomate_app_theme.dart';

class OverviewInvoiceView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const OverviewInvoiceView({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation!,
      child: Container(
        height: 150,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AutonomateAppTheme.white,
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AutonomateAppTheme.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
              child: Text(
                "Mail Overview",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.27,
                  color: AutonomateAppTheme.darkerText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 12, top: 4, right: 24),
              child: Text(
                "Voir un aperçu de vos mails récents et non lus.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: AutonomateAppTheme.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
