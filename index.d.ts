// noinspection SpellCheckingInspection

declare module "@krmao/react-native-umshare" {
    export const ShareUtil: {
        init: (platformConfig: { [key in keyof typeof SHARE_MEDIA]: any }) => void,
        share: (text: string, img: string | undefined | null, weburl: string, title: string, sharemedia: string, successCallback: Callback) => void,
        auth: (sharemedia: any, successCallback: Callback) => void,
        shareboard: (text: string, img: string | undefined | null, weburl: string, title: string, sharemedias: string[], successCallback: Callback) => void,
    };
    export type Callback = (...args: any[]) => void;
    export const SHARE_MEDIA: {
        GENERIC: "GENERIC",
        SMS: "SMS",
        EMAIL: "EMAIL",
        SINA: "SINA",
        QZONE: "QZONE",
        QQ: "QQ",
        WEIXIN: "WEIXIN",
        WEIXIN_CIRCLE: "WEIXIN_CIRCLE",
        WEIXIN_FAVORITE: "WEIXIN_FAVORITE",
        WXWORK: "WXWORK",
        DOUBAN: "DOUBAN",
        FACEBOOK: "FACEBOOK",
        FACEBOOK_MESSAGER: "FACEBOOK_MESSAGER",
        TWITTER: "TWITTER",
        YIXIN: "YIXIN",
        YIXIN_CIRCLE: "YIXIN_CIRCLE",
        INSTAGRAM: "INSTAGRAM",
        PINTEREST: "PINTEREST",
        EVERNOTE: "EVERNOTE",
        POCKET: "POCKET",
        LINKEDIN: "LINKEDIN",
        FOURSQUARE: "FOURSQUARE",
        YNOTE: "YNOTE",
        WHATSAPP: "WHATSAPP",
        LINE: "LINE",
        FLICKR: "FLICKR",
        TUMBLR: "TUMBLR",
        ALIPAY: "ALIPAY",
        KAKAO: "KAKAO",
        BYTEDANCE: "BYTEDANCE",
        BYTEDANCE_PUBLISH: "BYTEDANCE_PUBLISH",
        BYTEDANCE_FRIENDS: "BYTEDANCE_FRIENDS",
        DROPBOX: "DROPBOX",
        VKONTAKTE: "VKONTAKTE",
        DINGTALK: "DINGTALK",
        HONOR: "HONOR",
        MORE: "MORE"
    };
}
