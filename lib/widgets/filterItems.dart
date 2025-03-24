import 'package:flutter/material.dart';
import '../global/global-variables.dart';

class FilterItemsContainer extends StatelessWidget {
  final String text;
  final String? subtext;
  final Widget widget;
  final VoidCallback? onTap;

  const FilterItemsContainer(
      {super.key,
      required this.text,
      required this.widget,
      this.onTap,
      this.subtext});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: W(context),
      height: H(context) * 0.08,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: horizontal10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subtext != null && subtext!.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        Text(
                          subtext ?? "",
                          style:
                              TextStyle(fontSize: 11, color: Colors.deepOrange),
                        ),
                      ],
                    )
                  : Text(text,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
