import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../global/global-variables.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: horizontal10,
          width: W(context) * 0.75,
          height: H(context) * 0.06,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search_outlined),
                iconColor: Colors.grey.shade400,
                hintText: "Arama yapın...",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade400,
                )),
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize:
                Size(H(context) * 0.06, H(context) * 0.06),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side:
                    BorderSide(color: Colors.grey.shade400, width: 1.5)),
                backgroundColor: Colors.white,
                elevation: 0
            ),
            onPressed: () {},
            child: FaIcon(FontAwesomeIcons.sliders, color: Colors.black))
      ],
    );
  }
}