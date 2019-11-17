import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'core.dart';

///EditableTextEx  support two-way binding
class EditableTextEx extends StatefulWidget {
  final EditableText child;

  final ObservableValue<String> data;

  const EditableTextEx({Key key, this.child, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditableTextExState();
  }
}

class EditableTextExState extends StateMixinObserver<EditableTextEx> {
  EditableText wrapperEditable;

  @override
  void initState() {
    super.initState();
    var editableText = this.widget.child;
    var controller = editableText.controller;
    if (controller == null) {
      controller = TextEditingController();
    }
    controller.text = this.widget.data.value;
    wrapperEditable = EditableText(
      style: editableText.style,
      backgroundCursorColor: editableText.backgroundCursorColor,
      enableInteractiveSelection: editableText.enableInteractiveSelection,
      expands: editableText.expands,
      cursorWidth: editableText.cursorWidth,
      cursorOffset: editableText.cursorOffset,
      cursorColor: editableText.cursorColor,
      cursorOpacityAnimates: editableText.cursorOpacityAnimates,
      focusNode: editableText.focusNode,
      inputFormatters: editableText.inputFormatters,
      textInputAction: editableText.textInputAction,
      textAlign: editableText.textAlign,
      textCapitalization: editableText.textCapitalization,
      textDirection: editableText.textDirection,
      textScaleFactor: editableText.textScaleFactor,
      controller: controller,
      onChanged: (text) {
        this.widget.data.value = text;
      },
      obscureText: editableText.obscureText,
      onEditingComplete: editableText.onEditingComplete,
      onSelectionChanged: editableText.onSelectionChanged,
      onSelectionHandleTapped: editableText.onSelectionHandleTapped,
      scrollController: editableText.scrollController,
      scrollPadding: editableText.scrollPadding,
      scrollPhysics: editableText.scrollPhysics,
      showCursor: editableText.showCursor,
      showSelectionHandles: editableText.showSelectionHandles,
      strutStyle: editableText.strutStyle,
      selectionColor: editableText.selectionColor,
      selectionControls: editableText.selectionControls,
      autofocus: editableText.autofocus,
      autocorrect: editableText.autocorrect,
    );
  }

  @override
  Widget build(BuildContext context) {
    wrapperEditable.controller.text = this.widget.data.value;
    return wrapperEditable;
  }

  @override
  void setState(fn) {
    if (this.wrapperEditable.controller.text == this.widget.data.value) {
      return;
    }
    super.setState(fn);
  }

  @override
  List<Observable> collectObservables() => [this.widget.data];
}

///ImageEx
class ImageEx extends StatefulWidget {
  const ImageEx({Key key, this.src, this.width, this.height}) : super(key: key);

  ///file path , network url ,asset name
  final ObservableValue<String> src;

  final double width;

  final double height;

  @override
  State<StatefulWidget> createState() {
    return ImageExState();
  }
}

class ImageExState extends StateMixinObserver<ImageEx> {
  @override
  List<Observable> collectObservables() => [this.widget.src];

  @override
  Widget build(BuildContext context) {
    var img = this.widget.src.value;
    if (img.startsWith("http")) {
      return Image.network(
        img,
        width: this.widget.width,
        height: this.widget.height,
      );
    }
    if (img.startsWith("/")) {
      return Image.file(
        File(img),
        width: this.widget.width,
        height: this.widget.height,
      );
    }
    return Image.asset(
      img,
      width: this.widget.width,
      height: this.widget.height,
    );
  }
}

///CheckBoxEx support two-way binding
class CheckboxEx extends StatefulWidget {
  final Checkbox child;

  final ObservableValue<bool> data;

  const CheckboxEx({Key key, this.data, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CheckboxExState();
  }
}

class _CheckboxExState extends StateMixinObserver<CheckboxEx> {
  Checkbox wrapperCheckbox;

  @override
  void initState() {
    super.initState();
    var cb = this.widget.child;
    wrapperCheckbox = Checkbox(
      tristate: cb.tristate,
      materialTapTargetSize: cb.materialTapTargetSize,
      value: this.widget.data.value,
      activeColor: cb.activeColor,
      checkColor: cb.checkColor,
      onChanged: (v) {
        this.widget.data.value = v;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return wrapperCheckbox;
  }

  @override
  void setState(fn) {
    if (this.wrapperCheckbox.value == this.widget.data.value) {
      return;
    }
    super.setState(fn);
  }

  @override
  List<Observable> collectObservables() {
    return [this.widget.data];
  }
}



///LinearProgressIndicator
class LinearProgressIndicatorEx extends StatefulWidget {
  final ObservableValue<double> value;

  final Color backgroundColor;

  const LinearProgressIndicatorEx({Key key, this.value, this.backgroundColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorExState();
  }
}

class LinearProgressIndicatorExState
    extends StateMixinObserver<LinearProgressIndicatorEx> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: this.widget.value.value,
      backgroundColor: this.widget.backgroundColor,
    );
  }

  @override
  List<Observable> collectObservables() => [this.widget.value];
}



///ListViewEx
typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListViewEx<T> extends StatefulWidget {
  const ListViewEx({this.items, @required this.itemBuilder});

  final ObservableList<T> items;

  final ItemWidgetBuilder<T> itemBuilder;

  @override
  State<StatefulWidget> createState() {
    return ListViewExState();
  }
}

class ListViewExState extends StateMixinObserver<ListViewEx> {
  @override
  List<Observable> collectObservables() => [this.widget.items];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return this.widget.itemBuilder(context, this.widget.items[index]);
      },
      itemCount: this.widget.items.length,
    );
  }
}

///ExchangeEx  child1 visible when status is true
class ExchangeEx extends StatefulWidget {
  final Widget child1;

  final Widget child2;

  final ObservableValue<bool> status;

  const ExchangeEx(
      {Key key,
      @required this.child1,
      @required this.child2,
      @required this.status})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ExchangeExState();
  }
}

class ExchangeExState extends StateMixinObserver<ExchangeEx> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Visibility(
          visible: this.widget.status.value,
          child: this.widget.child1,
        ),
        Visibility(
          visible: !this.widget.status.value,
          child: this.widget.child2,
        )
      ],
    );
  }

  @override
  List<Observable> collectObservables() => [this.widget.status];
}
