import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DatePicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime _selectedDate;
  final DateFormat _dateFormat = DateFormat('yyyy年MM月dd日');

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      locale: const Locale('zh', 'CN'),
      builder: (BuildContext context, Widget? child) {
        return Localizations.override(
          context: context,
          locale: Localizations.localeOf(context),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                const SizedBox(width: 10),
                Text(_dateFormat
                    .format(_selectedDate.subtract(Duration(days: 30)))),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                const SizedBox(width: 10),
                Text(_dateFormat.format(_selectedDate)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
