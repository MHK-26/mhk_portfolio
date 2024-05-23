import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:timelines/timelines.dart';

class Timeline extends StatelessWidget {
  final bool isDarkMode;

  Timeline({required this.isDarkMode});

  final List<Process> processes = [
    Process('Feb 2024 – Present', 'Mobile Application Developer',
        ' Emerging Ideas – United Arab Emirates'),
    Process('Sep 2022 – Feb 2024', 'Senior System Developer', ' MTN – Sudan'),
    Process('Apr 2021 – Mar 2023', 'Mobile Application Team Lead',
        ' Smart Care Digital Services – Sudan'),
    Process('Jan 2018 – Jan 2021', 'Full-Stack Software Engineer',
        ' Sanhory For Technologies – Sudan'),
    Process('Sep 2016 – Jun 2019', 'ICT NOC Engineer',
        ' Sudatel Telecom Group Data Center – Sudan'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(color: AppColors.gold),
          builder: TimelineTileBuilder.connectedFromStyle(
            connectionDirection: ConnectionDirection.before,
            contentsAlign: ContentsAlign.basic,
            itemCount: processes.length,
            oppositeContentsBuilder: (context, index) {
              if (index % 2 == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          processes[index].date,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          processes[index].title,
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          processes[index].company,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
            contentsBuilder: (context, index) {
              if (index % 2 != 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          processes[index].date,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          processes[index].title,
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          processes[index].company,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
            connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
            indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          ),
        ),
      ),
    );
  }
}

class Process {
  final String date;
  final String title;
  final String company;

  Process(this.date, this.title, this.company);
}
