import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/constants.dart' as constants;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nak_app/components/mailer.dart' as mailer;

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

  /// Launch URL in app web view
  Future<void> _launchUrl(String path) async {
    final Uri url = Uri(scheme: 'https', host: 'www.github.com', path: path);
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0),
        actions: <Widget>[
          IconButton(
            icon: isDark
              ? const Icon(Icons.wb_sunny_outlined)
              : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header Section with Version Display
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.redClr,
                    theme.redClr.withValues(alpha: 0.8),
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Year Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.whiteClr.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.whiteClr.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'App ${constants.appVersion}',
                      style: const TextStyle(
                        color: theme.whiteClr,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Fraternity Name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NU ALPHA',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: theme.whiteClr,
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'KAPPA',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: theme.whiteClr,
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'FRATERNITY',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: theme.whiteClr,
                          fontFamily: 'Oswald',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Tagline
                  Text(
                    'Mind • Culture • Pride',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: theme.whiteClr.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contributors Section
                  _buildSectionHeader(context, 'MEET THE TEAM'),
                  const SizedBox(height: 16),
                  _buildContributorsCard(context),

                  const SizedBox(height: 40),

                  // Source Code Section
                  _buildSectionHeader(context, 'OPEN SOURCE'),
                  const SizedBox(height: 12),
                  _buildSourceCodeCard(context),

                  const SizedBox(height: 40),

                  // Support Section
                  _buildSectionHeader(context, 'SUPPORT THE PROJECT'),
                  const SizedBox(height: 12),
                  _buildSupportCard(context),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build section header with accent line
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 28,
          decoration: BoxDecoration(
            color: theme.redClr,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 1,
            fontFamily: 'Oswald',
          ),
        ),
      ],
    );
  }

  /// Build contributors card
  Widget _buildContributorsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Developed with passion by NAK brothers',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildContributorAvatar(
                    imageUrl: 'https://avatars.githubusercontent.com/u/24646981?v=4&size=64',
                    name: 'Sandro',
                    onTap: () => _launchUrl('/sunny-aguilar'),
                  ),
                  const SizedBox(width: 20),
                  _buildContributorAvatar(
                    imageAsset: 'assets/img/users/compliance_user.webp',
                    name: 'Carlos',
                  ),
                  const SizedBox(width: 20),
                  _buildContributorAvatar(
                    imageAsset: 'assets/img/users/jn_user.jpg',
                    name: 'Jason',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build individual contributor avatar
  Widget _buildContributorAvatar({
    String? imageUrl,
    String? imageAsset,
    required String name,
    VoidCallback? onTap,
  }) {
    Widget avatar;

    if (imageUrl != null) {
      avatar = GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: theme.redClr.withValues(alpha: 0.2),
              backgroundImage: NetworkImage(imageUrl),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.redClr.withValues(alpha: 0.8),
                    width: 3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else {
      avatar = Column(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: theme.redClr.withValues(alpha: 0.2),
            backgroundImage: AssetImage(imageAsset ?? ''),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.redClr.withValues(alpha: 0.8),
                  width: 3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }
    return avatar;
  }

  /// Build source code card
  Widget _buildSourceCodeCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.redClr.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.github,
                    color: theme.redClr,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NAK Mobile App',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Open-source on GitHub',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'The NAK App is an open-source project hosted on GitHub. Access is available to developers willing to join the team. Contact developer@nakinc.org for repository access.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _launchUrl('/sunny-aguilar/nak-mobile'),
              icon: const FaIcon(FontAwesomeIcons.github, size: 18),
              label: const Text('View on GitHub'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                foregroundColor: theme.redClr,
                side: const BorderSide(color: theme.redClr, width: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build support card
  Widget _buildSupportCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.orangeClr.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: theme.orangeClr,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Help Us Grow',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Contribute your skills',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'We\'re looking for talented individuals with expertise in:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 12),
            _buildSkillChip(context, '💻 App Development'),
            const SizedBox(height: 8),
            _buildSkillChip(context, '🎨 UI/UX Design'),
            const SizedBox(height: 8),
            _buildSkillChip(context, '🧪 QA Testing'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _showContactForm(context),
              icon: const Icon(Icons.mail_outline_rounded),
              label: const Text('Get in Touch'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build skill chip widget
  Widget _buildSkillChip(BuildContext context, String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        skill,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Show contact form dialog
  void _showContactForm(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameCtl = TextEditingController();
    final emailCtl = TextEditingController();
    final subjectCtl = TextEditingController();
    final messageCtl = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        bool isSending = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              titlePadding: const EdgeInsets.fromLTRB(20,16,20,0),
              contentPadding: const EdgeInsets.fromLTRB(20,12,20,20),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: theme.redClr.withValues(alpha: 0.12),
                    child: Icon(Icons.mail_outline_rounded, color: theme.redClr, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Contact the Team', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameCtl,
                        decoration: InputDecoration(
                          labelText: 'Your name',
                          hintText: 'John Doe',
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.04),
                        ),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailCtl,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'you@example.com',
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.04),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Please enter your email';
                          final emailReg = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                          return emailReg.hasMatch(v.trim()) ? null : 'Enter a valid email';
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: subjectCtl,
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.02),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: messageCtl,
                        decoration: InputDecoration(
                          labelText: 'Message',
                          alignLabelWithHint: true,
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.02),
                        ),
                        maxLines: 5,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a message' : null,
                      ),
                      const SizedBox(height: 16),

                      // Full width send button inside content for better touch target
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: isSending
                              ? null
                              : () async {
                                  if (!(_formKey.currentState?.validate() ?? false)) return;
                                  final name = nameCtl.text.trim();
                                  final email = emailCtl.text.trim();
                                  final subject = subjectCtl.text.trim();
                                  final message = messageCtl.text.trim();

                                  setState(() => isSending = true);
                                  await mailer.sendContactEmail(dialogContext, {
                                    'name': name,
                                    'email': email,
                                    'subject': subject.isEmpty ? 'App Contact' : subject,
                                    'message': message,
                                  });
                                  setState(() => isSending = false);
                                  if (dialogContext.mounted) Navigator.of(dialogContext).pop();
                                },
                          icon: isSending
                              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: theme.whiteClr))
                              : const Icon(Icons.send),
                          label: const Text('Send'),
                          style: FilledButton.styleFrom(
                            backgroundColor: theme.redClr,
                            foregroundColor: theme.whiteClr,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}