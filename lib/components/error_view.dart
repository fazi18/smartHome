import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smart_home/theme/color/colors.dart';

class ErrorView extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onTryAgain;

  const ErrorView(
      {Key? key, required this.title, required this.subtitle, this.onTryAgain})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
              flex: 6,
              child: Image.asset(
                'assets/images/connection_lost.jpg',
                fit: BoxFit.fitHeight,
              )),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(.6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          if (onTryAgain != null)
            InkWell(
              onTap: onTryAgain,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    color: bulbOnColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}
