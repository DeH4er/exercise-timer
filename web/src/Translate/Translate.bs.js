// Generated by ReScript, PLEASE EDIT WITH CARE

import I18next from "i18next";
import * as Command$Web from "../Interop/Command.bs.js";
import * as ReactI18next from "react-i18next";
import * as Language$Shared from "shared/src/Language.bs.js";
import EnJson from "../../assets/i18n/en.json";
import UaJson from "../../assets/i18n/ua.json";

var enTranslations = EnJson;

var uaTranslations = UaJson;

function useTranslation(param) {
  var res = ReactI18next.useTranslation();
  return {
          t: (function (key) {
              return res.t(key);
            }),
          t1: (function (key, args) {
              return res.t(key, args);
            }),
          i18n: res.i18n
        };
}

function changeLanguage(i18n, language) {
  i18n.changeLanguage(Language$Shared.Serializable.toString(language));
  
}

function init(param) {
  return I18next.use(ReactI18next.initReactI18next).init({
              resources: {
                en: {
                  translation: enTranslations
                },
                ua: {
                  translation: uaTranslations
                }
              },
              lng: "en",
              fallbackLng: "en",
              interpolation: {
                escapeValue: false
              }
            });
}

function listenChange(param) {
  Command$Web.on(function (cmd) {
        if (typeof cmd === "number") {
          return ;
        }
        switch (cmd.TAG | 0) {
          case /* ReturnSettings */0 :
              return changeLanguage(I18next, cmd._0.selectedLanguage);
          case /* LanguageChanged */6 :
              return changeLanguage(I18next, cmd._0);
          default:
            return ;
        }
      });
  return Command$Web.send(/* GetSettings */2);
}

export {
  enTranslations ,
  uaTranslations ,
  useTranslation ,
  changeLanguage ,
  init ,
  listenChange ,
  
}
/* enTranslations Not a pure module */
