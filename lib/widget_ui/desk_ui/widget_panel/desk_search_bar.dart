import 'dart:async';

import 'package:app/app.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_repository/widget_repository.dart';

class DeskSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const DeskSearchBar({Key? key, this.onChanged}) : super(key: key);

  @override
  State<DeskSearchBar> createState() => _DeskSearchBarState();
}

class _DeskSearchBarState extends State<DeskSearchBar> {
  late TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<WidgetModel>(
      optionsBuilder: buildOptions,
      onSelected: onSelected,
      optionsViewBuilder: _buildOptionsView,
      fieldViewBuilder: _buildFieldView,
    );
  }

  void onSelected(WidgetModel model) {
    final FocusScopeNode focusScope = FocusScope.of(context);
    if (focusScope.hasFocus) {
      focusScope.unfocus();
    }
    _controller.clear();

    Navigator.pushNamed(
      context,
      UnitRouter.widget_detail,
      arguments: model,
    );
  }

  Future<Iterable<WidgetModel>> buildOptions(TextEditingValue textEditingValue) async {
    if (textEditingValue.text == '') {
      return const Iterable<WidgetModel>.empty();
    }
    return searchByArgs(textEditingValue.text);
  }

  Future<Iterable<WidgetModel>> searchByArgs(String text) {
    WidgetRepository repository = context
        .read<WidgetsBloc>()
        .repository;
    return repository.searchWidgets(WidgetFilter(
      name: text,
    ));
  }

  Widget _buildOptionsView(BuildContext context, AutocompleteOnSelected<WidgetModel> onSelected,
      Iterable<WidgetModel> options) {
    return Align(
      alignment: Alignment.topLeft,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(8),
        shadowColor: Colors.black,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 350, maxWidth: 250),
          child: ListView.builder(
              itemCount: options.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (_, index) {
                WidgetModel model = options.elementAt(index);
                return InkWell(
                  onTap: () => onSelected(model),
                  child: Ink(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    child: Row(children: [
                      Expanded(child: Text.rich(formSpan(model.name, _controller.text), maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12))),
                      // Spacer(),
                      const SizedBox(width: 10,),
                      Text(model.nameCN, style: const TextStyle(fontSize: 12),),
                    ],),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _buildFieldView(BuildContext context, TextEditingController textEditingController, FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    _controller = textEditingController;
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;

    return TextField(
      controller: textEditingController,
      onChanged: widget.onChanged,
      style: const TextStyle(fontSize: 12),
      maxLines: 1,
      focusNode: focusNode,
      decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(
            minWidth: 30,
          ),
          filled: true,
          hoverColor: Colors.transparent,
          contentPadding: const EdgeInsets.only(top: 0),
          fillColor: isDark ? null : const Color(0xffF1F2F3),
          prefixIcon: const Icon(
            Icons.search,
            size: 18,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Theme
                .of(context)
                .primaryColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),

          enabledBorder: const OutlineInputBorder(

            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          hintText: "输入组件名称",
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  final TextStyle lightTextStyle = const TextStyle(
    color: Colors.red,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  InlineSpan formSpan(String src, String pattern) {
    bool isDark = Theme
        .of(context)
        .brightness == Brightness.dark;
    Color? textColor = Theme
        .of(context)
        .listTileTheme
        .textColor;

    List<TextSpan> span = [];
    RegExp regExp = RegExp(pattern, caseSensitive: false);
    src.splitMapJoin(regExp, onMatch: (Match match) {
      span.add(TextSpan(text: match.group(0), style: lightTextStyle));
      return '';
    }, onNonMatch: (str) {
      span.add(TextSpan(
          text: str,
          style: lightTextStyle.copyWith(color: isDark ? textColor : const Color(0xff2F3032), fontSize: 12)));
      return '';
    });
    return TextSpan(children: span);
  }

}
