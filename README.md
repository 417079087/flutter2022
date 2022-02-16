# studyflutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### 1.如何更新 widgets？
### 2.动画
### 3.传参
### 4.路由
### 5.MethodChannel 进行应用间分享
### 6.startActivityForResult() 的对应方法是什么？
```code
Navigator 类负责 Flutter 的导航，并用来接收被压栈的 route 的返回值。这是通过在 push() 后返回的 Future 上 await 来实现的。

例如，要打开一个让用户选择位置的 route，你可以这样做：

content_copy
Map coordinates = await Navigator.of(context).pushNamed('/location');
然后，在你的位置 route 内，一旦用户选择了位置，你就可以弹栈 (pop) 并返回结果：

content_copy
Navigator.of(context).pop({"lat":43.821757,"long":-79.226392});
```
### 7.异步 网络请求
```text
Dart 有一个单线程执行的模型，同时也支持 Isolate （在另一个线程运行 Dart 代码的方法），它是一个事件循环和异步编程方式。
除非你创建一个 Isolate，否则你的 Dart 代码会运行在主 UI 线程，并被一个事件循环所驱动。Flutter 的事件循环对应于 Android 
里的主 Looper— 也即绑定到主线程上的 Looper。
在 Flutter 中，可以使用 Dart 语言提供的异步工具，例如 async/await 来执行异步任务。如果你使用过 C# 或者 Javascript 中的 async/await 范式，或者 Kotlin 中的协程，你应该对它比较熟悉。
```
### 8.资源文件

|Android 密度修饰符 |Flutter 像素比例
|----             |----
|ldpi	          |0.75x
|mdpi	          |1.0x
|hdpi	          |1.5x
|xhdpi	          |2.0x
|xxhdpi	          |3.0x
|xxxhdpi	      |4.0x

### 9.暂不支持像安卓一样的语音国际化，但有开源库
Flutter 在 Android 上提供无障碍的基本支持，但是这个功能当下仍在开发。
我们鼓励 Flutter 开发者使用 intl 包 进行国际化和本地化。


