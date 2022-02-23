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
Flutter 当下并没有一个特定的管理字符串的资源管理系统。目前来讲，最好的办法是将字符串作为静态域存放在类中，并通过类访问它们.
Flutter 在 Android 上提供无障碍的基本支持，但是这个功能当下仍在开发。
我们鼓励 Flutter 开发者使用 intl 包 进行国际化和本地化。

### 10.Gradle 文件的对应物是什么？我该如何添加依赖？
在 Android 中，你在 Gradle 构建脚本中添加依赖。Flutter 使用 Dart 自己的构建系统以及 Pub 包管理器。构建工具会将原生 Android 和 iOS 壳应用的构建代理给对应的构建系统。
虽然在你的 Flutter 项目的 android 文件夹下有 Gradle 文件，但是它们只用于给对应平台的集成添加原生依赖。一般来说，在 pubspec.yaml 文件中定义在 Flutter 里使用的外部依赖。

### 11. Flutter中类似于Activity的生命周期的监听，对WWidget的监听，绑定WidgetsBinding并监听didChangeAppLifecycleState()方法
可以被观察的生命周期事件有（AppLifecycleState）：
inactive — 应用处于非活跃状态并且不接收用户输入。
detached — 应用依然保留 flutter engine，但是它会脱离全部宿主 view。
paused — 应用当前对用户不可见，无法响应用户输入，并运行在后台。这个事件对应于 Android 中的 onPause()；
resumed — 应用对用户可见并且可以响应用户的输入。这个事件对应于 Android 中的 onPostResume()；
suspending — 应用暂时被挂起。这个事件对应于 Android 中的 onStop； iOS 上由于没有对应的事件，因此不会触发此事件。

### 12. LinearLayout 对应Row 和 Column，RelativeLayout 对应组合使用 Column、Row 和 Stack Widget 实现 RelativeLayout 的效果。ScrollView 对应 Flutter的ListView
Flutter 中 ListView widget 既是一个 ScrollView，也是一个 Android 中的 ListView。

### 13.Flutter如何处理屏幕旋转？
FlutterView 会处理配置的变化，前提条件是在 AndroidManifest.xml 文件中声明了：

````java
android:configChanges="orientation|screenSize"
```


