import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'National Constitution',
        'subtitle': 'Founding document and governing principles',
        'route': const ConstitutionScreen(),
        'icon': Icons.account_balance,
      },
      {
        'title': 'National Bylaws',
        'subtitle': 'Operational rules and procedures',
        'route': const BylawsScreen(),
        'icon': Icons.rule_folder,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('National Documents', style: theme.TextThemes.headlineSmall(context)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.redClr.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.description, color: theme.redClr),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Official Documents', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('Access constitutions, bylaws, and other national policies.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Document list
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surface,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => item['route'] as Widget));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: theme.redClr.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(item['icon'] as IconData, color: theme.redClr),
                          ),
                          title: Text(item['title'] as String, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                          subtitle: Text(item['subtitle'] as String, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConstitutionScreen extends StatelessWidget {
  const ConstitutionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Constitution', style: theme.TextThemes.headlineSmall(context)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.redClr.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.account_balance, color: theme.redClr),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('National Constitution', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('View the official constitution document.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: PDFViewer(pdfPath: 'assets/docs/constitution.pdf',)),
        ],
      ),
    );
  }
}


class BylawsScreen extends StatelessWidget {
  const BylawsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bylaws', style: theme.TextThemes.headlineSmall(context)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.redClr.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.rule_folder, color: theme.redClr),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('National Bylaws', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text('Review bylaws and governance procedures.', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(child: PDFViewer(pdfPath: 'assets/docs/bylaws.pdf'))
        ],
      ),
    );
  }
}


class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key, required this.pdfPath});
  final String pdfPath;
  @override
  Widget build(BuildContext context) {
    return PDF(
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: true,
      pageFling: false,
      onError: (error) {
        print('Error: ${error.toString}');
      }
    ).fromAsset(pdfPath);
  }
}