import 'package:activity_app/models/activity_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../global/global-variables.dart';

Row detailHeader(BuildContext context, EventItem eventItem) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: W(context) * 0.6,
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              eventItem!.name.toString(),
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${DateFormat("d MMMM", "tr_TR").format(DateTime.parse(eventItem.start.toString()))} \u00B7 "
              "${DateFormat.Hm().format(DateTime.parse(eventItem.start.toString()).toLocal())}",
              style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
      Container(
          padding: vertical8 + horizontal15,
          decoration: BoxDecoration(
              color: eventItem.isFree == true
                  ? Colors.green
                  : eventItem.isFree == false
                      ? Colors.red
                      : Colors.grey,
              borderRadius: border20),
          child: Text(
              eventItem.isFree == true
                  ? "Ücretsiz"
                  : eventItem.isFree == false
                      ? "Ücretli"
                      : "Bilinmiyor",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)))
    ],
  );
}
