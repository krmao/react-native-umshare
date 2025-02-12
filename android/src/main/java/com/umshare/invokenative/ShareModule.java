package com.umshare.invokenative;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.util.Log;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.umeng.commonsdk.UMConfigure;
import com.umeng.socialize.PlatformConfig;
import com.umeng.socialize.ShareAction;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.UMShareListener;
import com.umeng.socialize.bean.SHARE_MEDIA;
import com.umeng.socialize.common.ResContainer;
import com.umeng.socialize.media.UMImage;
import com.umeng.socialize.media.UMWeb;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Nullable;

/**
 * Created by wangfei on 17/8/28.
 *
 * @noinspection Convert2Lambda, Convert2Lambda, unused, CommentedOutCode, CommentedOutCode, CommentedOutCode
 */

public class ShareModule extends ReactContextBaseJavaModule {
    @SuppressLint("StaticFieldLeak")
    private static Activity ma;
    private final int SUCCESS = 200;
    private final int ERROR = 0;
    private final int CANCEL = -1;
    private static final Handler mSDKHandler = new Handler(Looper.getMainLooper());
    /**
     * @noinspection FieldCanBeLocal
     */
    private final ReactApplicationContext contect;

    public ShareModule(ReactApplicationContext reactContext) {
        super(reactContext);
        contect = reactContext;
        // 自动初始化 Social SDK，避免手动调用
        Activity activity = getCurrentActivity();
        if (activity != null) {
            initSocialSDK(activity);
        }
    }

    public static void initSocialSDK(Activity activity) {
        ma = activity;
    }

    @NonNull
    @Override
    public String getName() {
        return "UMShareModule";
    }

    private static void runOnMainThread(Runnable runnable) {
        mSDKHandler.postDelayed(runnable, 0);
    }

    @ReactMethod
    public void init(ReadableMap platformConfig) {
        Activity activity = getCurrentActivity();
        if (activity == null || activity.isFinishing()) {
            Log.e("umshare", "activity is null or isFinishing");
            return;
        }
        String packageName = activity.getPackageName();

        if (platformConfig.hasKey("UMENG")) {
            ReadableMap umengConfig = platformConfig.getMap("UMENG");
            if (umengConfig != null) {
                String umengAppId = umengConfig.getString("APPID");
                RNUMConfigure.init(getCurrentActivity(), umengAppId, "umeng", UMConfigure.DEVICE_TYPE_PHONE, "");
            }
        }
        if (platformConfig.hasKey("WEIXIN")) {
            ReadableMap weixinConfig = platformConfig.getMap("WEIXIN");
            if (weixinConfig != null) {
                String weixinAppId = weixinConfig.getString("APPID");
                String weixinSecret = weixinConfig.getString("SECRET");
                if (weixinAppId != null && weixinSecret != null) {
                    PlatformConfig.setWeixin(weixinAppId, weixinSecret);
                    //noinspection deprecation
                    PlatformConfig.setWXFileProvider(packageName + ".fileprovider");
                }
            }
        }
        // QQ设置
        // PlatformConfig.setQQZone("101830139", "5d63ae8858f1caab67715ccd6c18d7a5");
        // PlatformConfig.setQQFileProvider("com.tencent.sample2.fileprovider");
        // 新浪微博设置
        // PlatformConfig.setSinaWeibo("3921700954", "04b48b094faeb16683c32669824ebdad", "http://sns.whalecloud.com");
        // PlatformConfig.setSinaFileProvider("com.tencent.sample2.fileprovider");
        // 钉钉设置
        // PlatformConfig.setDing("dingoalmlnohc0wggfedpk");
        // PlatformConfig.setDingFileProvider("com.tencent.sample2.fileprovider");
        //抖音设置
        //PlatformConfig.setBytedance("awd1cemo6d0l69zp", "awd1cemo6d0l69zp", "a2dce41fff214270dd4a7f60ac885491", FileProvider);
        // 企业微信设置
        // PlatformConfig.setWXWork("wwac6ffb259ff6f66a", "EU1LRsWC5uWn6KUuYOiWUpkoH45eOA0yH-ngL8579zs", "1000002", "wwauthac6ffb259ff6f66a000002");
        // PlatformConfig.setWXWorkFileProvider("com.tencent.sample2.fileprovider");
        // 荣耀设置
        // PlatformConfig.setHonor("appid", "app_secret");
        // 其他平台设置
        // PlatformConfig.setYixin("yxc0614e80c9304c11b0391514d09f13bf");
        // PlatformConfig.setAlipay("2015111700822536");
        // PlatformConfig.setLaiwang("laiwangd497e70d4","d497e70d4c3e4efeab1381476bac4c5e");
        // PlatformConfig.setTwitter("3aIN7fuF685MuZ7jtXkQxalyi","MK6FEYG63eWcpDFgRYw4w9puJhzDl0tyuqWjZ3M7XJuuG7mMbO");
        // PlatformConfig.setPinterest("1439206");
        // PlatformConfig.setKakao("e4f60e065048eb031e235c806b31c70f");
        // PlatformConfig.setVKontakte("5764965","5My6SNliAaLxEm3Lyd9J");
        // PlatformConfig.setDropbox("oz8v5apet3arcdy","h7p2pjbzkkxt02a");
        // PlatformConfig.setYnote("9c82bf470cba7bd2f1819b0ee26f86c6ce670e9b");
    }

    @ReactMethod
    public void share(final String text, final String img, final String weburl, final String title, final String sharemedia, final Callback successCallback) {
        runOnMainThread(new Runnable() {
            @Override
            public void run() {

                if (!TextUtils.isEmpty(weburl)) {
                    UMWeb web = new UMWeb(weburl);
                    web.setTitle(title);
                    web.setDescription(text);
                    if (getImage(img) != null) {
                        web.setThumb(getImage(img));
                    }
                    new ShareAction(ma).withText(text).withMedia(web).setPlatform(getShareMediaByName(sharemedia)).setCallback(getUMShareListener(successCallback)).share();
                } else if (getImage(img) != null) {
                    new ShareAction(ma).withText(text).withMedia(getImage(img)).setPlatform(getShareMediaByName(sharemedia)).setCallback(getUMShareListener(successCallback)).share();
                } else {
                    new ShareAction(ma).withText(text).setPlatform(getShareMediaByName(sharemedia)).setCallback(getUMShareListener(successCallback)).share();
                }

            }
        });

    }

    private UMShareListener getUMShareListener(final Callback successCallback) {
        return new UMShareListener() {
            @Override
            public void onStart(SHARE_MEDIA share_media) {

            }

            @Override
            public void onResult(SHARE_MEDIA share_media) {
                successCallback.invoke(SUCCESS, "success");
            }

            @Override
            public void onError(SHARE_MEDIA share_media, Throwable throwable) {
                successCallback.invoke(ERROR, throwable.getMessage());
            }

            @Override
            public void onCancel(SHARE_MEDIA share_media) {
                successCallback.invoke(CANCEL, "cancel");
            }
        };
    }

    private UMImage getImage(String url) {
        if (TextUtils.isEmpty(url)) {
            return null;
        } else if (url.startsWith("http")) {
            return new UMImage(ma, url);
        } else if (url.startsWith("/")) {
            return new UMImage(ma, url);
        } else if (url.startsWith("res")) {
            return new UMImage(ma, ResContainer.getResourceId(ma, "drawable", url.replace("res/", "")));
        } else {
            return new UMImage(ma, url);
        }
    }

    @ReactMethod
    public void auth(final String sharemedia, final Callback successCallback) {
        runOnMainThread(new Runnable() {
            @Override
            public void run() {
                UMShareAPI.get(ma).getPlatformInfo(ma, getShareMediaByName(sharemedia), new UMAuthListener() {
                    @Override
                    public void onStart(SHARE_MEDIA share_media) {
                    }

                    @Override
                    public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
                        WritableMap result = Arguments.createMap();
                        for (String key : map.keySet()) {
                            result.putString(key, map.get(key));
                            Log.e("todoremove", "key=" + key + "   value" + map.get(key));
                        }
                        successCallback.invoke(0, result, "success");
                    }

                    @Override
                    public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
                        WritableMap result = Arguments.createMap();
                        successCallback.invoke(1, result, throwable.getMessage());
                    }

                    @Override
                    public void onCancel(SHARE_MEDIA share_media, int i) {
                        WritableMap result = Arguments.createMap();
                        successCallback.invoke(2, result, "cancel");
                    }
                });
            }
        });

    }

    @ReactMethod
    public void shareboard(final String text, final String img, final String weburl, final String title, final ReadableArray sharemedias, final Callback successCallback) {
        runOnMainThread(new Runnable() {
            @Override
            public void run() {
                if (!TextUtils.isEmpty(weburl)) {
                    UMWeb web = new UMWeb(weburl);
                    web.setTitle(title);
                    web.setDescription(text);
                    if (getImage(img) != null) {
                        web.setThumb(getImage(img));
                    }
                    new ShareAction(ma).withText(text).withMedia(web).setDisplayList(getShareMediasByNames(sharemedias)).setCallback(getUMShareListener(successCallback)).open();
                } else if (getImage(img) != null) {
                    new ShareAction(ma).withText(text).withMedia(getImage(img)).setDisplayList(getShareMediasByNames(sharemedias)).setCallback(getUMShareListener(successCallback)).open();
                } else {
                    new ShareAction(ma).withText(text).setDisplayList(getShareMediasByNames(sharemedias)).setCallback(getUMShareListener(successCallback)).open();
                }

            }
        });
    }

    @Nullable
    public static SHARE_MEDIA getShareMediaByName(String name) {
        if (TextUtils.isEmpty(name)) {
            return null;
        }
        try {
            return SHARE_MEDIA.valueOf(name.trim());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }

    private SHARE_MEDIA[] getShareMediasByNames(ReadableArray names) {
        List<SHARE_MEDIA> mediasList = new ArrayList<>();
        for (int i = 0; i < names.size(); i++) {
            SHARE_MEDIA media = getShareMediaByName(names.getString(i));
            if (media != null) {
                mediasList.add(media);
            }
        }
        return mediasList.toArray(new SHARE_MEDIA[0]);
    }
}
