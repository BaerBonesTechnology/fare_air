import 'package:fare_air/models/itinerary.dart';
import 'package:fare_air/presentation/widgets/itinerary_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItineraryWidget extends StatelessWidget {
  const ItineraryWidget({super.key, required this.itinerary});

  final Itinerary itinerary;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('hh:mm a');
    return Card(
      child: ListTile(
        leading: itinerary.legs.first.carriers?.marketing.isNotEmpty == true
            ? CircleAvatar(
                foregroundImage: NetworkImage(
                    itinerary.legs.first.carriers?.marketing.first.logoUrl ??
                        ''),
              )
            : null,
        title: Text.rich(
          TextSpan(
            text: 'From ${itinerary.legs.first.origin?.displayCode}',
            children: itinerary.legs
                .map((leg) => TextSpan(
                      text: ' -> ${leg.destination?.displayCode}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ))
                .toList(),
          ),
        ),
        subtitle: Text.rich(
          TextSpan(
            text:
                'Departing: ${dateFormat.format(itinerary.legs.first.departure ?? DateTime.now())}',
            children: [
              TextSpan(
                text:
                    ' Arriving: ${dateFormat.format(itinerary.legs.first.arrival ?? DateTime.now())}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(8),
          child: Text(
            '${itinerary.price?.formatted}',
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              enableDrag: true,
              showDragHandle: true,
              builder: (context) {
                return ItineraryDetailsWidget(itinerary: itinerary);
              });
        },
      ),
    );
  }
}
