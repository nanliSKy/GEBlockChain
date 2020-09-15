//
//  Language.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/24.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

public enum Lanaguage: String {
    case english = "en"
    case chinese = "zh-Hans"
}

public class Localization {
    
    static let `default` = Localization()
    let _Key = "Key.currentLanguage"
    
    let uds = UserDefaults.standard
    var bundle: Bundle?
    var cl: Lanaguage = .chinese
    
    func valueWithKey(key: String) -> String {
        
        if let bundle = Localization.default.bundle {
            return NSLocalizedString(key, tableName: "Localization", bundle: bundle, value: "", comment: "")
        }else {
            return NSLocalizedString(key, comment: "")
        }
        
    }
    
    func setCurrentLanguage(language: Lanaguage) {
        if cl == language {
            return
        }
        
        switch language {
        case .english:
            uds.set("en", forKey: _Key)
            break
        case .chinese:
            uds.set("cn", forKey: _Key)
            break
        }
        
        cl = getCurrentLanguage()
    }
    
    func checkCurrentLanguage() {
        
        cl = getCurrentLanguage()
    }
    
    private func getCurrentLanguage() -> Lanaguage {
        var str = ""
        if let language = uds.value(forKey: _Key) as? String {
            str = language == "cn" ? "zh-Hans" : "en"
        }else {
            str = getSystemLanguage()
        }
        if let path = Bundle.main.path(forResource:str , ofType: "lproj") {
             bundle = Bundle(path: path)
        }
        return str == "en" ? .english : .chinese

    }
    
    private func getSystemLanguage() -> String {
        let preferred = Bundle.main.preferredLocalizations.first! as NSString
        switch String(describing: preferred) {
        case "en-US", "en-CN":
            return "en"
        case "zh-Hans-US","zh-Hans-CN","zh-Hant-CN","zh-TW","zh-HK","zh-Hans":
            return "zh-Hans"
        default:
            return "zh-Hans"
        }
    }
}

extension String {
    var localized: String {
        return Localization.default.valueWithKey(key: self)
    }
}
