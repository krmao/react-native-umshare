## @krmao/react-native-umshare

> ***ios 6.9.4***<br>
> ***android 6.9.4***

[![npm version](https://badge.fury.io/js/@krmao%2Freact-native-umshare.svg)](https://badge.fury.io/js/@krmao%2Freact-native-umshare)

### Install

```shell
yarn add @krmao/react-native-umshare
```

### Android

- app包名下创建 ddshare 文件夹, 添加 DDShareActivity.java 继承于 ABSDDShareActivity.java
- app包名下创建 wxapi 文件夹, 添加 WXEntryActivity.java 继承于 ABSWXEntryActivity.java
    - <img src="https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/4973735161/p248305.png" width="200" alt=""/>
- app activity 添加
  ```java
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data);
    }
  ```
- AndroidManifest.xml activities
  ```xml 
    <!-- 微信 -->
    <activity
       android:name=".wxapi.WXEntryActivity"
       android:configChanges="keyboardHidden|orientation|screenSize"
       android:exported="true"
       android:theme="@android:style/Theme.Translucent.NoTitleBar"/>
    <!-- 钉钉 -->
    <activity
       android:name=".ddshare.DDShareActivity"
       android:configChanges="keyboardHidden|orientation|screenSize"
       android:exported="true"
       android:launchMode="singleInstance"
       android:theme="@android:style/Theme.Translucent.NoTitleBar"/>
    <!-- QQ分享需要授权 -->
    <activity
        android:name="com.tencent.tauth.AuthActivity"
        android:launchMode="singleTask"
        android:noHistory="true">
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="tencent100424468" />
        </intent-filter>
     </activity>
    <!-- QQ -->
     <activity
        android:name="com.tencent.connect.common.AssistActivity"
        android:configChanges="orientation|keyboardHidden|screenSize"
        android:theme="@android:style/Theme.Translucent.NoTitleBar" />
  ```
- AndroidManifest.xml provider
  ```xml 
    <provider
      android:name="android.support.v4.content.FileProvider"
      android:authorities="${applicationId}.fileprovider"
      android:exported="false"
      android:grantUriPermissions="true">
      <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/filepaths "/>
    </provider>
     ```
- 分享 res/xml/filepaths.xml
  ```xml
      <?xml version="1.0" encoding="utf-8"?>
      <paths>
          <root-path name="opensdk_root" path=""/>
          <external-files-path name="umeng_cache" path="umeng_cache/"/>
          <!-- QQ 官方分享SDK 共享路径 -->
          <root-path name="opensdk_root" path=""/>
          <external-files-path name="opensdk_external" path="Images/tmp"/>
          <!-- 新浪 共享路径 -->
          <!-- <external-files-path name="share_files" path="."/> -->
      </paths>
  ```

### IOS

- 配置SSO白名单
  >
  如果你的应用使用了如SSO授权登录或跳转到第三方分享功能，在iOS9/10下就需要增加一个可跳转的白名单，即LSApplicationQueriesSchemes，否则将在SDK判断是否跳转时用到的canOpenURL时返回NO，进而只进行webview授权或授权/分享失败。
  > 在项目中的info.plist中加入应用白名单，右键info.plist选择source code打开(plist具体设置在Build Setting -> Packaging ->
  > Info.plist File可获取plist路径)请根据选择的平台对以下配置进行裁剪：
  >
  > 重要 iOS 15限制了配置的URL Scheme不可以超过50个

```xml

<key>LSApplicationQueriesSchemes</key>
<array>
<!--微信 URL Scheme白名单-->
<string>wechat</string>
<string>weixin</string>
<string>weixinULAPI</string>
<string>weixinURLParamsAPI</string>


<!-- QQ、Qzone URL Scheme白名单-->
<string>mqqopensdklaunchminiapp</string>
<string>mqqopensdkminiapp</string>
<string>mqqapi</string>
<string>mqq</string>
<string>mqqOpensdkSSoLogin</string>
<string>mqqconnect</string>
<string>mqqopensdkapi</string>
<string>mqqopensdkapiV2</string>
<string>mqqopensdkapiV3</string>
<string>mqqopensdkapiV4</string>
<string>mqqopensdknopasteboard</string>
<string>mqqopensdknopasteboardios16</string>
<string>tim</string>
<string>timapi</string>
<string>timopensdkfriend</string>
<string>timwpa</string>
<string>timgamebindinggroup</string>
<string>timapiwallet</string>
<string>timOpensdkSSoLogin</string>
<string>wtlogintim</string>
<string>timopensdkgrouptribeshare</string>
<string>timopensdkapiV4</string>
<string>timgamebindinggroup</string>
<string>timopensdkdataline</string>
<string>wtlogintimV1</string>
<string>timapiV1</string>

<!--新浪微博 URL Scheme白名单-->
<string>sinaweibohd</string>
<string>sinaweibo</string>
<string>sinaweibosso</string>
<string>weibosdk</string>
<string>weibosdk2.5</string>
<string>weibosdk3.3</string>
```

- 配置URL Scheme
  > URL Scheme是通过系统找到并跳转对应app的一类设置，通过向项目中的info.plist文件中加入URL
  > types可使用第三方平台所注册的appkey信息向系统注册你的app，当跳转到第三方应用授权或分享后，可直接跳转回你的app。
  >
  > 添加URL Types可工程设置面板设置
  >
  > 配置第三方平台URL Scheme未列出则不需设置

    - <img src="https://help-static-aliyun-doc.aliyuncs.com/assets/img/zh-CN/7071465161/p248891.png" alt="">

- 微信appKey wxdc1e388c3822c80b 需要添加两项URL Scheme： 1、”tencent”+腾讯QQ互联应用appID
  2、“QQ”+腾讯QQ互联应用appID转换成十六进制（不足8位前面补0）
  > 如appID：100424468 1、tencent100424468 2、QQ05fc5b14
  > QQ05fc5b14为100424468转十六进制而来，因不足8位向前补0，然后加”QQ”前缀
  > “wb”+新浪appKey
  > wb3921700954
