import 'dart:math' as math;

import 'package:fare_air/constants/defaults.dart';
import 'package:fare_air/presentation/controllers/home_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../di/content_providers/content_providers.dart';
import '../../models/content/home_screen_content.dart';

class TripSearchInputWidget extends ConsumerStatefulWidget {
  const TripSearchInputWidget({
    super.key,
    required this.controller,
  });

  final HomeStateController controller;

  @override
  ConsumerState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends ConsumerState<TripSearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final originTextController = TextEditingController(
        text: ref
                .watch(homeScreenNotifierProvider)
                .value
                ?.initialSearchLocation ??
            '');
    final destinationTextController = TextEditingController(
        text: ref
                .watch(homeScreenNotifierProvider)
                .value
                ?.departureSearchLocation ??
            '');
    final departureDateController = TextEditingController(
        text: dateFormat.format(
            ref.watch(homeScreenNotifierProvider).value?.departureDate ??
                DateTime.now()));
    final returnDateController = TextEditingController(
        text: ref.watch(homeScreenNotifierProvider).value?.returnDate != null
            ? dateFormat.format(
                ref.watch(homeScreenNotifierProvider).value?.returnDate ??
                    DateTime.now())
            : '');

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
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
                canRequestFocus: false,
                onTap: () =>
                    widget.controller.openBottomSheet(context, ref, originTag),
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
                canRequestFocus: false,
                readOnly: true,
                onTap: () => widget.controller
                    .openBottomSheet(context, ref, destinationTag),
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
          ), // Location Row
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: TextField(
                    controller: departureDateController,
                    canRequestFocus: false,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Departure Date',
                      label: Text('Departure Date'),
                    ),
                    onTap: () async {
                      await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().copyWith(
                                day: DateTime.now().year + 2,
                              ),
                              initialDate: ref
                                      .watch(homeScreenNotifierProvider)
                                      .value
                                      ?.departureDate ??
                                  DateTime.now().copyWith(
                                    day: DateTime.now().day + 15,
                                  ))
                          .then((value) {
                        debugPrint('Selected date: $value');
                        ref
                            .watch(homeScreenNotifierProvider.notifier)
                            .updateHomeScreenContent(ref
                                    .watch(homeScreenNotifierProvider)
                                    .value
                                    ?.copyWith(
                                      departureDate: value,
                                    ) ??
                                HomeScreenContent.empty());
                      });
                    },
                  )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 3,
                  child: TextField(
                    controller: returnDateController,
                    canRequestFocus: false,
                    onTap: () {
                      showDatePicker(
                              selectableDayPredicate: (day) {
                                return day.isAfter(ref
                                        .watch(homeScreenNotifierProvider)
                                        .value
                                        ?.departureDate ??
                                    DateTime.now());
                              },
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().copyWith(
                                day: DateTime.now().year + 2,
                              ),
                              initialDate: ref
                                      .watch(homeScreenNotifierProvider)
                                      .value
                                      ?.returnDate ??
                                  DateTime.now().copyWith(
                                    day: DateTime.now().day + 22,
                                  ))
                          .then((value) {
                        debugPrint('Selected date: $value');

                        ref
                            .watch(homeScreenNotifierProvider.notifier)
                            .updateHomeScreenContent(ref
                                    .watch(homeScreenNotifierProvider)
                                    .value
                                    ?.copyWith(
                                      returnDate: value,
                                    ) ??
                                HomeScreenContent.empty());
                      });
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Return Date',
                      label: Text('Return Date'),
                    ),
                  )),
            ],
          ), // Date Row
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
                    onSelected: (value) async => await widget.controller
                        .updateAdultsCount(ref, value ?? 0)),
              ),
              Expanded(
                flex: 1,
                child: DropdownMenu(
                  label: const Text('Children'),
                  initialSelection: 0,
                  onSelected: (value) async => await widget.controller
                      .updateChildrenCount(ref, value ?? 0),
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
                  onPressed: () async =>
                      await widget.controller.searchForFlights(ref),
                  child: const Text('Search'),
                ),
              )
            ],
          ) // Passenger and Search Button Row
        ],
      ),
    );
  }
}
