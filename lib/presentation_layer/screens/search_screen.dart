import 'package:club_cast/data_layer/bloc/intial_cubit/general_app_cubit_states.dart';
import 'package:club_cast/data_layer/cash/cash.dart';
import 'package:club_cast/presentation_layer/components/component/component.dart';
import 'package:club_cast/presentation_layer/models/user_model.dart';
import 'package:club_cast/presentation_layer/screens/profile_detailes_screen.dart';
import 'package:club_cast/presentation_layer/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/bloc/intial_cubit/general_app_cubit.dart';
import 'explore_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  String token = CachHelper.getData(key: 'token');
  @override
  Widget build(BuildContext context) {
    var cubit = GeneralAppCubit.get(context);
    searchController.addListener(() {
      Future.delayed(Duration(seconds: 1), () {
        cubit.userSearch(
          token: token,
          value: searchController.text,
        );
      });
    });
    return BlocConsumer<GeneralAppCubit, GeneralAppStates>(
      listener: (context, index) {},
      builder: (context, index) {
        return WillPopScope(
          onWillPop: () async {
            cubit.isProfilePage = false;
            Navigator.of(context).pop();
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  cubit.isProfilePage = false;
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  defaultTextFormField(
                    context: context,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    labelText: "Search About User",
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    onChanged: (value) {
                      // cubit.userSearch(
                      //   token: token,
                      //   value: value,
                      // );
                    },
                    onSubmit: (value) {},
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  cubit.isSearch
                      ? LinearProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 12.0,
                  ),
                  cubit.search == null
                      ? Center(
                          child: Text(
                            'Waiting to search',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: cubit.search!['data'].length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      cubit.getUserPodcast(
                                        token,
                                        cubit.search!['data'][index]['_id'],
                                      );

                                      print(
                                          cubit.search!['data'][index]['_id']);
                                      cubit.getUserById(
                                          profileId: cubit.search!['data']
                                                  [index]['_id']
                                              .toString());
                                      if (cubit.search!['data'][index]['_id']
                                              .toString() ==
                                          GetUserModel.getUserID()) {
                                        navigatePushTo(
                                            context: context,
                                            navigateTo: UserProfileScreen());
                                      } else {
                                        navigatePushTo(
                                            context: context,
                                            navigateTo: ProfileDetailsScreen(
                                                cubit.search!['data'][index]
                                                    ['_id']));
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            cubit.search!['data'][index]
                                                        ['photo'] ==
                                                    null
                                                ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3-lQXGq-2WPJR5aE_l74q-mR61wDrZXUYhA&usqp=CAU'
                                                : cubit.search!['data'][index]
                                                    ['photo'],
                                          ),
                                        ),
                                        title: Text(
                                          cubit.search!['data'][index]['name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              defaultButton(
                                onPressed: () {
                                  cubit.getExplorePodcast(token: token);
                                  navigatePushTo(
                                    context: context,
                                    navigateTo: ExploreScreen(),
                                  );
                                },
                                context: context,
                                text: 'Explore',
                                width: 150,
                                radius: 25,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
