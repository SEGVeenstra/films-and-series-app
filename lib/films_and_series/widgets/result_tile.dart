import 'package:films_and_series/films_and_series/models/search_result.dart';
import 'package:films_and_series/films_and_series/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ResultTile extends StatelessWidget {

  final Result _result;

  ResultTile(this._result);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(_result.title),
      subtitle: Text(_result.year),
      leading: Hero(
          flightShuttleBuilder:(
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ) {
        final Hero toHero = toHeroContext.widget;
        return ScaleTransition(
          scale: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0).chain(
              CurveTween(
                curve: Interval(0.0, 1.0,
                    curve: PeakQuadraticCurve()),
              ),
            ),
          ),
          child: flightDirection == HeroFlightDirection.push ?
              RotationTransition(turns:animation, child: toHero.child)
          :
              FadeTransition(
            opacity: animation.drive(
              Tween<double>(begin: 0.0, end: 1.0).chain(
                CurveTween(
                  curve: Interval(0.0, 1.0,
                      curve: PeakQuadraticCurve()),
                ),
              ),
            ),
            child: toHero.child,
          ),
        );
      }, tag: _result.id, child: Image.network(_result.poster, height: 60.0,)),
      trailing: _result.type == 'movie' ? Icon(Icons.movie) : Icon(Icons.tv),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(_result)));
      },
    );
  }


}

class PeakQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return -15 * math.pow(t, 2) + 15 * t + 1;
  }

}