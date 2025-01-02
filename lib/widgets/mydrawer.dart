import 'package:agecalculator/theme/theme_provider.dart';
import 'package:agecalculator/widgets/custom_logout_dialog.dart';
import 'package:agecalculator/widgets/customdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:agecalculator/utils/const.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Drawer(
          backgroundColor:
              themeProvider.isDarkMode ? AppColors.kTextAndIconColor : AppColors.kContentColor,
          child: Container(
            color: themeProvider.isDarkMode ? AppColors.kTextAndIconColor : AppColors.kContentColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerHeader(themeProvider),
                _buildDrawerSection(
                  context: context,
                  items: [
                    _buildDrawerItem(
                      icon: Icons.help_outline,
                      title: 'المساعدة',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              title: "المساعدة",
                              message:
                                  "  للمساعدة يمكنك التواصل مع فريق الدعم الخاص بالتطبيق على   717281413  ",
                              icon: Icons.help_outline,
                              iconColor: AppColors.kTextAndIconColor,
                              buttonColor: AppColors.kTextAndIconColor,
                              onClose: () => Navigator.pop(context),
                            );
                          },
                        );
                      },
                      themeProvider: themeProvider,
                    ),
                    _buildCustomDivider(themeProvider),
                    _buildDrawerItem(
                      icon: Icons.info_outline,
                      title: 'حول التطبيق',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              title: "حول التطبيق",
                              message:
                                  "تطبيق حساب العمر هو تطبيق يمكنك من خلاله حساب عمرك وتحديد عمرك وكذلك تحديد عمر صديقك.",
                              icon: Icons.info_outline,
                              iconColor: AppColors.kTextAndIconColor,
                              buttonColor: AppColors.kTextAndIconColor,
                              onClose: () => Navigator.pop(context),
                            );
                          },
                        );
                      },
                      themeProvider: themeProvider,
                    ),
                  ],
                ),
                _buildCustomDivider(themeProvider),
                _buildDrawerSection(
                  context: context,
                  items: [
                    _buildDrawerItem(
                      icon: Icons.logout,
                      title: 'تسجيل الخروج',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomLogoutDialog(
                              context,
                              onLogout: () {
                                Navigator.pop(context);
                                SystemNavigator.pop();
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      themeProvider: themeProvider,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required ThemeProvider themeProvider,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      tileColor: themeProvider.isDarkMode
          ? Colors.grey[800]?.withOpacity(0.1)
          : Colors.grey[200]?.withOpacity(0.1),
    );
  }

  Widget _buildDrawerSection({
    required BuildContext context,
    required List<Widget> items,
  }) {
    return Column(
      children: items,
    );
  }

  Widget _buildDrawerHeader(ThemeProvider themeProvider) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: themeProvider.isDarkMode ? AppColors.kTextAndIconColor : AppColors.kContentColor,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(1),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: CircleAvatar(
                foregroundColor:
                    themeProvider.isDarkMode ? AppColors.kContentColor : AppColors.kTextAndIconColor,
                radius: 50,
                backgroundColor: AppColors.kTextAndIconColor,
                child: Text(
                  'عمرك',
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? AppColors.kContentColor
                        : AppColors.kContentColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDivider(ThemeProvider themeProvider) {
    return Divider(
      color: themeProvider.isDarkMode ? AppColors.kContentColor : AppColors.kTextAndIconColor,
      thickness: 0.8,
      height: 15,
      indent: 20,
      endIndent: 20,
    );
  }
}
