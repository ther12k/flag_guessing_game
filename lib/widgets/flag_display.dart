import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagDisplay extends StatelessWidget {
  final String flagSrc;

  const FlagDisplay({Key? key, required this.flagSrc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SvgPicture.network(
          flagSrc,
          fit: BoxFit.cover,
          placeholderBuilder: (BuildContext context) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}