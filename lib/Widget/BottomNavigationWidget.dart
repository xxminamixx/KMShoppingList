import 'package:flutter/material.dart';
import 'package:km_shopping_list/Widget/BottomNavigationViewModel.dart';
import 'package:km_shopping_list/Widget/HomeWidget.dart';
import 'package:km_shopping_list/Widget/SettingWidget.dart';
import 'package:provider/provider.dart';

class BottomNavigationWidget extends StatelessWidget {
  /* タブに表示するWidget配列 */
  final List<Widget> _tabItem = [
    HomeWidget(),
    SettingWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BottomNavigationViewModel(),
        builder: (childContext, widget) {
          // indexを監視
          final index = childContext.select((BottomNavigationViewModel viewModel) => viewModel.index);
          return _mainWidget(childContext, index);
        },
    );
  }

  Widget _mainWidget(BuildContext context, int index) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: _tabItem,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check),
              label: 'リスト',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '設定',
            ),
          ],
          currentIndex: index,
          onTap: (index) {
            context.read<BottomNavigationViewModel>().changeIndex(index);
          }
      ),
    );
  }

}
