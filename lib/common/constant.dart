import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget LoadingWidget(context) => Center(
  child: SpinKitThreeBounce(
    color: Theme.of(context).accentColor,
    size: 30.0,
  ),
);