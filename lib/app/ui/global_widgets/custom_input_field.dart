import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomInputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final IconData prefixIcon;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  const CustomInputField({
    Key? key,
    this.onChanged,
    required this.label,
    this.inputType,
    this.isPassword = false,
    this.validator,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final underline =
        Theme.of(context).brightness == Brightness.dark ? '3A3E98' : '00ff00';

    final borderslide =
        Theme.of(context).brightness == Brightness.dark ? '4AB1D8' : '05d0ae';
    final visibility =
        Theme.of(context).brightness == Brightness.dark ? '4AB1D8' : '05d0ae';
    final prefixicon =
        Theme.of(context).brightness == Brightness.dark ? '4AB1D8' : '05d0ae';
    return FormField<String>(
      validator: widget.validator,
      initialValue: '',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              //style: TextStyle(color: Colors.yellow),

              style: Theme.of(context).textTheme.overline,
              obscureText: _obscureText,
              keyboardType: widget.inputType,
              onChanged: (text) {
                if (widget.validator != null) {
                  // ignore: invalid_use_of_protected_member
                  state.setValue(text);
                  state.validate();
                }
                if (widget.onChanged != null) {
                  widget.onChanged!(text);
                }
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.blue),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: HexColor('$underline'),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: HexColor('$borderslide'),
                  width: 2,
                )),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: widget.label,
                prefixIcon: Icon(
                  widget.prefixIcon,
                  color: HexColor('$prefixicon'),
                ),
                border: const OutlineInputBorder(),
                suffixIcon: widget.isPassword
                    ? CupertinoButton(
                        child: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: HexColor('$visibility'),
                        ),
                        onPressed: () {
                          _obscureText = !_obscureText;
                          setState(() {});
                        },
                      )
                    : Container(
                        width: 0,
                      ),
              ),
            ),
            if (state.hasError)
              Text(
                state.errorText!,
                style: const TextStyle(color: Colors.redAccent),
              )
          ],
        );
      },
    );
  }
}
