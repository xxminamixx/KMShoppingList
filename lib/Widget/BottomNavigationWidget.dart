import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_shopping_list/Widget/BottomNavigationIndexCubit.dart';
import 'package:km_shopping_list/Widget/HomeWidget.dart';

class BottomNavigationWidget extends StatelessWidget {
  /* タブに表示するWidget配列 */
  final List<Widget> _tabItem = [
    HomeWidget(),
    HomeWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavigationIndexCubit(),
      child: BlocBuilder<BottomNavigationIndexCubit, int>(
          builder: (builderContext, index) {
            return _mainWidget(builderContext, index);
          }),
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
              icon: Icon(Icons.shopping_cart_rounded),
              label: '登録',
            ),
          ],
          currentIndex: index,
          onTap: (index) {
            context.read<BottomNavigationIndexCubit>().changeIndex(index);
          }
      ),
    );
  }

}
