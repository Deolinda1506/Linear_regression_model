import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CyberGuard Analytics',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D47A1),
          primary: const Color(0xFF0D47A1),
          secondary: const Color(0xFF00BCD4),
          tertiary: const Color(0xFF2962FF),
          background: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: const Color(0xFF0D47A1).withOpacity(0.1),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF0D47A1),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: const Color(0xFF0D47A1),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showScrollToTop = _scrollController.offset > 300;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A237E),
              const Color(0xFF0D47A1),
              const Color(0xFF1565C0),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Modern Logo Section
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 1000),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Hero(
                          tag: 'company_logo',
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.2),
                                        Colors.white.withOpacity(0.1),
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.shield_moon,
                                    size: 36,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'CyberGuard',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: const Offset(0, 1),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'AI-Powered Security Analytics',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: Colors.white.withOpacity(0.9),
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Animated Text Section
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Predict Incident Resolution Time',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  height: 1.3,
                                  color: Colors.white.withOpacity(0.95),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Using Advanced Machine Learning Models',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.7),
                                  letterSpacing: 0.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Features Grid
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.3,
                          children: [
                            _buildFeatureCard(
                              context,
                              Icons.analytics,
                              'Real-time Analysis',
                              'Instant predictions',
                            ),
                            _buildFeatureCard(
                              context,
                              Icons.security,
                              'Advanced Security',
                              'Enterprise-grade',
                            ),
                            _buildFeatureCard(
                              context,
                              Icons.speed,
                              'Fast Results',
                              'Quick predictions',
                            ),
                            _buildFeatureCard(
                              context,
                              Icons.insights,
                              'Smart Insights',
                              'ML-powered',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Start Button
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 800),
                        tween: Tween(begin: 0.8, end: 1.0),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: child,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const PredictionFormScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF1A237E),
                              elevation: 8,
                              shadowColor: Colors.black.withOpacity(0.2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Start Prediction',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A237E)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_showScrollToTop)
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _showScrollToTop ? 1.0 : 0.0,
                    child: FloatingActionButton.small(
                      onPressed: _scrollToTop,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.arrow_upward,
                          color: Color(0xFF1A237E)),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 8,
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class PredictionFormScreen extends StatefulWidget {
  const PredictionFormScreen({super.key});

  @override
  State<PredictionFormScreen> createState() => _PredictionFormScreenState();
}

class _PredictionFormScreenState extends State<PredictionFormScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _prediction;

  final _yearController = TextEditingController();
  final _lossController = TextEditingController();
  final _usersController = TextEditingController();
  String? _selectedIndustry;
  String? _selectedAttackSource;
  String? _selectedVulnerability;
  String? _selectedDefense;
  String? _selectedCountry;
  String? _selectedAttackType;

  final List<String> _industries = [
    'Education',
    'Retail',
    'IT',
    'Telecommunications',
    'Healthcare',
    'Finance',
    'Manufacturing',
    'Energy',
  ];

  final List<String> _attackSources = [
    'Hacker Group',
    'Nation-state',
    'Insider',
    'Organized Crime',
  ];

  final List<String> _vulnerabilities = [
    'Unpatched Software',
    'Weak Passwords',
    'Social Engineering',
    'System Misconfiguration',
    'Zero-day',
  ];

  final List<String> _defenses = [
    'VPN',
    'Firewall',
    'AI-based Detection',
    'Intrusion Detection System',
    'Antivirus',
    'Encryption',
  ];

  final List<String> _countries = [
    'China',
    'India',
    'UK',
    'Germany',
    'Japan',
    'Brazil',
    'France',
    'Australia',
    'USA',
    'Canada',
    'Singapore',
    'South Korea',
  ];

  final List<String> _attackTypes = [
    'Phishing',
    'Ransomware',
    'Man-in-the-Middle',
    'DDoS',
    'SQL Injection',
    'Cross-Site Scripting',
    'Malware',
    'Social Engineering',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    _scrollController.addListener(() {
      setState(() {
        _showScrollToTop = _scrollController.offset > 300;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _yearController.dispose();
    _lossController.dispose();
    _usersController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
        _prediction = null;
      });

      final url = Uri.parse(
          'https://linear-regression-model-lp6t.onrender.com/predict');

      final Map<String, dynamic> requestBody = {
        "Year": int.tryParse(_yearController.text) ?? 0,
        "Financial_Loss_in_Million":
            double.tryParse(_lossController.text) ?? 0.0,
        "Number_of_Affected_Users": int.tryParse(_usersController.text) ?? 0,
        "Target_Industry": _selectedIndustry ?? '',
        "Attack_Source": _selectedAttackSource ?? '',
        "Security_Vulnerability_Type": _selectedVulnerability ?? '',
        "Defense_Mechanism_Used": _selectedDefense ?? '',
        "Country": _selectedCountry ?? '',
        "Attack_Type": _selectedAttackType ?? '',
      };

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _prediction = {
              'predicted_hours': data['predicted_resolution_time'],
              'confidence_level': 'High'
            };
            _isLoading = false;
          });

          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PredictionResultScreen(
                  prediction: _prediction!,
                  inputData: {
                    'Year': _yearController.text,
                    'Financial Loss': '\$${_lossController.text}M',
                    'Affected Users': _usersController.text,
                    'Country': _selectedCountry ?? '',
                    'Attack Type': _selectedAttackType ?? '',
                    'Industry': _selectedIndustry ?? '',
                    'Attack Source': _selectedAttackSource ?? '',
                    'Vulnerability': _selectedVulnerability ?? '',
                    'Defense': _selectedDefense ?? '',
                  },
                ),
              ),
            );
          }
        } else {
          setState(() {
            _errorMessage = "Error ${response.statusCode}: ${response.body}";
            _isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = "Failed to connect to API: $e";
          _isLoading = false;
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to connect to API: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'company_logo',
              child: Container(
                padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.shield_moon,
                  size: isSmallScreen ? 16 : 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            SizedBox(width: isSmallScreen ? 6 : 8),
            Text(
              'Incident Analysis',
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 14 : 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: isSmallScreen ? 16 : 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              const Color(0xFF1A237E).withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  left: isSmallScreen ? 4.0 : 8.0,
                  right: isSmallScreen ? 4.0 : 8.0,
                  top: isSmallScreen ? 4.0 : 8.0,
                  bottom: isSmallScreen ? 60.0 : 80.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Section
                      Container(
                        padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Incident Details',
                              style: GoogleFonts.inter(
                                fontSize: isSmallScreen ? 16 : 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1A237E),
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 2 : 4),
                            Text(
                              'Enter the details of the cyber incident',
                              style: GoogleFonts.inter(
                                fontSize: isSmallScreen ? 10 : 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),

                      // Form Sections
                      _buildFormSection(
                        'Basic Information',
                        Icons.info_outline,
                        [
                          _buildAnimatedTextField(
                            controller: _yearController,
                            label: 'Year',
                            hint: 'Enter year (2015-2024)',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a year';
                              }
                              final year = int.tryParse(value);
                              if (year == null || year < 2015 || year > 2024) {
                                return 'Please enter a valid year between 2015 and 2024';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 8),
                          _buildAnimatedTextField(
                            controller: _lossController,
                            label: 'Financial Impact',
                            hint: 'Enter loss in million USD',
                            prefixIcon: Icons.attach_money,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d*'))
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter financial loss';
                              }
                              final loss = double.tryParse(value);
                              if (loss == null || loss < 0) {
                                return 'Please enter a valid loss amount (greater than 0)';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 8),
                          _buildAnimatedTextField(
                            controller: _usersController,
                            label: 'Affected Users',
                            hint: 'Enter number of users',
                            prefixIcon: Icons.group,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter number of affected users';
                              }
                              final users = int.tryParse(value);
                              if (users == null ||
                                  users < 0 ||
                                  users >= 10000000) {
                                return 'Please enter a valid number between 0 and 10M';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),

                      _buildFormSection(
                        'Attack Classification',
                        Icons.security,
                        [
                          _buildAnimatedDropdown(
                            value: _selectedCountry,
                            label: 'Country',
                            items: _countries,
                            prefixIcon: Icons.public,
                            onChanged: (value) =>
                                setState(() => _selectedCountry = value),
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 8),
                          _buildAnimatedDropdown(
                            value: _selectedAttackType,
                            label: 'Attack Type',
                            items: _attackTypes,
                            prefixIcon: Icons.warning_amber,
                            onChanged: (value) =>
                                setState(() => _selectedAttackType = value),
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 8),
                          _buildAnimatedDropdown(
                            value: _selectedIndustry,
                            label: 'Target Industry',
                            items: _industries,
                            prefixIcon: Icons.business,
                            onChanged: (value) =>
                                setState(() => _selectedIndustry = value),
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 8),
                          _buildAnimatedDropdown(
                            value: _selectedAttackSource,
                            label: 'Attack Source',
                            items: _attackSources,
                            prefixIcon: Icons.warning,
                            onChanged: (value) =>
                                setState(() => _selectedAttackSource = value),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),

                      _buildFormSection(
                        'Security Details',
                        Icons.shield,
                        [
                          _buildAnimatedDropdown(
                            value: _selectedVulnerability,
                            label: 'Vulnerability Type',
                            items: _vulnerabilities,
                            prefixIcon: Icons.bug_report,
                            onChanged: (value) =>
                                setState(() => _selectedVulnerability = value),
                          ),
                          SizedBox(height: isSmallScreen ? 6 : 8),
                          _buildAnimatedDropdown(
                            value: _selectedDefense,
                            label: 'Defense Mechanism',
                            items: _defenses,
                            prefixIcon: Icons.security,
                            onChanged: (value) =>
                                setState(() => _selectedDefense = value),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),

                      // Submit Button
                      if (_isLoading)
                        Center(
                          child: Column(
                            children: [
                              const CircularProgressIndicator(),
                              SizedBox(height: isSmallScreen ? 4 : 8),
                              Text(
                                'Analyzing incident data...',
                                style: GoogleFonts.inter(
                                  fontSize: isSmallScreen ? 10 : 12,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A237E),
                            foregroundColor: Colors.white,
                            elevation: 4,
                            padding: EdgeInsets.symmetric(
                              vertical: isSmallScreen ? 10 : 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.analytics,
                                  size: isSmallScreen ? 16 : 18),
                              SizedBox(width: isSmallScreen ? 6 : 8),
                              Text(
                                'Predict',
                                style: GoogleFonts.inter(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: isSmallScreen ? 8 : 12),

                      if (_errorMessage != null)
                        _buildErrorCard(_errorMessage!),
                    ],
                  ),
                ),
              ),
              if (_showScrollToTop)
                Positioned(
                  right: isSmallScreen ? 8 : 12,
                  bottom: isSmallScreen ? 8 : 12,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _showScrollToTop ? 1.0 : 0.0,
                    child: FloatingActionButton.small(
                      onPressed: _scrollToTop,
                      backgroundColor: const Color(0xFF1A237E),
                      child: Icon(Icons.arrow_upward,
                          color: Colors.white, size: isSmallScreen ? 16 : 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(String title, IconData icon, List<Widget> children) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
      margin: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A237E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: isSmallScreen ? 14 : 16,
                  color: const Color(0xFF1A237E),
                ),
              ),
              SizedBox(width: isSmallScreen ? 6 : 8),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: isSmallScreen ? 12 : 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A237E),
                ),
              ),
            ],
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildAnimatedTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? prefixIcon,
    required TextInputType keyboardType,
    required List<TextInputFormatter> inputFormatters,
    required String? Function(String?) validator,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: isSmallScreen ? 14 : 16,
                color: const Color(0xFF1A237E).withOpacity(0.7),
              )
            : null,
        labelStyle: GoogleFonts.inter(fontSize: isSmallScreen ? 10 : 12),
        hintStyle: GoogleFonts.inter(fontSize: isSmallScreen ? 10 : 12),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFF1A237E),
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 10 : 12,
          vertical: isSmallScreen ? 8 : 10,
        ),
      ),
      style: GoogleFonts.inter(fontSize: isSmallScreen ? 10 : 12),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }

  Widget _buildAnimatedDropdown({
    required String? value,
    required String label,
    required List<String> items,
    IconData? prefixIcon,
    required void Function(String?) onChanged,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: screenSize.width * 0.95,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(
          'Select $label',
          style: GoogleFonts.inter(
            fontSize: isSmallScreen ? 10 : (isMediumScreen ? 14 : 16),
            color: Colors.grey[600],
          ),
        ),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: isSmallScreen ? 14 : (isMediumScreen ? 18 : 20),
                  color: const Color(0xFF1A237E).withOpacity(0.7),
                )
              : null,
          labelStyle: GoogleFonts.inter(
            fontSize: isSmallScreen ? 10 : (isMediumScreen ? 14 : 16),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 10 : (isMediumScreen ? 14 : 16),
            vertical: isSmallScreen ? 8 : (isMediumScreen ? 12 : 14),
          ),
        ),
        style: GoogleFonts.inter(
          fontSize: isSmallScreen ? 10 : (isMediumScreen ? 14 : 16),
          color: const Color(0xFF1A237E),
          fontWeight: FontWeight.w500,
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down,
          size: isSmallScreen ? 18 : (isMediumScreen ? 24 : 28),
        ),
        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 10 : (isMediumScreen ? 14 : 16),
                color: const Color(0xFF1A237E),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
        selectedItemBuilder: (context) {
          return items.map((item) {
            return Text(
              item,
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 10 : (isMediumScreen ? 14 : 16),
                color: const Color(0xFF1A237E),
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 3 : 4),
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.error_outline,
              size: isSmallScreen ? 12 : 14,
              color: Colors.red[700],
            ),
          ),
          SizedBox(width: isSmallScreen ? 6 : 8),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 8 : 10,
                color: Colors.red[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PredictionResultScreen extends StatefulWidget {
  final Map<String, dynamic> prediction;
  final Map<String, String> inputData;

  const PredictionResultScreen({
    super.key,
    required this.prediction,
    required this.inputData,
  });

  @override
  State<PredictionResultScreen> createState() => _PredictionResultScreenState();
}

class _PredictionResultScreenState extends State<PredictionResultScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showScrollToTop = _scrollController.offset > 300;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final hours = widget.prediction['predicted_hours'];
    final hoursValue = hours is int ? hours.toDouble() : (hours as double);
    final formattedHours = hoursValue.toStringAsFixed(1);

    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A237E),
              const Color(0xFF0D47A1),
              const Color(0xFF1565C0),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios,
                              color: Colors.white,
                              size: isSmallScreen ? 16 : 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 12),
                        Text(
                          'Analysis Results',
                          style: GoogleFonts.inter(
                            fontSize: isSmallScreen ? 18 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 32),

                    // Main Prediction Card
                    Container(
                      padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(isSmallScreen ? 12 : 20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A237E).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.analytics,
                              size: isSmallScreen ? 24 : 40,
                              color: const Color(0xFF1A237E),
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 12 : 20),
                          Text(
                            '$formattedHours',
                            style: GoogleFonts.inter(
                              fontSize: isSmallScreen ? 32 : 42,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A237E),
                            ),
                          ),
                          Text(
                            'hours',
                            style: GoogleFonts.inter(
                              fontSize: isSmallScreen ? 12 : 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: isSmallScreen ? 8 : 12),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 8 : 12,
                              vertical: isSmallScreen ? 4 : 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(
                                  isSmallScreen ? 12 : 16),
                              border: Border.all(color: Colors.green[200]!),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: isSmallScreen ? 12 : 14,
                                  color: Colors.green[700],
                                ),
                                SizedBox(width: isSmallScreen ? 4 : 6),
                                Text(
                                  'High Confidence',
                                  style: GoogleFonts.inter(
                                    fontSize: isSmallScreen ? 10 : 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16 : 24),

                    // Input Parameters Card
                    Container(
                      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(isSmallScreen ? 12 : 20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF1A237E).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                      isSmallScreen ? 8 : 12),
                                ),
                                child: Icon(
                                  Icons.info_outline,
                                  size: isSmallScreen ? 18 : 24,
                                  color: const Color(0xFF1A237E),
                                ),
                              ),
                              SizedBox(width: isSmallScreen ? 8 : 12),
                              Text(
                                'Incident Details',
                                style: GoogleFonts.inter(
                                  fontSize: isSmallScreen ? 16 : 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1A237E),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: isSmallScreen ? 16 : 24),
                          _buildParameterRow('Year',
                              widget.inputData['Year'] ?? '', isSmallScreen),
                          _buildParameterRow(
                              'Financial Loss',
                              widget.inputData['Financial Loss'] ?? '',
                              isSmallScreen),
                          _buildParameterRow(
                              'Affected Users',
                              widget.inputData['Affected Users'] ?? '',
                              isSmallScreen),
                          _buildParameterRow('Country',
                              widget.inputData['Country'] ?? '', isSmallScreen),
                          _buildParameterRow(
                              'Attack Type',
                              widget.inputData['Attack Type'] ?? '',
                              isSmallScreen),
                          _buildParameterRow(
                              'Industry',
                              widget.inputData['Industry'] ?? '',
                              isSmallScreen),
                          _buildParameterRow(
                              'Attack Source',
                              widget.inputData['Attack Source'] ?? '',
                              isSmallScreen),
                          _buildParameterRow(
                              'Vulnerability',
                              widget.inputData['Vulnerability'] ?? '',
                              isSmallScreen),
                          _buildParameterRow('Defense',
                              widget.inputData['Defense'] ?? '', isSmallScreen),
                        ],
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 20 : 32),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PredictionFormScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF1A237E),
                              elevation: 8,
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    isSmallScreen ? 12 : 16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: isSmallScreen ? 16 : 20),
                                SizedBox(width: isSmallScreen ? 6 : 8),
                                Text(
                                  'New Analysis',
                                  style: GoogleFonts.inter(
                                    fontSize: isSmallScreen ? 12 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1A237E),
                              foregroundColor: Colors.white,
                              elevation: 8,
                              padding: EdgeInsets.symmetric(
                                vertical: isSmallScreen ? 12 : 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    isSmallScreen ? 12 : 16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home, size: isSmallScreen ? 16 : 20),
                                SizedBox(width: isSmallScreen ? 6 : 8),
                                Text(
                                  'Home',
                                  style: GoogleFonts.inter(
                                    fontSize: isSmallScreen ? 12 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (_showScrollToTop)
                Positioned(
                  right: isSmallScreen ? 8 : 16,
                  bottom: isSmallScreen ? 8 : 16,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _showScrollToTop ? 1.0 : 0.0,
                    child: FloatingActionButton.small(
                      onPressed: _scrollToTop,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_upward,
                          color: const Color(0xFF1A237E),
                          size: isSmallScreen ? 16 : 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParameterRow(String label, String value, bool isSmallScreen) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 12 : 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A237E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

