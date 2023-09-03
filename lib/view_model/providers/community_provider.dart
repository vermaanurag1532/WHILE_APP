import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:while_app/resources/components/message/apis.dart';
import 'package:while_app/resources/components/message/models/community_user.dart';

class CommunityProviders extends StateNotifier<CommunityUser> {
  CommunityProviders()
      : super(CommunityUser(
            image: 'aa',
            about: 'about',
            name: 'Ankit',
            createdAt: 'createdAt',
            id: 'id',
            email: 'email',
            type: 'type',
            noOfUsers: 'noOfUsers',
            domain: 'domain',
            admin: 'admin'));

  void changeName(CommunityUser community) {
    var data = APIs.getCommunityInfos(community);

    state = CommunityUser(
        image: data.image,
        about: data.about,
        name: data.name,
        createdAt: data.createdAt,
        id: data.id,
        email: data.email,
        type: data.type,
        noOfUsers: data.noOfUsers,
        domain: data.domain,
        admin: data.admin);
    log('//image');
    log(state.image);
  }
}

final communityProvider =
    StateNotifierProvider<CommunityProviders, CommunityUser>(
  (ref) {
    return CommunityProviders();
  },
);
