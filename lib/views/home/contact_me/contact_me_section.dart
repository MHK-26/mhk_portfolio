import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  final bool isDarkMode;

  const ContactPage({super.key, required this.isDarkMode});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;
  bool _isFormSubmitted = false;
  
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));
    
    _slideController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double horizontalPadding = constraints.maxWidth < 600 ? 20 : 40;
          double titleFontSize = constraints.maxWidth < 600 ? 28 : 32;
          double subtitleFontSize = constraints.maxWidth < 600 ? 14 : 16;
          
          return Padding(
            padding: EdgeInsets.all(horizontalPadding),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Text(
                      'Get In Touch',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Have a project in mind? Let\'s work together!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: subtitleFontSize,
                        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildContactForm(),
                    const SizedBox(height: 30),
                    Text(
                      'Or connect with me on social media platforms.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
                        fontSize: constraints.maxWidth < 600 ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactForm() {
    if (_isFormSubmitted) {
      return _buildSuccessMessage();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double formPadding = constraints.maxWidth < 600 ? 20 : 30;
        
        return Container(
          padding: EdgeInsets.all(formPadding),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.isDarkMode
                  ? [Colors.black54, Colors.black87]
                  : [Colors.white, Colors.grey[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: _nameController,
                  label: 'Your Name',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: constraints.maxWidth < 600 ? 16 : 20),
                _buildTextField(
                  controller: _emailController,
                  label: 'Your Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: constraints.maxWidth < 600 ? 16 : 20),
                _buildTextField(
                  controller: _messageController,
                  label: 'Your Message',
                  icon: Icons.message_outlined,
                  maxLines: constraints.maxWidth < 600 ? 4 : 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                SizedBox(height: constraints.maxWidth < 600 ? 24 : 30),
                _buildSubmitButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: AppColors.gold,
        ),
        labelStyle: TextStyle(
          color: widget.isDarkMode ? AppColors.darkWhite.withOpacity(0.7) : AppColors.black.withOpacity(0.7),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gold, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        filled: true,
        fillColor: widget.isDarkMode 
            ? Colors.grey[800]?.withOpacity(0.3) 
            : Colors.grey[50],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: AppColors.gold.withOpacity(0.3),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send_outlined),
                  const SizedBox(width: 8),
                  Text(
                    'Send Message',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withOpacity(0.1),
            AppColors.gold.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.gold,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Thank You!',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your message has been sent successfully. I\'ll get back to you soon!',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: widget.isDarkMode ? AppColors.darkWhite : AppColors.black,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              setState(() {
                _isFormSubmitted = false;
                _nameController.clear();
                _emailController.clear();
                _messageController.clear();
              });
            },
            child: Text(
              'Send Another Message',
              style: GoogleFonts.inter(
                color: AppColors.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Create mailto URL
      final String subject = 'Portfolio Contact: Message from ${_nameController.text}';
      final String body = '''
Hello,

You have received a new message from your portfolio website:

Name: ${_nameController.text}
Email: ${_emailController.text}

Message:
${_messageController.text}

Best regards,
${_nameController.text}
      ''';

      final String emailUrl = 'mailto:your-email@example.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

      try {
        if (await canLaunchUrl(Uri.parse(emailUrl))) {
          await launchUrl(Uri.parse(emailUrl));
        }
      } catch (e) {
        // Handle error silently
      }

      setState(() {
        _isLoading = false;
        _isFormSubmitted = true;
      });
    }
  }
}
