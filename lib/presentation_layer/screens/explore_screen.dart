import 'package:club_cast/data_layer/bloc/intial_cubit/general_app_cubit.dart';
import 'package:club_cast/data_layer/bloc/intial_cubit/general_app_cubit_states.dart';
import 'package:club_cast/presentation_layer/components/component/component.dart';
import 'package:club_cast/presentation_layer/models/explore_podcasts_model.dart';
import 'package:club_cast/presentation_layer/models/user_model.dart';
import 'package:club_cast/presentation_layer/screens/profile_detailes_screen.dart';
import 'package:club_cast/presentation_layer/screens/user_profile_screen.dart';
import 'package:club_cast/presentation_layer/widgets/playingCardWidget.dart';
import 'package:club_cast/presentation_layer/widgets/pos_cast_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/constant/constant.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = GeneralAppCubit?.get(context);
    String? currentId;
    currentId = cubit.activePodCastId;
    return BlocConsumer<GeneralAppCubit, GeneralAppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Explore',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: cubit.loadingExplore
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: GetExplorePodCastModel
                                .getExplorePodCast?['data'].length,
                            itemBuilder: (context, index) {
                              return podACastItem(
                                context,
                                index: index,
                                downloadButton:
                                    PlayingCardWidget.downloadingWidget(
                                        currentId.toString(),
                                        index,
                                        GetExplorePodCastModel.getPodcastID(
                                            index),
                                        cubit,
                                        context,
                                        GetExplorePodCastModel.getPodCastAudio(
                                            index)[0]['url'],
                                        GetExplorePodCastModel.getPodcastName(
                                            index)),
                                likeWidget: PlayingCardWidget.likeState(
                                  context,
                                  GetExplorePodCastModel.getPodcastlikeState(
                                      index),
                                  GetExplorePodCastModel.getPodcastID(index),
                                  token,
                                  '',
                                ),
                                podCastLikes: PlayingCardWidget.podCastLikes(
                                    context,
                                    cubit,
                                    token,
                                    index,
                                    GetExplorePodCastModel.getPodcastID(index),
                                    GetExplorePodCastModel.getPodcastLikes(
                                            index)
                                        .toString()),
                                removePodCast: SizedBox(),
                                playingWidget: PlayingCardWidget.playingButton(
                                    index,
                                    cubit,
                                    GetExplorePodCastModel.getPodCastAudio(
                                        index)[0]['url'],
                                    currentId.toString(),
                                    GetExplorePodCastModel.getPodcastID(index),
                                    GetExplorePodCastModel.getPodcastName(
                                        index),
                                    GetExplorePodCastModel
                                        .getPodcastUserPublishInform(
                                            index)[0]['photo']),
                                gettime: GetExplorePodCastModel.getPodCastAudio(
                                    index)[0]['duration'],
                                photourl: GetExplorePodCastModel
                                        .getPodcastUserPublishInform(index)[0]
                                    ['photo'],
                                ontapOnCircleAvater: () {
                                  if (GetUserModel.getUserID() ==
                                      GetExplorePodCastModel
                                          .getPodcastUserPublishInform(
                                              index)[0]['_id']) {
                                    cubit.getUserById(
                                        profileId: GetExplorePodCastModel
                                            .getPodcastUserPublishInform(
                                                index)[0]['_id']);
                                    cubit.getMyPodCast(
                                      token,
                                    );
                                    navigatePushTo(
                                        context: context,
                                        navigateTo: UserProfileScreen());
                                  } else {
                                    cubit.getUserById(
                                        profileId: GetExplorePodCastModel
                                            .getPodcastUserPublishInform(
                                                index)[0]['_id']);
                                    cubit.getUserPodcast(
                                        token,
                                        GetExplorePodCastModel
                                            .getPodcastUserPublishInform(
                                                index)[0]['_id']);
                                    navigatePushTo(
                                        context: context,
                                        navigateTo: ProfileDetailsScreen(
                                            GetExplorePodCastModel
                                                .getPodcastUserPublishInform(
                                                    index)[0]['_id']));
                                  }
                                },
                                podcastName:
                                    GetExplorePodCastModel.getPodcastName(
                                        index),
                                userName: GetExplorePodCastModel
                                        .getPodcastUserPublishInform(index)[0]
                                    ['name'],
                                text: cubit.isPlaying &&
                                        GetExplorePodCastModel.getPodcastID(
                                                index) ==
                                            currentId
                                    ? cubit.currentOlayingDurathion
                                    : cubit.pressedPause &&
                                            GetExplorePodCastModel.getPodcastID(
                                                    index) ==
                                                currentId
                                        ? cubit.currentOlayingDurathion
                                        : null,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          cubit.noDataExplore
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    cubit.pageinathionExplore(
                                      token,
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    radius: 30,
                                    child: cubit.loadExplore
                                        ? CircularProgressIndicator(
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : Icon(
                                            Icons.arrow_downward,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
          );
        },
        listener: (context, state) {});
  }
}
