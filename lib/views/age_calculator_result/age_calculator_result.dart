import 'package:agecalculator/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class AgeResult extends StatefulWidget {
  final Map<String, dynamic> ageDetails;
  final Map<String, dynamic> nextBirthdayInfo;
  final DateTime birthDate;

  const AgeResult({
    Key? key,
    required this.ageDetails,
    required this.nextBirthdayInfo,
    required this.birthDate,
  }) : super(key: key);

  @override
  State<AgeResult> createState() => _AgeResultState();
}

class _AgeResultState extends State<AgeResult> {
  final Map<String, String> arabicDays = {
    'Sunday': 'الأحد',
    'Monday': 'الاثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
    'Saturday': 'السبت',
  };

  String getArabicDay(String englishDay) {
    return arabicDays[englishDay] ?? englishDay;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('نتيجة حساب عمرك'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: themeProvider.toggleTheme,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAgeCard(),
                const SizedBox(height: 20),
                _buildDetailsCard(),
                const SizedBox(height: 20),
                _buildNextBirthdayCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgeCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity, // Set the width to double.infinity
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'عمرك الحالي',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${widget.ageDetails['years']} سنة و ${widget.ageDetails['months']} شهر و ${widget.ageDetails['days']} يوم',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity, // Set the width to double.infinity
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'تفاصيل العمر',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('عدد الشهور الكلية: ${widget.ageDetails['totalMonths']}'),
            Text('عدد الأيام الكلية: ${widget.ageDetails['totalDays']}'),
            Text('عدد الساعات الكلية: ${widget.ageDetails['totalHours']}'),
            Text('عدد الدقائق الكلية: ${widget.ageDetails['totalMinutes']}'),
            Text('عدد الثواني الكلية: ${widget.ageDetails['totalSeconds']}'),
          ],
        ),
      ),
    );
  }

  Widget _buildNextBirthdayCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: double.infinity, // Set the width to double.infinity
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'عيد الميلاد القادم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'وُلدت يوم ${getArabicDay(intl.DateFormat('EEEE').format(widget.birthDate))}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              'سيكون عيد ميلادك يوم ${getArabicDay(widget.nextBirthdayInfo['dayOfWeek'])}',
              textAlign: TextAlign.center,
            ),
            Text(
              'المتبقي: ${widget.nextBirthdayInfo['daysRemaining']} يوم و ${widget.nextBirthdayInfo['hoursRemaining']} ساعة و ${widget.nextBirthdayInfo['minutesRemaining']} دقيقة',
              textAlign: TextAlign.center,
            ),
            Text(
              'التاريخ: ${intl.DateFormat('yyyy-MM-dd').format(widget.nextBirthdayInfo['date'])}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
