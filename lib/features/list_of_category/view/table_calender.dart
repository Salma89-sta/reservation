import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  @override
  _CalendarDialogState createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, double> _reservationPercentages = {};

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TableCalendar(
                    calendarFormat: _calendarFormat,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    focusedDay: _selectedDate,
                    firstDay: DateTime(DateTime.now().year - 1),
                    lastDay: DateTime(DateTime.now().year + 1),
                    selectedDayPredicate: (date) {
                      return isSameDay(_selectedDate, date);
                    },
                    onDaySelected: (date, events) {
                      setState(() {
                        _selectedDate = date;
                        _fetchFreeTimes(date);
                      });

                      showDialog(context: context,   builder: (BuildContext context) {
                      return AlertDialog(
                        content:Column(
                          children: [
                            Text('Free Times on ${_selectedDate.toString().split(' ')[0]}'),
                            SizedBox(height: 8),
                          ],
                        ) ,

                      );});

                    },
                    calendarStyle: CalendarStyle(
                      weekendTextStyle: TextStyle(color: Colors.red),
                      selectedTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      // markersColor: Colors.green,
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: true,
                      titleTextStyle: TextStyle(fontSize: 20),

                    ),
                  ),
                  // SizedBox(height: 16),
                  // Text(
                  //   'Free Times on ${_selectedDate.toString().split(' ')[0]}',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  // _buildFreeTimes(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _fetchFreeTimes(DateTime date) {
    // Simulating fetching reservation percentages from a data source
    setState(() {
      _reservationPercentages = {
        DateTime(2023, 12, 27): 100.0,
        DateTime(2023, 12, 28): 50.0,
        DateTime(2023, 12, 29): 75.0,
        DateTime(2023, 12, 30): 20.0,
        DateTime(2023, 12, 31): 90.0,
        DateTime(2024, 1, 1): 40.0,
        DateTime(2024, 1, 2): 60.0,
      };
    });
  }

  Widget _buildFreeTimes() {
    final percentage = _reservationPercentages[_selectedDate];
    if (percentage == null) {
      return Text('Day is fully free ${_selectedDate.toString().split(' ')[0]}');
    } else if (percentage == 100) {
      return Text('Day is fully booked!');
    } else {
      return Text('Free times available!');
    }
  }
}