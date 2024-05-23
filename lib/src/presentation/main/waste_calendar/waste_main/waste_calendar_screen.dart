// // ignore_for_file: unnecessary_null_comparison, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'cubit/waste_calendar_cubit.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

// class WasteCalendar extends StatefulWidget {
//   const WasteCalendar({super.key});

//   @override
//   _WasteCalendarState createState() => _WasteCalendarState();
// }

// class _WasteCalendarState extends State<WasteCalendar> {
//   DateTime _selectedDay = DateTime.now();
//   DateTime _focusedDay = DateTime.now();
//   String _selectedLocation = 'Street 1'; // Default location

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => WasteCalendarCubit()..loadWasteCollections(),
//       child: MaterialApp(
//         theme: ThemeData.light(),
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text(_selectedLocation),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context); // Back button functionality
//               },
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.edit, color: Colors.white),
//                 onPressed: () {
//                   _showLocationDialog(context);
//                 },
//               ),
//             ],
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: 200,
//                     child: Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(15.0),
//                           child: Opacity(
//                             opacity: 0.3,
//                             child: Image.asset(
//                               "assets/images/garbage.jpg",
//                               fit: BoxFit.cover,
//                               width: double.infinity,
//                               height: double.infinity,
//                             ),
//                           ),
//                         ),
//                         Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "${_selectedDay.day} ${_selectedDay.monthName()}",
//                                 style: const TextStyle(
//                                     fontSize: 22, color: Colors.red),
//                               ),
//                               Text(
//                                 _selectedDay.weekdayName(),
//                                 style: const TextStyle(
//                                     fontSize: 32, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text("Nächste Abholungen",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
//                     builder: (context, state) {
//                       if (state is WasteCalendarLoading) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (state is WasteCalendarLoaded) {
//                         return SizedBox(
//                           height: 120,
//                           child: ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: state.collections.length,
//                             itemBuilder: (context, index) {
//                               return _buildWasteCard(state.collections[index]);
//                             },
//                           ),
//                         );
//                       } else if (state is WasteCalendarError) {
//                         return Center(child: Text('Error: ${state.error}'));
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   _buildCalendar(),
//                   const SizedBox(height: 20),
//                   Text(
//                       "Abholungen für ${_selectedDay.day}.${_selectedDay.month}.${_selectedDay.year}",
//                       style: const TextStyle(
//                           fontSize: 18, fontWeight: FontWeight.bold)),
//                   BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
//                     builder: (context, state) {
//                       if (state is WasteCalendarLoaded) {
//                         final collectionsForSelectedDay = state.collections
//                             .where((collection) =>
//                                 isSameDay(collection.date, _selectedDay))
//                             .toList();
//                         if (collectionsForSelectedDay.isEmpty) {
//                           return const Text(
//                               "Keine Abholungen für den ausgewählten Tag verfügbar");
//                         }
//                         return Column(
//                           children: collectionsForSelectedDay
//                               .map((collection) => ListTile(
//                                     leading: Icon(Icons.delete,
//                                         color:
//                                             _getColorForType(collection.type)),
//                                     title: Text(collection.type),
//                                   ))
//                               .toList(),
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     },
//                   ),
//                   const Padding(
//                       padding: EdgeInsets.only(
//                           bottom: 100)), // Ensure padding at the bottom
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getColorForType(String type) {
//     switch (type) {
//       case 'Gelbe Tonne':
//         return Colors.yellow;
//       case 'Biotonne':
//         return Colors.green;
//       case 'Restmüll':
//         return Colors.grey;
//       default:
//         return Colors.white;
//     }
//   }

//   Widget _buildWasteCard(WasteCollection collection) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0),
//       ),
//       child: Container(
//         width: 120,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.delete,
//               color: _getColorForType(collection.type),
//               size: 30,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               collection.type,
//               style: const TextStyle(color: Colors.black, fontSize: 14),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               '${collection.date.day}.${collection.date.month}.${collection.date.year}',
//               style: const TextStyle(color: Colors.black, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCalendar() {
//     return BlocBuilder<WasteCalendarCubit, WasteCalendarState>(
//       builder: (context, state) {
//         if (state is WasteCalendarLoaded) {
//           final events = {
//             for (var item in state.collections)
//               DateTime(item.date.year, item.date.month, item.date.day): state
//                   .collections
//                   .where((e) => isSameDay(e.date, item.date))
//                   .toList()
//           };

//           return TableCalendar(
//             firstDay: DateTime.utc(2020, 10, 16),
//             lastDay: DateTime.utc(2030, 3, 14),
//             focusedDay: _focusedDay,
//             selectedDayPredicate: (day) {
//               return isSameDay(_selectedDay, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               setState(() {
//                 _selectedDay = selectedDay;
//                 _focusedDay = focusedDay;
//               });
//             },
//             calendarFormat: CalendarFormat.month,
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             calendarStyle: const CalendarStyle(
//               defaultTextStyle: TextStyle(color: Colors.black),
//               weekendTextStyle: TextStyle(color: Colors.red),
//               todayDecoration: BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//               selectedDecoration: BoxDecoration(
//                 color: Colors.orange,
//                 shape: BoxShape.circle,
//               ),
//               markerDecoration: BoxDecoration(
//                 color: Colors.black,
//                 shape: BoxShape.circle,
//               ),
//               markersMaxCount: 3,
//             ),
//             headerStyle: const HeaderStyle(
//               titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
//               formatButtonVisible: false,
//               leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
//               rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
//             ),
//             daysOfWeekStyle: const DaysOfWeekStyle(
//               weekdayStyle: TextStyle(color: Colors.black),
//               weekendStyle: TextStyle(color: Colors.red),
//             ),
//             eventLoader: (day) {
//               return events[day] ?? [];
//             },
//             calendarBuilders: CalendarBuilders(
//               markerBuilder: (context, date, events) {
//                 if (events.isEmpty) return const SizedBox();
//                 return Positioned(
//                   bottom: 1,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: events.map((event) {
//                       if (event is WasteCollection) {
//                         return Container(
//                           width: 7,
//                           height: 7,
//                           margin: const EdgeInsets.symmetric(horizontal: 1.5),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: event.type != null
//                                 ? _getColorForType(event.type)
//                                 : Colors.black,
//                           ),
//                         );
//                       }
//                       return const SizedBox();
//                     }).toList(),
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//         return TableCalendar(
//           firstDay: DateTime.utc(2020, 10, 16),
//           lastDay: DateTime.utc(2030, 3, 14),
//           focusedDay: _focusedDay,
//           selectedDayPredicate: (day) {
//             return isSameDay(_selectedDay, day);
//           },
//           onDaySelected: (selectedDay, focusedDay) {
//             setState(() {
//               _selectedDay = selectedDay;
//               _focusedDay = focusedDay;
//             });
//           },
//           calendarFormat: CalendarFormat.month,
//           startingDayOfWeek: StartingDayOfWeek.monday,
//           calendarStyle: const CalendarStyle(
//             defaultTextStyle: TextStyle(color: Colors.black),
//             weekendTextStyle: TextStyle(color: Colors.red),
//             todayDecoration: BoxDecoration(
//               color: Colors.blue,
//               shape: BoxShape.circle,
//             ),
//             selectedDecoration: BoxDecoration(
//               color: Colors.orange,
//               shape: BoxShape.circle,
//             ),
//             markerDecoration: BoxDecoration(
//               color: Colors.black,
//               shape: BoxShape.circle,
//             ),
//             markersMaxCount: 3,
//           ),
//           headerStyle: const HeaderStyle(
//             titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
//             formatButtonVisible: false,
//             leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
//             rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
//           ),
//           daysOfWeekStyle: const DaysOfWeekStyle(
//             weekdayStyle: TextStyle(color: Colors.black),
//             weekendStyle: TextStyle(color: Colors.red),
//           ),
//         );
//       },
//     );
//   }

//   void _showLocationDialog(BuildContext context) {
//     final List<String> locations = ['Street 1', 'Street 2', 'Street 3'];
//     final TextEditingController typeAheadController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Select Location'),
//           content: TypeAheadFormField(
//             textFieldConfiguration: TextFieldConfiguration(
//               controller: typeAheadController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter street name',
//                 suffixIcon: Icon(Icons.arrow_drop_down), // Add dropdown arrow
//               ),
//             ),
//             suggestionsCallback: (pattern) {
//               return locations.where(
//                   (item) => item.toLowerCase().contains(pattern.toLowerCase()));
//             },
//             itemBuilder: (context, String suggestion) {
//               return ListTile(
//                 title: Text(suggestion),
//               );
//             },
//             onSuggestionSelected: (String suggestion) {
//               typeAheadController.text = suggestion;
//               setState(() {
//                 _selectedLocation = suggestion;
//               });
//               Navigator.pop(context); // Close the dialog
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// extension DateTimeExtension on DateTime {
//   String monthName() {
//     const months = [
//       'Januar',
//       'Februar',
//       'März',
//       'April',
//       'Mai',
//       'Juni',
//       'Juli',
//       'August',
//       'September',
//       'Oktober',
//       'November',
//       'Dezember'
//     ];
//     return months[month - 1];
//   }

//   String weekdayName() {
//     const weekdays = [
//       'Montag',
//       'Dienstag',
//       'Mittwoch',
//       'Donnerstag',
//       'Freitag',
//       'Samstag',
//       'Sonntag'
//     ];
//     return weekdays[weekday - 1];
//   }
// }

// void main() {
//   runApp(const WasteCalendar());
// }
