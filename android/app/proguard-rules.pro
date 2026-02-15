-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

-keep class com.baseflow.pathprovider.** { *; }
-keep class dev.fluttercommunity.plus.share.** { *; }

-keep class io.flutter.embedding.engine.plugins.** { *; }
-keep class * extends io.flutter.embedding.engine.plugins.FlutterPlugin

-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
-keep class androidx.lifecycle.** { *; }

-keepattributes SourceFile,LineNumberTable
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-keepattributes Signature
-keepattributes InnerClasses

-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

-dontwarn com.google.android.play.core.tasks.**
-keep class com.google.android.play.core.tasks.** { *; }

-dontwarn io.flutter.embedding.engine.deferredcomponents.**