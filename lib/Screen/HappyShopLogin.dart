import 'package:country_code_picker/country_code_picker.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Helper/HappyShopString.dart';
import 'package:engishop/Screen/HappyShopForgotPassword.dart';
import 'package:engishop/Screen/HappyShopHome.dart';
//import 'package:engi_shop/HappyShop/desktop/logindesktop.dart';
import 'package:engishop/widget/HappyShopbtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'HappyShopSingUp.dart';

class HappyShopLogin extends StatefulWidget {
  const HappyShopLogin({Key? key}) : super(key: key);

  @override
  _HappyShopLoginState createState() => _HappyShopLoginState();
}

class _HappyShopLoginState extends State<HappyShopLogin>
    with TickerProviderStateMixin {
  String? password,
      mobile,
      username,
      email,
      id,
      countrycode,
      mobileno,
      city,
      area,
      pincode,
      address,
      latitude,
      longitude,
      image;
  String? countryName;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  late Animation buttonSqueezeanimation;

  late AnimationController buttonController;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        /*bool result = await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
        if (result == null) result = false;*/
        bool result = false;
        return result;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: height,
            width: width,
            decoration: back(),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Future.delayed(const Duration(milliseconds: 000))
                                .then((_) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HappyShopHome()));
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              SKIP,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: white,
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Center(
                      child: SvgPicture.network(
                        'https://smartkit.wrteam.in/smartkit/images/happyshopwhitelogo.svg',
                        width: 80.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ScreenTypeLayout(
                      mobile: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                                child: Form(
                                  key: _formkey,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0, top: 10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        welcomeHappyShopTxt(),
                                        eCommerceforBusinessTxt(),
                                        //setCountryCode(),
                                        setMobileNo(),
                                        setPass(),
                                        forgetPass(),
                                        loginBtn(),
                                        accSignup(),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      /* desktop: LoginDesktop(
                        fromkey: _formkey,
                        listwidget: [
                          welcomeHappyShopTxt(),
                          eCommerceforBusinessTxt(),
                          setCountryCode(),
                          setMobileNo(),
                          setPass(),
                          forgetPass(),
                          loginBtn(),
                          accSignup(),
                        ],
                      ),*/
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> validatanmation() async {
    await buttonController.reverse();
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HappyShopHome()));
    });
  }

  bool validateAndSave() {
    return true;
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

  welcomeHappyShopTxt() {
    return Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(children: [
            Text(
              'Welcome to ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: lightblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
            ),
            Text(
              WELCOME_EngiShop,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: lightblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'DancingScript',
                  ),
            ),
            Text(
              ' Shop',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: lightblack,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
            )
          ]),
        ));
  }

  eCommerceforBusinessTxt() {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ECOMMERCE_APP_FOR_ALL_BUSINESS,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: lightblack2),
          ),
        ));
  }

  setCountryCode() {
    double height = MediaQuery.of(context).size.height * 0.9;
    double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: width,
          height: 50,
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
              alignLeft: true,
              dialogSize: Size(width, height),
              builder: _buildCountryPicker,
              onChanged: (CountryCode countryCode) {
                countrycode = countryCode.toString().replaceFirst("+", "");
                print("New Country selected: $countryCode");
                countryName = countryCode.name;
              },
              onInit: (code) {
                print("on init ${code?.name} ${code?.dialCode} ${code?.name}");
                countrycode = code.toString().replaceFirst("+", "");
                print("New Country selected: $code");
              }),
        ));
  }

  dynamic _buildCountryPicker(CountryCode? country) => Row(
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
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                country.dialCode!,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                country.name!,
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
          mobileno = value;
          mobile = mobileno;
          print('Mobile no:$mobile');
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.call_outlined,
            ),
            hintText: MOBILEHINT_LBL,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
        obscureText: true,
        controller: passwordController,
        onSaved: (String? value) {
          password = value;
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            hintText: PASSHINT_LBL,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 40, maxHeight: 20),
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))),
      ),
    );
  }

  forgetPass() {
    return Padding(
        padding: const EdgeInsets.only(
            bottom: 10.0, left: 30.0, right: 30.0, top: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HappyShopForgotPassword()));
              },
              child: Text(FORGOT_PASSWORD_LBL,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: lightblack)),
            ),
          ],
        ));
  }

  accSignup() {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 30.0, left: 30.0, right: 30.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DONT_HAVE_AN_ACC,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: lightblack2, fontWeight: FontWeight.normal)),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HappyShopSingUp()));
              },
              child: Text(
                SIGN_UP_LBL,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: primary, decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }

  loginBtn() {
    return AppBtn(
      title: LOGIN_LBL,
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () async {
        validateAndSubmit();
      },
    );
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      validatanmation();
    }
  }
}
