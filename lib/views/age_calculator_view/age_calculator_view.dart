import 'package:agecalculator/theme/theme_provider.dart';
import 'package:agecalculator/utils/const.dart';
import 'package:agecalculator/views/age_calculator_result/age_calculator_result.dart';
import 'package:agecalculator/widgets/mydrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class AgeCalculatorView extends StatefulWidget {
  const AgeCalculatorView({super.key});

  @override
  State<AgeCalculatorView> createState() => _AgeCalculatorViewState();
}

class _AgeCalculatorViewState extends State<AgeCalculatorView> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Text('اعرف عمرك'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: themeProvider.toggleTheme,
            ),
          ],
          backgroundColor: themeProvider.isDarkMode
              ? AppColors.kTextAndIconColor
              : AppColors.kContentColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildTextField(_dayController, 'أدخل اليوم', 'day'),
                        const SizedBox(height: 20),
                        _buildTextField(
                            _monthController, 'أدخل الشهر', 'month'),
                        const SizedBox(height: 20),
                        _buildTextField(_yearController, 'أدخل السنة', 'year'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kTextAndIconColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _calculateAge,
                    child: const Text(
                      'اعرف عمرك',
                      style: TextStyle(
                          color: AppColors.kContentColor, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, String type) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(_getIconForField(type)),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // يسمح فقط بالأرقام
        LengthLimitingTextInputFormatter(type == 'year' ? 4 : 2),
      ],
      validator: _validateField(type),
    );
  }

  IconData _getIconForField(String type) {
    switch (type) {
      case 'day':
        return Icons.calendar_today;
      case 'month':
        return Icons.date_range;
      case 'year':
        return Icons
            .calendar_month; // Changed from calendar_view_year to calendar_month
      default:
        return Icons.input;
    }
  }

  FormFieldValidator<String> _validateField(String type) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'هذا الحقل مطلوب';
      }

      final int? number = int.tryParse(value);
      if (number == null) {
        return 'الرجاء إدخال رقم صحيح';
      }

      switch (type) {
        case 'day':
          if (number < 1 || number > 31) {
            return 'اليوم يجب أن يكون بين 1 و 31';
          }
          // التحقق من صحة اليوم حسب الشهر
          if (_monthController.text.isNotEmpty) {
            int month = int.parse(_monthController.text);
            if (!_isValidDayForMonth(number, month)) {
              return 'اليوم غير صحيح لهذا الشهر';
            }
          }
          break;
        case 'month':
          if (number < 1 || number > 12) {
            return 'الشهر يجب أن يكون بين 1 و 12';
          }
          break;
        case 'year':
          final currentYear = DateTime.now().year;
          if (number < 1900 || number > currentYear) {
            return 'السنة يجب أن تكون بين 1900 و $currentYear';
          }
          break;
      }
      return null;
    };
  }

  bool _isValidDayForMonth(int day, int month) {
    if (month == 2) {
      if (_yearController.text.isNotEmpty) {
        int year = int.parse(_yearController.text);
        bool isLeapYear =
            (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        return day <= (isLeapYear ? 29 : 28);
      }
      return day <= 29;
    }
    if ([4, 6, 9, 11].contains(month)) {
      return day <= 30;
    }
    return true;
  }

  void _calculateAge() {
    if (_formKey.currentState?.validate() ?? false) {
      final birthDate = DateTime(
        int.parse(_yearController.text),
        int.parse(_monthController.text),
        int.parse(_dayController.text),
      );
      final currentDate = DateTime.now();

      if (birthDate.isAfter(currentDate)) {
        _showErrorDialog('تاريخ الميلاد لا يمكن أن يكون في المستقبل');
        return;
      }

      final ageDetails = _computeDetailedAge(birthDate, currentDate);
      final nextBirthdayInfo = _computeNextBirthday(birthDate, currentDate);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AgeResult(
            ageDetails: ageDetails,
            nextBirthdayInfo: nextBirthdayInfo,
            birthDate: birthDate,
          ),
        ),
      );
    }
  }

  Map<String, dynamic> _computeDetailedAge(
      DateTime birthDate, DateTime currentDate) {
    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;
    if (days < 0) {
      months--;
      final previousMonthDate =
          DateTime(currentDate.year, currentDate.month, 0);
      days += previousMonthDate.day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }
    int totalMonths = (years * 12) + months;
    return {
      'years': years,
      'months': months,
      'days': days,
      'totalMonths': totalMonths,
      'totalDays': currentDate.difference(birthDate).inDays,
      'totalHours': currentDate.difference(birthDate).inHours,
      'totalMinutes': currentDate.difference(birthDate).inMinutes,
      'totalSeconds': currentDate.difference(birthDate).inSeconds,
    };
  }

  Map<String, dynamic> _computeNextBirthday(
      DateTime birthDate, DateTime currentDate) {
    DateTime nextBirthday = DateTime(
      currentDate.year,
      birthDate.month,
      birthDate.day,
    );

    if (nextBirthday.isBefore(currentDate)) {
      nextBirthday = DateTime(
        currentDate.year + 1,
        birthDate.month,
        birthDate.day,
      );
    }

    Duration difference = nextBirthday.difference(currentDate);

    return {
      'date': nextBirthday,
      'inMonths': difference.inDays ~/ 30,
      'daysRemaining': difference.inDays,
      'hoursRemaining': difference.inHours % 24,
      'minutesRemaining': difference.inMinutes % 60,
      'dayOfWeek': intl.DateFormat('EEEE').format(nextBirthday),
    };
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خطأ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسنًا'),
          ),
        ],
      ),
    );
  }
}
