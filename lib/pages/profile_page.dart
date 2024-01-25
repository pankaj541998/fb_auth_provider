import 'package:firebase_auth_provider/providers/profile/profile_provider.dart';
import 'package:firebase_auth_provider/providers/profile/profile_state.dart';
import 'package:firebase_auth_provider/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  // static const String routeName = '/profilePage';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileProvider profileProv;

  @override
  void initState() {
    super.initState();
    profileProv = context.read<ProfileProvider>();
    profileProv.addListener(errorDialogListener);
    getFrofile();
  }

  void getFrofile() {
    final String uid = context.read<fb_auth.User?>()!.uid;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read<ProfileProvider>().getProfile(uid: uid);
    });
  }

  void errorDialogListener() {
    if (profileProv.state.profileStatus == ProfileStatus.error) {
      errorDailog(context, profileProv.state.customError);
    }
  }

  @override
  void dispose() {
    super.dispose();
    profileProv.removeListener(errorDialogListener);
  }

  Widget _buildProfile() {
    final profileState = context.read<ProfileProvider>().state;

    if (profileState.profileStatus == ProfileStatus.initial) {
      return Container();
    } else if (profileState.profileStatus == ProfileStatus.loading) {
      return const CircularProgressIndicator();
    } else if (profileState.profileStatus == ProfileStatus.error) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://imgs.search.brave.com/Mj9wECnjc6IqkreXHSyuFa-9KUTyyUCdutHVjQo3Fxg/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9jZG4x/Lmljb25maW5kZXIu/Y29tL2RhdGEvaWNv/bnMvY29sb3ItYm9s/ZC1zdHlsZS8yMS8w/OC01MTIucG5n',
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Oops!\nTry again',
              style: TextStyle(fontSize: 20.0, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/loadig.gif',
            image: profileState.user.profileImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
           Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('- id: ${profileState.user.id}',style: const TextStyle(fontSize: 18.0),),
                const SizedBox(height: 10.0),
                Text('- name: ${profileState.user.name}',style:const  TextStyle(fontSize: 18.0),),
                const SizedBox(height: 10.0),
                Text('- Email: ${profileState.user.email}',style:const  TextStyle(fontSize: 18.0),),
                const SizedBox(height: 10.0),
                Text('- point: ${profileState.user.point}',style:const  TextStyle(fontSize: 18.0),),
                const SizedBox(height: 10.0),
                Text('- rank: ${profileState.user.rank}',style:const  TextStyle(fontSize: 18.0),),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'),),
      body: _buildProfile(),
    );
  }
}
