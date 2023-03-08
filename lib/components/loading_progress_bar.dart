import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingProgressBar extends StatelessWidget {
  const LoadingProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
