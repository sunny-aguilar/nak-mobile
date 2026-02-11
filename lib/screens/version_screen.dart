import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/constants.dart' as constants;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              onPressed: () {
                // TODO: Implement email contact
              },
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
}