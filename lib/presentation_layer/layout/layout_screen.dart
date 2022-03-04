import 'package:club_cast/data_layer/bloc/intial_cubit/general_app_cubit.dart';
import 'package:club_cast/presentation_layer/widgets/components/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../data_layer/bloc/intial_cubit/general_app_cubit_states.dart';
import '../screens/setup_avater_screen.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GeneralAppCubit, GeneralAppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = GeneralAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Rooms',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 25),
              ),
              actions: [
                IconButton(
                  splashRadius: 30,
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    navigatePushANDRemoveRout(
                        context: context, navigateTo: SetUpAvatarScreen());
                  },
                  child: const CircleAvatar(
                    radius: 23,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomNavBarItem,
              currentIndex: cubit.bottomNavIndex,
              onTap: (index) {
                cubit.changeBottomNAvIndex(index);
              },
            ),
            body: cubit.screen[cubit.bottomNavIndex],
          );
        });
  }
}
