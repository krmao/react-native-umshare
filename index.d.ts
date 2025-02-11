// noinspection SpellCheckingInspection

declare module '@krmao/react-native-umshare' {
    export const ShareUtil: {
        share: (text: string, img: any, weburl: string, title: string, sharemedia: any, successCallback: any) => void
        auth: (sharemedia: any, successCallback: any) => void
        shareboard: (text: string, img: any, weburl: string, title: string, sharemedias: any, successCallback: any) => void
    };
    export const Callback: any;
}
