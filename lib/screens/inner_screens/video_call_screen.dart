import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/models/user_model.dart';
import 'package:clone_zoom/resources/firebase_methods.dart';
import 'package:clone_zoom/resources/jitsi_meet_methods.dart';
import 'package:clone_zoom/widgets/custom_text_button.dart';
import 'package:clone_zoom/widgets/input_text_field.dart';
import 'package:clone_zoom/widgets/switch_option.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isAudioMuted = true;
  bool _isVideoMuted = true;
  bool _isLoading = false;

  void _toggleMuteVideo(bool val) {
    setState(() {
      _isVideoMuted = val;
    });
  }

  void _toggleMuteAudio(bool val) {
    setState(() {
      _isAudioMuted = val;
    });
  }

  Future<void> _joinMeeting({required String roomName}) async {
    final JitsiMeetMethods jitsiMeetMethods = JitsiMeetMethods();
    final UserModel userModel = await FirebaseMethods().getUserDetails(
      firebaseAuth.currentUser!.uid,
    );

    jitsiMeetMethods.joinMeeting(
      roomName: _roomController.text,
      username: userModel.username,
      imageUrl: _nameController.text.isEmpty
          ? userModel.profileImage
          : _nameController.text,
      email: userModel.email,
      isAudioMuted: _isAudioMuted,
      isVideoMuted: _isVideoMuted,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _roomController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join a meeting', style: TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputTextField(
                controller: _roomController,
                labelText: 'Room Name',
                hintText: 'Enter a room name',
                shouldValidate: true,
              ),
              SizedBox(height: 20),
              InputTextField(
                controller: _nameController,
                labelText: 'Displayed Name (Optional)',
                hintText: 'Enter a your displayed name',
              ),
              SizedBox(height: 20),

              SwitchOption(
                text: 'Mute Audio',
                isMuted: _isAudioMuted,
                onChanged: (val) => _toggleMuteAudio(val),
              ),
              SizedBox(height: 20),
              SwitchOption(
                text: 'Mute Video',
                isMuted: _isVideoMuted,
                onChanged: (val) => _toggleMuteVideo(val),
              ),
              SizedBox(height: 20),
              CustomTextButton(
                backgroundColor: backgroundColor,
                borderColor: secondaryColor,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _isLoading = true);
                    await _joinMeeting(
                      roomName: _roomController.text,
                    ).whenComplete(() => setState(() => _isLoading = true));
                  }
                },
                child: _isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: const CircularProgressIndicator(),
                      )
                    : Text(
                        'Join',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
