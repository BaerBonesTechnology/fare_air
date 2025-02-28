import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/itinerary.dart';

class ItineraryDetailsWidget extends StatelessWidget {
  const ItineraryDetailsWidget({super.key, required this.itinerary});

  final Itinerary itinerary;

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MM/dd/yy hh:mm a');
    return Container(
      width: MediaQuery.sizeOf(context).width > 600
          ? null
          : MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text('Itinerary Details')),
          Center(
            child:
                itinerary.legs.first.carriers?.marketing.first.logoUrl != null
                    ? CircleAvatar(
                        foregroundImage: NetworkImage(itinerary
                                .legs.first.carriers?.marketing.first.logoUrl ??
                            ''),
                      )
                    : null,
          ),
          RichText(
              text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
            ),
            text: 'From ${itinerary.legs.first.origin?.displayCode}',
            children: itinerary.legs
                .map((leg) => TextSpan(
                      text: ' -> ${leg.destination?.displayCode}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ))
                .toList(),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Price: ${itinerary.price?.formatted}'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              itinerary.legs.first.departure != null
                  ? Text(
                      'Departure: ${dateFormat.format(itinerary.legs.first.departure ?? DateTime.now())}')
                  : const Text('Error loading departure time'),
              itinerary.legs.first.arrival != null
                  ? Text(
                      'Arrival: ${dateFormat.format(itinerary.legs.last.arrival ?? DateTime.now())}')
                  : const Text('Error loading arrival time'),
            ],
          ),
          ExpansionTile(
            title: const Text('Legs'),
            children: List.generate(
              itinerary.legs.length,
              (index) {
                final leg = itinerary.legs[index];
                return Column(
                  children: [
                    Text(
                        'Leg ${index + 1}: ${leg.origin?.displayCode} -> ${leg.destination?.displayCode}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'Departure: ${dateFormat.format(leg.departure ?? DateTime.now())}'),
                        Text(
                            'Arrival: ${dateFormat.format(leg.arrival ?? DateTime.now())}'),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
