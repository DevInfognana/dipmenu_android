import 'package:dip_menu/core/config/app_extension.dart';
import 'package:dip_menu/core/enum/permission_handling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../logic/controller/edit_profile_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';


// ignore: must_be_immutable
class ProfilePictureUpdate extends StatefulWidget {
  ProfilePictureUpdate({Key? key, this.controller, this.imageUrl})
      : super(key: key);
  EditProfileController? controller;
  String? imageUrl;

  @override
  State<ProfilePictureUpdate> createState() => _ProfilePictureUpdateState();
}

class _ProfilePictureUpdateState extends State<ProfilePictureUpdate> {
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<EditProfileController>(builder: (controller){
        // print('----ee-->${controller.imageFile}');
        // print('----e1-->${controller.fileNamevalue}');
        return SizedBox(
          width: 35.w,
          height: 25.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.imageUrl!.isEmpty
                  ? (controller.fileNamevalue != null
                  ? CircleAvatar(
                radius: 75,
                child: ClipOval(
                    child: Image.file(
                      controller.imageFile!,
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    )),
              )
                  : const CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                    'https://m.media-amazon.com/images/I/41ONa5HOwfL.jpg'),
              ))
                  : CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(imageview(widget.imageUrl!)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: GestureDetector(
                  onTap: () {

                    if (PermissionHandler.requestMediaPermission() == false) {
                      PermissionHandler.requestMediaPermission();
                    } else {
                      photoClick();
                      // SharedPrefs.instance.setBool("notification", true);
                    }
                  },
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.indigo[400],
                    size: 35,
                  ),
                ),
              )
            ],
          ),
        );
      });
  }

  photoClick() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        _getFromGallery();
                        Get.back();
                      },
                      child: Text(NameValues.pickFromGallery.tr,style: TextStyle(color: Colors.white),)),
                  const SizedBox(width: 10.0),
                  ElevatedButton(
                      onPressed: () {
                        _getFromCamera();
                        Get.back();
                      },
                      child: Text(NameValues.pickFromCamera.tr,style: TextStyle(color: Colors.white)))
                ],
              ),
            )
          ],
        );
      },
    );
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      // maxWidth: 300,
      // maxHeight: 300,
    );
    if (pickedFile != null) {
      widget.controller!.changeValues(pickedFile);
      widget.imageUrl = '';
      // setState(() {
      //   widget.controller!.imageFile = File(pickedFile.path);
      //   String fileName = pickedFile.path.split("image_picker").last;
      //   widget.controller!.fileNamevalue =
      //       fileName.replaceAll(fileName, 'upload_image');
      //   widget.imageUrl = '';
      //   widget.controller!.imageupload = true;
      // });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      // maxWidth: 900,
      // maxHeight: 800,
    );
    if (pickedFile != null) {
      widget.controller!.changeValues(pickedFile);
      widget.imageUrl = '';
      // setState(() {
      //   widget.controller!.imageFile = File(pickedFile.path);
      //   String fileName = pickedFile.path.split("image_picker").last;
      //   widget.controller!.fileNamevalue =
      //       fileName.replaceAll(fileName, 'upload_image');
      //   widget.imageUrl = '';
      //   widget.controller!.imageupload = true;
      // });
    }
  }
}

// ignore: must_be_immutable
class ProfilePictureView extends StatefulWidget {
  ProfilePictureView(
      {Key? key, this.imageUrl, this.name, this.mobileNumber, this.onChanged1})
      : super(key: key);

  String? imageUrl;
  String? name;
  String? mobileNumber;
  final Function()? onChanged1;

  @override
  State<ProfilePictureView> createState() => _ProfilePictureViewState();
}

class _ProfilePictureViewState extends State<ProfilePictureView> {
  @override
  Widget build(BuildContext context) {
    Color? color =Get.isDarkMode?Colors.white: Colors.black;
    return Row(
      children: [
        widget.imageUrl == null
            ? imageShow('https://m.media-amazon.com/images/I/41ONa5HOwfL.jpg')
            : imageShow(imageview(widget.imageUrl!)),
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(widget.name!.toCapital,
                style: context.theme.textTheme.displaySmall!.copyWith(
                    color: color, fontWeight: FontWeight.w700)),
            Text(widget.mobileNumber!,
                style: context.theme.textTheme.displaySmall!.copyWith(
                    color: color, fontWeight: FontWeight.w500)),
          ],
        ),
        const Spacer(flex: 3),
        InkWell(
          onTap: () {
            widget.onChanged1!();
          },
          child: Text('Edit Profile',
              style: context.theme.textTheme.headlineSmall!
                  .copyWith(color: mainColor, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
      ],
    );
  }

  imageShow(String imageView) {
    return InkWell(
      onTap: () {
        _showSimpleDialog(imageView);
      },
      child: Container(
          padding: EdgeInsets.only(top: 2.h, left: 2.h, right: 2.h),
          child: CircleAvatar(
              radius: 10.w, backgroundImage: NetworkImage(imageView))),
    );
  }
}

Future<void> _showSimpleDialog(String imageView) async {
  await showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          // title: Text(SharedPrefs.instance.getString('first_name')!),
          // titleTextStyle: TextStore.textTheme.headlineMedium!
          //     .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
          alignment: Alignment.center,
          children: <Widget>[
            Stack(
              children: [
                Container(
                    height: 30.h,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 1.h, left: 1.h, right: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(imageView), fit: BoxFit.fill))),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 4.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12),
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.w, top: 1.h),
                      child: Text(SharedPrefs.instance.getString('first_name')!,
                          style: context.theme.textTheme.headlineMedium!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      });
}



// ignore: must_be_immutable
class ListTileShow1 extends StatelessWidget {
  ListTileShow1({Key? key, this.icon1, this.icon2, this.title, this.values})
      : super(key: key);
  IconData? icon1;
  IconData? icon2;
  String? title;
  String? values;

  @override
  Widget build(BuildContext context) {
    Color? color =Get.isDarkMode?Colors.white: borderColor;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 1.w, right: 5.w),
      leading: FittedBox(
          fit: BoxFit.fill,
          child: Icon(icon1, color: color, size: 16.sp)),
      title: Text(title!,
          style: context.theme.textTheme.headlineMedium!
              .copyWith(color: color, fontWeight: FontWeight.w400)),
      trailing: Container(
          padding: EdgeInsets.all(0.4.h),
          height: 4.5.h,
          width: 32.w,
          decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: BorderRadius.circular(2.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon2, color: Colors.black, size: 5.w),
              Text(values!,
                  style: context.theme.textTheme.headlineSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400)),
            ],
          )),
    );
  }
}


class ListTileShow2 extends StatelessWidget {
  ListTileShow2({Key? key, this.icon1, this.title, this.values})
      : super(key: key);
  IconData? icon1;
  String? title;
  String? values;

  @override
  Widget build(BuildContext context) {
    Color? color =Get.isDarkMode?Colors.white: borderColor;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 1.w, right: 5.w),
      leading: FittedBox(
          fit: BoxFit.fill,
          child: Icon(icon1, color: color, size: 16.sp)),
      title: Text(title!,
          style: context.theme.textTheme.headlineMedium!
              .copyWith(color: color, fontWeight: FontWeight.w400)),
      trailing: Container(
          padding: EdgeInsets.all(0.4.h),
          height: 4.5.h,
          width: 32.w,
          decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: BorderRadius.circular(2.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ImageIcon(const AssetImage(ImageAsset.rewardIcon),color: Colors.black,size: 5.w,),
              Text(values!,
                  style: context.theme.textTheme.headlineSmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w400)),
            ],
          )),
    );
  }
}