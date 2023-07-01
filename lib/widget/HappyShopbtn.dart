import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:engishop/Helper/HappyShopColor.dart';

class AppBtn extends StatelessWidget {
  final String? title;
  final AnimationController? btnCntrl;
  final Animation? btnAnim;
  final VoidCallback? onBtnSelected;

  const AppBtn(
      {Key? key, this.title, this.btnCntrl, this.btnAnim, this.onBtnSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        builder: _buildBtnAnimation, animation: this.btnCntrl!);
  }

  Widget _buildBtnAnimation(BuildContext context, Widget? child) {
    return CupertinoButton(
      child: Container(
        width: btnAnim!.value,
        height: 40,
        alignment: FractionalOffset.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryLight2, primaryLight3],
              stops: [0, 1]),
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: btnAnim!.value > 75.0
            ? Text(title!,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: white, fontWeight: FontWeight.normal))
            : const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
      ),
      onPressed: () {
        onBtnSelected!();
      },
    );
  }
}
