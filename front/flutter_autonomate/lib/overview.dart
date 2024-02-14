import 'package:flutter/material.dart';
import 'package:flutter_autonomate/main.dart';
import 'package:flutter_autonomate/ui_view/autonomate_app_theme.dart';
import 'package:flutter_autonomate/ui_view/titleView.dart';
import 'package:flutter_autonomate/ui_view/overviewMailView.dart';
import 'package:flutter_autonomate/ui_view/overviewCalendarView.dart';
import 'package:flutter_autonomate/ui_view/overviewInvoiceView.dart';
import 'package:flutter_autonomate/ui_view/profile_screen.dart';


class OverviewScreen extends StatefulWidget {
  final AnimationController? animationController;

  const OverviewScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _OverviewScreenState createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

@override
void initState() {
  super.initState();
  final Animation<double> baseAnimation = CurvedAnimation(
    parent: widget.animationController!,
    curve: Curves.fastOutSlowIn,
  );

  // Initialisation des animations pour chaque vue d'aperçu
  Animation<double> mailViewAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(baseAnimation);
  Animation<double> calendarViewAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(baseAnimation);
  Animation<double> invoiceViewAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(baseAnimation);

  addAllListData(mailViewAnimation, calendarViewAnimation, invoiceViewAnimation);
}

  void addAllListData(Animation<double> mailViewAnimation, Animation<double> calendarViewAnimation, Animation<double> invoiceViewAnimation) {
    listViews.add(
      TitleView(
        titleTxt: 'Mail Overview',
        subTxt: 'Details',
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      OverviewMailView(
        animationController: widget.animationController,
        animation: mailViewAnimation,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Calendar Overview',
        subTxt: 'Details',
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      OverviewCalendarView(
        animationController: widget.animationController,
        animation: calendarViewAnimation,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Invoice Overview',
        subTxt: 'Details',
        animationController: widget.animationController,
      ),
    );

    listViews.add(
      OverviewInvoiceView(
        animationController: widget.animationController,
        animation: invoiceViewAnimation,
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return Container(
      color: AutonomateAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
                  backgroundColor: Colors.transparent, // Fond transparent pour l'AppBar
                  elevation: 0, // Aucune ombre
                  leading: Container(), // Retirer le bouton retour par défaut
                  centerTitle: true,
                  title: Image.asset('../assets/Autonomate_logo.png', height: 50), // Ajuste selon ton logo
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        iconSize: 30, // Ajuster la taille ici
                        icon: Icon(Icons.account_circle, color: AutonomateAppTheme.nearlygrey),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen(), // Assure-toi d'avoir un ProfileScreen
                          ));
                        },
                      ),
                    ),
                  ],
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Fond blanc pour l'AppBar
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),

        body: Stack(
          children: <Widget>[
            ListView.builder(
              controller: scrollController,
              itemCount: listViews.length,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24,
              ),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                widget.animationController?.forward();
                return listViews[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}