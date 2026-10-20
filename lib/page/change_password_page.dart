import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with SingleTickerProviderStateMixin {
  // ==========================================
  // FORM
  // ==========================================

  final _formKey = GlobalKey<FormState>();

  // Controller
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // ==========================================
  // PASSWORD VISIBILITY
  // ==========================================

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // ==========================================
  // BUTTON STATE
  // ==========================================

  bool _isPressed = false;
  bool _isLoading = false;

  // ==========================================
  // ANIMATION
  // ==========================================

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoScaleAnimation;

  // ==========================================
  // INIT
  // ==========================================

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    // Fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    // Slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Logo animation
    _logoScaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    // Jalankan animasi
    _animationController.forward();
  }

  // ==========================================
  // DISPOSE
  // ==========================================

  @override
  void dispose() {
    _animationController.dispose();

    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  // ==========================================
  // LOGO
  // ==========================================

  Widget _buildLogo() {
    return ScaleTransition(
      scale: _logoScaleAnimation,
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF7C4DFF),
                  Color(0xFF2979FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7C4DFF).withOpacity(0.35),
                  blurRadius: 25,
                  spreadRadius: 3,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_reset_rounded,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Change Password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Keep your account secure',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // HEADER
  // ==========================================

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'Update Your Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your current password and create a new one.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.55),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // INPUT DECORATION
  // ==========================================

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    required bool obscureText,
    required VoidCallback onVisibilityPressed,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.65),
      ),
      prefixIcon: Icon(
        icon,
        color: const Color(0xFF64B5F6),
      ),
      suffixIcon: IconButton(
        onPressed: onVisibilityPressed,
        icon: Icon(
          obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
          color: Colors.white.withOpacity(0.55),
        ),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.07),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.12),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFF7C4DFF),
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFEF5350),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFFEF5350),
          width: 2,
        ),
      ),
      errorStyle: const TextStyle(
        color: Color(0xFFFF8A80),
      ),
    );
  }

  // ==========================================
  // CURRENT PASSWORD
  // ==========================================

  Widget _buildCurrentPasswordField() {
    return TextFormField(
      controller: _currentPasswordController,
      obscureText: _obscureCurrentPassword,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: _inputDecoration(
        label: 'Current Password',
        icon: Icons.lock_outline_rounded,
        obscureText: _obscureCurrentPassword,
        onVisibilityPressed: () {
          setState(() {
            _obscureCurrentPassword = !_obscureCurrentPassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Current password tidak boleh kosong!';
        }

        if (value.length < 6) {
          return 'Password minimal 6 karakter!';
        }

        return null;
      },
    );
  }

  // ==========================================
  // NEW PASSWORD
  // ==========================================

  Widget _buildNewPasswordField() {
    return TextFormField(
      controller: _newPasswordController,
      obscureText: _obscureNewPassword,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: _inputDecoration(
        label: 'New Password',
        icon: Icons.lock_reset_rounded,
        obscureText: _obscureNewPassword,
        onVisibilityPressed: () {
          setState(() {
            _obscureNewPassword = !_obscureNewPassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'New password tidak boleh kosong!';
        }

        if (value.length < 6) {
          return 'Password minimal 6 karakter!';
        }

        if (value == _currentPasswordController.text) {
          return 'Password baru harus berbeda!';
        }

        return null;
      },
    );
  }

  // ==========================================
  // CONFIRM PASSWORD
  // ==========================================

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: _inputDecoration(
        label: 'Confirm New Password',
        icon: Icons.verified_user_outlined,
        obscureText: _obscureConfirmPassword,
        onVisibilityPressed: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm password tidak boleh kosong!';
        }

        if (value != _newPasswordController.text) {
          return 'Password tidak sama!';
        }

        return null;
      },
    );
  }

  // ==========================================
  // CHANGE PASSWORD BUTTON
  // ==========================================

  Widget _buildChangePasswordButton(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        if (!_isLoading) {
          setState(() {
            _isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        if (!_isLoading) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      onTapCancel: () {
        if (!_isLoading) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      onTap: _isLoading
          ? null
          : () {
              _changePassword();
            },
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(
          milliseconds: 100,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF7C4DFF),
                Color(0xFF2979FF),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_reset_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Change Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // CHANGE PASSWORD PROCESS
  // ==========================================

  Future<void> _changePassword() async {
    // Jalankan validasi
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFEF5350),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: const Text(
            'Periksa kembali password kamu!',
          ),
        ),
      );

      return;
    }

    // Loading
    setState(() {
      _isLoading = true;
    });

    // Simulasi proses update password
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    // Berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF43A047),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: const Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Password berhasil diubah!',
              ),
            ),
          ],
        ),
      ),
    );

    // Bersihkan field
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  // ==========================================
  // BACK TO ACCOUNT
  // ==========================================

  Widget _buildBackButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back_rounded,
        color: Color(0xFF82B1FF),
        size: 18,
      ),
      label: const Text(
        'Back to Account',
        style: TextStyle(
          color: Color(0xFF82B1FF),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F1020),
              Color(0xFF171A35),
              Color(0xFF20255A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // LOGO
                        _buildLogo(),

                        const SizedBox(
                          height: 30,
                        ),

                        // CARD
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // HEADER
                              _buildHeader(),

                              const SizedBox(
                                height: 28,
                              ),

                              // CURRENT PASSWORD
                              _buildCurrentPasswordField(),

                              const SizedBox(
                                height: 18,
                              ),

                              // NEW PASSWORD
                              _buildNewPasswordField(),

                              const SizedBox(
                                height: 18,
                              ),

                              // CONFIRM PASSWORD
                              _buildConfirmPasswordField(),

                              const SizedBox(
                                height: 25,
                              ),

                              // BUTTON
                              _buildChangePasswordButton(context),

                              const SizedBox(
                                height: 10,
                              ),

                              // BACK
                              _buildBackButton(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
