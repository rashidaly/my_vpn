import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:lottie/lottie.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:vpn_app/custom/utils.dart';
import '../custom/curved_drwaer.dart';
import '../custom/dropdown_button.dart';
import '../custom/timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late OpenVPN engine;
  VpnStatus? status;
  VPNStage? stage;
  bool _granted = false;
  @override
  void initState() {
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        setState(() {
          status = data;
        });
      },
      onVpnStageChanged: (data, raw) {
        setState(() {
          stage = data;
        });
      },
    );

    engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier: "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (stage) {
        setState(() {
          this.stage = stage;
        });
      },
      lastStatus: (status) {
        setState(() {
          this.status = status;
        });
      },
    );
    super.initState();
  }

  Future<void> initPlatformState() async {
    engine.connect(config, "USA", username: defaultVpnUsername,
         password: defaultVpnPassword, certIsRequired: true);
    if (!mounted) return;
  }


  double downloadRate = 0;
  double uploadRate = 0;
  String downloadProgress = '0';
  String uploadProgress = '0';

  String unitText = 'Mb/s';



  bool isActive = false;



  GlobalKey<ScaffoldState> _scafoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scafoldkey,
         drawer: Playground(title: '',),

        body: Stack(
          children: [
          Positioned(
            top: 10.h,
              left: 250.w,
              height: 200.h,
              child:  Container(

                child: isActive == true ? Lottie.asset('assets/images/26941-global-network.json'

                ) : Image.asset('assets/images/earthpic.png'),

          )),
            Positioned(
                bottom: 120.h,
                left: 20.w,
                height: 150.h,
                child: Container(
                  child: Image.asset('assets/images/vpn1.png'),

                )),


            Container(
              alignment: Alignment(0.0, -0.49),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-1.0, -0.97),
                  end: Alignment.center,
                  colors: [
                    const Color(0xFF623896).withOpacity(0.93),
                    const Color(0xFF2B174B).withOpacity(0.93)
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(),
                    upperCurvedContainer(context),
                    circularWidget(context),

                    SizedBox(height: 20.h),
                    connectedStatusText(),


                    isActive == true
                        ? CountTime()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Image.asset('assets/images/time.png',
                              color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                                '00: 00: 00',
                                style: isActive == true
                                    ? connectedSubtitle
                                    : disConnectedSubtitle,
                              ),
                          ],
                        ),
                    // CountTime(),
                    SizedBox(height: 20.h),
                    // We need to pass parameters to this widget
                    DropDownList(),
                  ],
                ),
              ),
            ),
            IconButton(onPressed: (){
              _scafoldkey.currentState?.openDrawer();
            }, icon: const Icon(Icons.menu,
            color: Colors.white,
            ))
          ],
        ),
      ),
    );
  }

  Widget upperCurvedContainer(BuildContext context) {
    return ClipPath(
      //  clipper: MyCustomClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 26.h),
        height: 360.h,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //   _topRow(),
            Text('My VPN', style: vpnStyle),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: UploadCon(),
            ),

            //_bottomRow(),
          ],
        ),
      ),
    );
  }

  Widget circularWidget(BuildContext context) {
    return InkWell(
      onTap: () async {
        initPlatformState();
        var connectivityResult = await (Connectivity().checkConnectivity());
       // bool result = await InternetConnectionChecker().hasConnection;
        if (connectivityResult == ConnectivityResult.mobile) {
          setState(() {
            isActive = !isActive;
          });

        }  else if(connectivityResult == ConnectivityResult.wifi) {
          setState(() {
            isActive = !isActive;
          });
        }

        else {

          showAlertDialog(context);

        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            boxShadow:  [
              BoxShadow(
                color: Colors.greenAccent,
                blurRadius: 5.r,
                spreadRadius: 3.r,
              ),
            ],
          color: isActive ? Color(0xFFFFA25B) : Colors.greenAccent,
          shape: BoxShape.circle,
        ),
        child: Container(
          height: 150.h,
          width: 150.w,
          decoration:
              const BoxDecoration(
                  color: Color(0xFF62349B), shape: BoxShape.circle,


              ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: isActive == true
                    ? Lottie.asset(
                        'assets/images/71509-double-circles-yellow.json',
                        height: 70.h,
                        width: 70.w,
                      )
                    : Image.asset(
                        'assets/images/power-on.png',
                        color: Colors.greenAccent,
                        height: 50.h,
                        width: 50.w,
                      ),
              ),
              SizedBox(height: 20.h),
              Text(
                isActive == true ? 'STOP' : 'START',
                style: TextStyle(
                    color: isActive == true
                        ? Color(0xFFFFA25B)
                        : Colors.greenAccent,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget connectedStatusText() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(text: 'Status :', style: connectedStyle, children: [
          TextSpan(
              text: isActive == true ? ' connected\n' : ' Disconnect\n',
              style: isActive == true
                  ? disConnectedGreenStyle
                  : connectedGreenStyle),
          //const TextSpan(text: '00:22:45', style: connectedSubtitle),
        ]),
      ),
    );
  }

  Widget premium(){
    return Container(
      height: 60.h,
      width: 300.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.r,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: Color(0xFF552572),
      ),
      child: Row(
        children: const [
          Text('Premium')
        ],
      ),
    );
  }

  Widget UploadCon() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 40.h,
              width: 40.w,
              child: isActive == true
                  ? Lottie.asset('assets/images/7877-uploading-to-cloud.json')
                  : Image.asset('assets/images/img.png')),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                'UPLOAD',
                style: TextStyle(
                  fontFamily: 'Sama Devanagari',
                  fontSize: 15.sp,
                  color: const Color(0xFFF8F806),
                  fontWeight: FontWeight.w700,
                ),
              ),

              Text(
                '342kb/s',
                style: TextStyle(
                  fontFamily: 'Sama Devanagari',
                  fontSize: 12.sp,
                  color: Color(0xFFE6B40D),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const VerticalDivider(
            indent: 10,
            endIndent: 10,
            color: Colors.white,
          ),
          Container(
              height: 40.h,
              width: 40.w,
              child: isActive == true
                  ? Lottie.asset(
                      'assets/images/5265-download-icon-give-a-new-look-to-your-work.json')
                  : Image.asset('assets/images/img_1.png')),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DOWNLOAD',
                style: TextStyle(
                  fontFamily: 'Sama Devanagari',
                  fontSize: 15.sp,
                  color: const Color(0xFF73F713),
                  fontWeight: FontWeight.w700,
                ),
              ),
            //  isActive == true ? downloadMb(context) :
              Text(
                '71kb/s',
                style: TextStyle(
                  fontFamily: 'Sama Devanagari',
                  fontSize: 12.sp,
                  color: const Color(0xFF5FCB2F),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
      height: 60.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.r,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: Color(0xFF552572),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.sp
      ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: bgColor,
      title: const Text("No Internet",
      style: TextStyle(
        color: Colors.white
      ),
      ),
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Lottie.asset('assets/images/71559-no-internet.json',
            fit: BoxFit.cover,
          ),

        ],
      ),

      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static const String defaultVpnUsername = "";
  static const String defaultVpnPassword = "";

  String config = """ 
  PUT YOUR OPENVPN SCRIPT HERE
""";
}
