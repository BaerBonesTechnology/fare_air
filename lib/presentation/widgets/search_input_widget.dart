import 'dart:math' as math;

import 'package:fare_air/presentation/di/providers/core_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TripSearchInputWidget extends ConsumerStatefulWidget {
  const TripSearchInputWidget({
    super.key,
    required this.originFocusNode,
    required this.destinationFocusNode,
    this.onSearchOriginTap,
    this.onSearchDestinationTap,
    this.initialSearchLocation,
  });

  final FocusNode originFocusNode;
  final FocusNode destinationFocusNode;
  final Function()? onSearchOriginTap;
  final Function()? onSearchDestinationTap;
  final String? initialSearchLocation;

  @override
  ConsumerState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends ConsumerState<TripSearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchService = ref.watch(airportServiceControllerProvider)?.state;
    final originTextController =
        TextEditingController(text: widget.initialSearchLocation ?? '');
    final destinationTextController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: TextField(
                controller: originTextController,
                enabled: true,
                onTap: widget.onSearchOriginTap,
                decoration: InputDecoration(
                  label: Row(
                    children: [
                      Transform.rotate(
                          angle: 45 * math.pi / 180,
                          child: const Icon(Icons.airplanemode_on_outlined)),
                      const Text('Origin'),
                    ],
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Origin',
                ),
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextField(
                controller: destinationTextController,
                enabled: true,
                onTap: widget.onSearchDestinationTap,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Destination',
                    label: Row(
                      children: [
                        Transform.rotate(
                            angle: 135 * math.pi / 180,
                            child: const Icon(Icons.airplanemode_on_outlined)),
                        const Text('Destination'),
                      ],
                    )),
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Departure Date',
                      label: Text('Departure Date'),
                    ),
                    onTap: () {
                      showDatePicker(
                          context: context,
                          firstDate: DateTime.now().copyWith(
                            day: DateTime.now().day - 15,
                          ),
                          lastDate: DateTime.now().copyWith(
                            day: DateTime.now().year + 2,
                          ),
                          initialDate: DateTime.now().copyWith(
                            day: DateTime.now().day + 15,
                          )).then((value) {
                        debugPrint('Selected date: $value');
                      });
                      // TODO: if departure date is set to before departure date, show error
                      // TODO: departure date is MANDATORY
                    },
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 3,
                  child: TextField(
                    onTap: () {
                      // TODO: Show date picker
                      // TODO: if return date is set to before departure date, show error
                      // TODO: if return date is not set do not populate the return date
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Return Date',
                      label: Text('Return Date'),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 1,
                child: DropdownMenu(
                  label: const Text('Adults'),
                  initialSelection: 1,
                  dropdownMenuEntries: List.generate(10, (index) {
                    return DropdownMenuEntry(
                      value: index,
                      label: index.toString(),
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 1,
                child: DropdownMenu(
                  label: const Text('Children'),
                  initialSelection: 0,
                  onSelected: (value) {
                    debugPrint('Selected $value');
                  },
                  dropdownMenuEntries: List.generate(10, (index) {
                    return DropdownMenuEntry(
                      value: index,
                      label: index.toString(),
                    );
                  }),
                ),
              ),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('Search button pressed');
                  },
                  child: const Text('Search'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
