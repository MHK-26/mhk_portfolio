import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/colors.dart';

class TimelineEvent extends StatelessWidget {
  final String date;
  final String title;
  // final String description;
  final bool isDarkMode;

  TimelineEvent({
    required this.date,
    required this.title,
    // required this.description,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.primary,
              ),
              Container(
                height: 60,
                width: 2,
                color: AppColors.primary,
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: GoogleFonts.inter(
                      color: isDarkMode ? AppColors.darkWhite : AppColors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // SizedBox(height: 5),
                  // Text(
                  //   description,
                  //   style: GoogleFonts.inter(
                  //     color: isDarkMode ? AppColors.darkWhite : AppColors.black,
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
