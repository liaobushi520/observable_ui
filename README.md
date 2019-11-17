# observable_ui

Flutter单向绑定库，部分widget支持双向绑定.

## Getting Started


```
class Model {
  ObservableValue<String> inputText;
}

Widget build(BuildContext context) {
  return ObservableBridge(
  data:[model.inputText],
  child:Text(child:model.inputText)
  );
}
``` 
 
