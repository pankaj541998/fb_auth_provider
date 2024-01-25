import 'package:firebase_auth_provider/providers/profile/profile_provider.dart';
import 'package:firebase_auth_provider/providers/profile/profile_state.dart';
import 'package:firebase_auth_provider/utils/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

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
    // TODO: implement initState
    super.initState();
    profileProv= context.read<ProfileProvider>();
    profileProv.addListener(errorDialogListener);
    getFrofile();
  }

void  getFrofile(){
  final String uid = context.read<fbAuth.User?>()!.uid;
  WidgetsBinding.instance!.addPostFrameCallback((_) {
    context.read<ProfileProvider>().getProfile(uid: uid);
  });

  }

  void errorDialogListener(){
    if(profileProv.state.profileStatus == ProfileStatus.error){
      errorDailog(context, profileProv.state.customError);
    }
  }

  @override
  void dispose() {
    super.dispose();
    profileProv.removeListener(errorDialogListener);
  }

  // Widget _buildProfile(){
  //   final profileState = context.read<ProfileProvider>().state;

  //   if(profileState.profileStatus == ProfileStatus.initial){
  //     return Container();
  //   }else if(profileState.profileStatus == ProfileStatus.loading){
  //     return CircularProgressIndicator();
  //   }else if(profileState.profileStatus == ProfileStatus.error){
  //     return Center(child: Row(
  //       children: [
  //         Image.network('',width: 75,height: 75,),
  //         const SizedBox(height: 20),
  //         const Text('Oops!\nTry again',style:  TextStyle(fontSize: 20.0,color: Colors.red),textAlign: TextAlign.center,),
  //       ],
  //     ),);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Profile'),),);
  }
}