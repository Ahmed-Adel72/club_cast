import 'package:flutter/material.dart';

import 'model_sheet_room_contant.dart';

Widget listenersWiget({
  required cubit,
}) {
  return Row(
    children: [
      Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: cubit.listener.length,
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                showBottomSheet(
                  backgroundColor: Theme.of(context).backgroundColor,
                  elevation: 25,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  context: context,
                  builder: (context) {
                    return WidgetFunc.bottomSheetContant(
                      context,
                      cubit.listener[index]['name'],
                      cubit.listener[index]['photo'],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 3,
                            color: Theme.of(context).backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                'Follow',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                          Card(
                            elevation: 3,
                            color: Theme.of(context).backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                'Make Him Speaker',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        cubit.listener[index]['photo'],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      cubit.listener[index]['name'],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
          ),
        ),
      ),
    ],
  );
}
