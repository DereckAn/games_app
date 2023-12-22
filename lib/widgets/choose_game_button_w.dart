import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseGameButtonW extends StatelessWidget {
  const ChooseGameButtonW(
      {required this.gameName,
      required this.gameRoute,
      required this.routeSvg,
      super.key});
  final String gameName;
  final String gameRoute;
  final String routeSvg;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: const Color(0xFF1D1D1D),
      elevation: 10.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, gameRoute);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: OverflowBox(
                minWidth: 0.0,
                minHeight: 0.0,
                maxWidth: double.infinity,
                maxHeight: double.infinity,
                child: SvgPicture.asset(
                  routeSvg,
                  fit: BoxFit.fill,
                  width: 200,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                gameName,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
