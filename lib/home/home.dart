import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/home/contact_me/contact_me_section.dart';
import 'package:mhk_portfolio_flutter/home/footer.dart';
import 'package:mhk_portfolio_flutter/home/header_button.dart';
import 'package:mhk_portfolio_flutter/home/info/profile_section.dart';
import 'package:mhk_portfolio_flutter/home/projects/projects_section.dart';
import 'package:mhk_portfolio_flutter/home/timeline/resume_section.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isDarkMode = false;
  int selected = 0;
  double selectedSectionOffset = 0;
  List<GlobalKey> sectionKeys = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        selectedSectionOffset = _scrollController.offset;
      });
    });
  }

  void scrollToSection(int index) {
    final keyContext = sectionKeys[index].currentContext;
    setState(() {
      selected = index;
    });
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  double _getSectionOffset(int index) {
    final keyContext = sectionKeys[index].currentContext;

    if (keyContext != null) {
      final box = keyContext.findRenderObject() as RenderBox;
      return box.localToGlobal(Offset.zero).dy + _scrollController.offset;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.background,
      appBar: buildAppBar(context),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          setState(() {
            selectedSectionOffset = _scrollController.offset;
          });
          return false;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                key: sectionKeys[0],
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: ProfileInfoSection(isDarkMode: isDarkMode),
              ),
              Container(
                key: sectionKeys[1],
                child: ProjectsPage(isDarkMode: isDarkMode),
              ),
              Container(
                key: sectionKeys[2],
                child: ResumeSection(isDarkMode: isDarkMode),
              ),
              Container(
                key: sectionKeys[3],
                child: ContactPage(isDarkMode: isDarkMode),
              ),
              FooterSection(isDarkMode: isDarkMode),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: isDarkMode ? AppColors.darkWhite : AppColors.black,
      ),
      title: Text(
        'Mohammad Hisham',
        style: GoogleFonts.inter(
          color: isDarkMode ? AppColors.darkWhite : AppColors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        HeaderButton(
          title: 'ABOUT ME',
          onPressed: () => scrollToSection(0),
          isSelected: selected == 0,
          isDarkMode: isDarkMode,
          icon: Icons.home,
        ),
        HeaderButton(
          title: 'PROJECTS',
          onPressed: () => scrollToSection(1),
          isSelected: selected == 1,
          isDarkMode: isDarkMode,
          icon: Icons.file_copy_outlined,
        ),
        HeaderButton(
          title: 'TIMELINE',
          onPressed: () => scrollToSection(2),
          isSelected: selected == 2,
          isDarkMode: isDarkMode,
          icon: Icons.work_outline_sharp,
        ),
        HeaderButton(
          title: 'CONTACT',
          onPressed: () => scrollToSection(3),
          isSelected: selected == 3,
          isDarkMode: isDarkMode,
          icon: Icons.contact_phone_outlined,
        ),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;
            });
          },
        ),
      ],
    );
  }
}
