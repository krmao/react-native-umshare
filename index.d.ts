declare module '@krmao/react-native-umshare' {
    export const ShareUtil: {
        share: (text, img, weburl, title, sharemedia, successCallback) => void
        auth: (sharemedia, successCallback) => void
        shareboard: (text, img, weburl, title, sharemedias, successCallback) => void
    };

    export const ReadableArray: any;
    export const Callback: any;
}
