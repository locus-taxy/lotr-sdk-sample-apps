# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

-keep class ch.qos.** { *; }
-keep class org.slf4j.** { *; }
-dontwarn ch.qos.logback.core.net.*

-dontwarn com.sun.activation.registries.LogSupport
-dontwarn com.sun.activation.registries.MailcapFile
-dontwarn java.awt.datatransfer.DataFlavor
-dontwarn java.awt.datatransfer.Transferable
-dontwarn javax.ws.rs.client.Client
-dontwarn javax.ws.rs.client.ClientBuilder
-dontwarn javax.ws.rs.client.Entity
-dontwarn javax.ws.rs.client.Invocation$Builder
-dontwarn javax.ws.rs.client.WebTarget
-dontwarn javax.ws.rs.core.Configurable
-dontwarn javax.ws.rs.core.Configuration
-dontwarn javax.ws.rs.core.Form
-dontwarn javax.ws.rs.core.GenericType
-dontwarn org.glassfish.jersey.client.ClientConfig
-dontwarn org.glassfish.jersey.filter.LoggingFilter
-dontwarn org.glassfish.jersey.jackson.JacksonFeature
-dontwarn org.glassfish.jersey.media.multipart.BodyPart
-dontwarn org.glassfish.jersey.media.multipart.ContentDisposition$ContentDispositionBuilder
-dontwarn org.glassfish.jersey.media.multipart.FormDataBodyPart
-dontwarn org.glassfish.jersey.media.multipart.FormDataContentDisposition$FormDataContentDispositionBuilder
-dontwarn org.glassfish.jersey.media.multipart.FormDataContentDisposition
-dontwarn org.glassfish.jersey.media.multipart.MultiPart
-dontwarn org.glassfish.jersey.media.multipart.MultiPartFeature