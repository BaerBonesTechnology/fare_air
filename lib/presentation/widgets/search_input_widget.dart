import 'dart:math' as math;

import 'package:fare_air/constants/defaults.dart';
import 'package:fare_air/models/content/bottom_sheet_content.dart';
import 'package:fare_air/presentation/widgets/search_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../models/content/home_screen_content.dart';
import '../di/content_providers/content_providers.dart';

class TripSearchInputWidget extends ConsumerStatefulWidget {
  const TripSearchInputWidget({
    super.key,
  });

  @override
  ConsumerState createState() => _SearchInputWidgetState();
}

class _SearchInputWidgetState extends ConsumerState<TripSearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    final FocusNode originFocusNode = FocusNode();
    final FocusNode destinationFocusNode = FocusNode();

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
                DateTime.now().copyWith(day: DateTime.now().day + 15)));

    final returnDateController = TextEditingController(
        text: dateFormat.format(
            ref.watch(homeScreenNotifierProvider).value?.returnDate ??
                DateTime.now().copyWith(day: DateTime.now().day + 22)));

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
                canRequestFocus: false,
                onTap: () async {
                  await ref
                      .watch(bottomSheetNotifierProvider.notifier)
                      .updateBottomSheetContent(BottomSheetContent(
                        controller: originTextController,
                      ));

                  showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      enableDrag: true,
                      builder: (_) => const SearchBottomSheet(
                            tag: originTag,
                          ));

                  originFocusNode.canRequestFocus
                      ? originFocusNode.requestFocus()
                      : () {};
                },
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
                onTap: () async {
                  await ref
                      .read(bottomSheetNotifierProvider.notifier)
                      .updateBottomSheetContent(BottomSheetContent(
                        controller: destinationTextController,
                      ));

                  if (context.mounted) {
                    showBottomSheet(
                        context: context,
                        showDragHandle: true,
                        enableDrag: true,
                        builder: (_) => const SearchBottomSheet(
                              tag: destinationTag,
                            ));
                  }
                  destinationFocusNode.canRequestFocus
                      ? destinationFocusNode.requestFocus()
                      : () {};
                },
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
