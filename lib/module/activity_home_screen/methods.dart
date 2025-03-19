import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../global/global-variables.dart';
import '../../models/activity_model.dart';

Container eventButtonContainer(BuildContext context, EventItem event) {
  return Container(
    height: H(context) * 0.23,
    margin: top10,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: border15),
          fixedSize: Size(W(context), H(context) * 0.15),
          padding: EdgeInsets.zero,
          elevation: 2),
      onPressed: () {
        // Todo: navigasyon eklenecek
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              bottom: 5,
              child: SizedBox(
                width: W(context) * 0.4,
                height: H(context) * 0.13,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    event.posterUrl.toString(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 10,
                right: 10,
                left: W(context) * 0.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
            Positioned(
                bottom: 5,
                left: W(context) * 0.43,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.mapLocationDot,
                          color: Colors.grey[800],
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${event.venue?.district?.name} / "
                          "${event.venue?.city?.name}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled_outlined,
                            color: Colors.grey[800], size: 20),
                        SizedBox(width: 5),
                        Text(
                          DateFormat.Hm().format(
                              DateTime.parse(event.start.toString()).toLocal()),
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Container(
                      padding: all8,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple, borderRadius: border15,
                      ),
                      child: Text(
                        DateFormat("d MMMM", "tr_TR")
                            .format(DateTime.parse(event.start.toString())),
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ),
  );
}
