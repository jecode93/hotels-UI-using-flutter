import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_fonts/google_fonts.dart';

final kNow = DateTime.now();
final kFirstDay = DateTime(kNow.year, kNow.month - 3, kNow.day);
final kLastDay = DateTime(kNow.year, kNow.month + 3, kNow.day);

const d_green = Color(0xFF54D3C2);

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PeriodSection(),
            CalendarRange(),
            ValidateBookingSection(),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
        ),
        onPressed: null,
      ),
      title: Text(
        'Explore',
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          icon: Icon(
            Icons.favorite_outline_rounded,
            color: Colors.grey[800],
          ),
          onPressed: null,
        ),
        IconButton(
          icon: Icon(
            Icons.place,
            color: Colors.grey[800],
          ),
          onPressed: null,
        ),
      ],
    );
  }
}

class PeriodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Depart',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Month 12 Dec',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              width: 1,
              color: Colors.grey[350],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Return',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Tues 22 Dec',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          height: 1,
        ),
      ],
    );
  }
}

class CalendarRange extends StatefulWidget {
  @override
  _CalendarRangeState createState() => _CalendarRangeState();
}

class _CalendarRangeState extends State<CalendarRange> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.grey[10],
      child: TableCalendar(
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: _calendarFormat,
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontSize: 18),
        ),
        calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          rangeHighlightColor: d_green,
          rangeStartDecoration: BoxDecoration(
            color: d_green,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.white,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
          ),
          withinRangeTextStyle: TextStyle(
            color: Colors.white,
          ),
          rangeEndDecoration: BoxDecoration(
            color: d_green,
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(
                color: Colors.white,
                width: 3,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
        firstDay: kFirstDay,
        rangeSelectionMode: _rangeSelectionMode,
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              _rangeStart = null;
              _rangeEnd = null;
              _rangeSelectionMode = RangeSelectionMode.toggledOff;
            });
          }
        },
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _selectedDay = null;
            _focusedDay = focusedDay;
            _rangeStart = start;
            _rangeEnd = end;
            _rangeSelectionMode = RangeSelectionMode.toggledOn;
          });
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}

class ValidateBookingSection extends StatelessWidget {
  final selectedRadio = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: selectedRadio,
          activeColor: d_green,
          groupValue: selectedRadio,
          selected: true,
          title: Text(
            "Flexible with dates",
            style: new TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          onChanged: null,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: ElevatedButton(
            child: Text(
              'Apply',
              style: TextStyle(fontSize: 17),
            ),
            style: ElevatedButton.styleFrom(
              primary: d_green,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              print('Apply Booking');
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
