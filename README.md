# observable_ui

Flutter单向绑定库，部分widget支持双向绑定.

## Getting Started

单向绑定
```
class Model {
  ObservableValue<String> inputText;
}

@override
Widget build(BuildContext context) {
  return ObservableBridge(
  data:[model.inputText],
  child:Text(child:model.inputText)
  );
}

model.inputText.value="改变文本"/// Text将会重新build，不需要调用setState
``` 
双向绑定
```
@override
Widget build(BuildContext context) {
  return EditableTextEx(
  data:[model.inputText],
  child:EditableText(controller: TextEditingController(),)
 );
}
////inputText改变将会，EditableText文本将会改变；EditableText文本输入改变，inputText将会改变

```
双向绑定暂时只支持EditableTextEx，CheckboxEx

 
