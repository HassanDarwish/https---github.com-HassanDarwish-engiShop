import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Helper/HappyShopString.dart';
//import 'package:engi_shop/HappyShop/desktop/singupdesktop.dart';
import 'package:engishop/widget/HappyShopbtn.dart';

import 'HappyShopLogin.dart';
import 'HappyShopMobailVerification.dart';

class HappyShopSingUp extends StatefulWidget {
  const HappyShopSingUp({Key? key}) : super(key: key);

  @override
  _HappyShopSingUpState createState() => _HappyShopSingUpState();
}

class _HappyShopSingUpState extends State<HappyShopSingUp>
    with TickerProviderStateMixin {
  bool _showPassword = false;
  bool visible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final ccodeController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String? name, email, password, mobile, id, countrycode, countryName;

  late Animation buttonSqueezeanimation;

  late AnimationController buttonController;

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      validatanimations();
    }
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  Future<void> validatanimations() async {
    await buttonController.reverse();
    Future.delayed(const Duration(milliseconds: 500)).then((_) async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HappyShopMobailVerification()));
    });
  }

  bool validateAndSave() {
    return true;
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: back(),
        child: Center(
          child: Column(
            children: <Widget>[
              subLogo(),
              expandedBottomView(),
            ],
          ),
        ),
      ),
    );
  }

  back() {
    return const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryLight2, primaryLight3],
          stops: [0, 1]),
    );
  }

  subLogo() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: Center(
        child: SvgPicture.network(
          'https://smartkit.wrteam.in/smartkit/images/happyshopwhitelogo.svg',
          width: 80.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  registerTxt() {
    return Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Center(
          child: Text(USER_REGISTRATION,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: lightblack)),
        ));
  }

  setUserName() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: nameController,
        onSaved: (String? value) {
          name = value;
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline),
            hintText: NAMEHINT_LBL,
            prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  setCountryCode() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.9;
    return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
        child: Container(
          width: width,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: darkgrey)),
          child: CountryCodePicker(
              showCountryOnly: false,
              searchDecoration: const InputDecoration(
                hintText: COUNTRY_CODE_LBL,
                fillColor: primary,
              ),
              showOnlyCountryWhenClosed: false,
              initialSelection: 'IN',
              dialogSize: Size(width, height),
              alignLeft: true,
              builder: _buildCountryPicker,
              onChanged: (CountryCode countryCode) {
                countrycode = countryCode.toString().replaceFirst("+", "");
                print("New Country selected: $countryCode");
                countryName = countryCode.name;
              },
              onInit: (code) {
                print("on init ${code!.name} ${code.dialCode} ${code.name}");
                countrycode = code.toString().replaceFirst("+", "");
                print("New Country selected: $code");
              }),
        ));
  }

  Widget _buildCountryPicker(CountryCode? country) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                country!.flagUri!,
                package: 'country_code_picker',
                height: 40,
                width: 20,
              ),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text("country!.dialCode!"),
            ),
          ),
          const Flexible(
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                "country!.name!",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );

  setMobileNo() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: mobileController,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onSaved: (String? value) {
          mobile = value;
          print('Mobile no:$mobile');
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.call_outlined),
            hintText: MOBILEHINT_LBL,
            prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  setEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        onSaved: (String? value) {
          email = value;
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.email_outlined),
            hintText: EMAILHINT_LBL,
            prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  setPass() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: !_showPassword,
        controller: passwordController,
        onSaved: (val) => password = val,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            hintText: PASSHINT_LBL,
            prefixIconConstraints: const BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  showPass() {
    return Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Checkbox(
              value: _showPassword,
              onChanged: (bool? value) {
                setState(() {
                  _showPassword = value!;
                });
              },
            ),
            Text(SHOW_PASSWORD,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: lightblack2))
          ],
        ));
  }

  verifyBtn() {
    return AppBtn(
      title: VERIFY_MOBILE_NUMBER,
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () async {
        validateAndSubmit();
      },
    );
  }

  loginTxt() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(ALREADY_A_CUSTOMER,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: lightblack)),
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const HappyShopLogin(),
                ));
              },
              child: Text(
                LOG_IN_LBL,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: primary, decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }

  expandedBottomView() {
    double width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: width,
                padding: const EdgeInsets.only(top: 20.0),
                child: Form(
                  key: _formkey,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        registerTxt(),
                        //setUserName(),
                        //setCountryCode(),
                        setMobileNo(),
                        setEmail(),
                        setPass(),
                        showPass(),
                        verifyBtn(),
                        loginTxt(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      /*desktop: SingupDesktop(
        fromkey: _formkey,
        listwidget: [
          registerTxt(),
          setUserName(),
          setCountryCode(),
          setMobileNo(),
          setEmail(),
          setPass(),
          showPass(),
          verifyBtn(),
          loginTxt(),
        ],
      ),*/
    );
  }

  @override
  void initState() {
    super.initState();
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
  }
}
