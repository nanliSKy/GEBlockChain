//
//  NetCer.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import Moya

protocol NetTargetType: Moya.TargetType {}

typealias Method  = Moya.Method
typealias Task    = Moya.Task
typealias URLEncoding = Moya.URLEncoding

extension NetTargetType {
    var baseURL: URL {
//        switch ([DCSettings xcode_build]) {
//            case eXCodeBuild_Debug:
//                return @"http://117.71.99.105:8880/app";
//            case eXCodeBuild_Develop:
//                return @"https://dapp.scvip.vip/api";
//            case eXCodeBuild_Release:
//                return @"https://app.scvip.vip/api/";
//
//        }
        return URL(string: "http://117.71.99.105:8880/app")!
    }
    
    var headers: [String : String]? {
    
        return nil
        
    }
    
    public var sampleData: Data {
        return Data()
    }
}

class NetCer: NetworkingSession {
    
    static func defaultPolicy() -> ServerTrustPolice? {
        return nil
    }
    
    static func defaultSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 30
        configuration.httpAdditionalHeaders = defaultHTTPHeader.dictionary
        return Session(configuration: configuration, delegate: SessionDelegate(), serverTrustManager: defaultPolicy())
    }
    
    static var defaultHTTPHeader: HTTPHeaders {
        // Accept-Encoding HTTP Header; see https://tools.ietf.org/html/rfc7230#section-4.2.3
        let acceptEncoding: String = "gzip;q=1.0, compress;q=0.5"
        
        // Accept-Language HTTP Header; see https://tools.ietf.org/html/rfc7231#section-5.3.5
        let acceptLanguage = Locale.preferredLanguages.prefix(6).enumerated().map { index, languageCode in
            let quality = 1.0 - (Double(index) * 0.1)
            return "\(languageCode);q=\(quality)"
            }.joined(separator: ", ")

        let userAgent: String = {
            if let info = Bundle.main.infoDictionary {
                let executable = info[kCFBundleExecutableKey as String] as? String ?? "Unknown"
                let appVersion = info["CFBundleShortVersionString"] as? String ?? "Unknown"
                let appBuild = info[kCFBundleVersionKey as String] as? String ?? "Unknown"

                let osNameVersion: String = {
                    let version = ProcessInfo.processInfo.operatingSystemVersion
                    let versionString = "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"

                    let osName: String = {
                        #if os(iOS)
                            return "iOS"
                        #elseif os(watchOS)
                            return "watchOS"
                        #elseif os(tvOS)
                            return "tvOS"
                        #elseif os(macOS)
                            return "OS X"
                        #elseif os(Linux)
                            return "Linux"
                        #else
                            return "Unknown"
                        #endif
                    }()

                    return "\(osName) \(versionString)"
                }()

                return "\(executable)/\(appVersion) (build:\(appBuild); \(osNameVersion))"
            }

            return "net"
        }()
        
        return [
            "Accept-Encoding": acceptEncoding,
            "Accept-Language": acceptLanguage,
            "User-Agent": userAgent,
            "Language": "zh_CN",
            "categroyId": "1"
        ]
    }
}

final class Net<T: TargetType>: NetProvider<T> {
    public override init(endpointClosure: @escaping MoyaProvider<T>.EndpointClosure = MoyaProvider<T>.defaultEndpointMapping, requestClosure: @escaping MoyaProvider<T>.RequestClosure = MoyaProvider<T>.defaultRequestMapping, stubClosure: @escaping MoyaProvider<T>.StubClosure = MoyaProvider<T>.neverStub, callbackQueue: DispatchQueue? = nil, session: Session = NetCer.defaultSession(), plugins: [PluginType] = Net.defaultPlugins, trackInflights: Bool = false) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    static var defaultPlugins: [Moya.PluginType] {
        return [NetworkLoggerPlugin()]
    }

    convenience init(add plugins: [Moya.PluginType]) {
        var defaultPlugins = Net.defaultPlugins
        defaultPlugins.append(contentsOf: plugins)
        self.init(plugins: defaultPlugins)
    }
    
}

extension Encodable {
    func multipartData() -> [MFData] {
        do {
            let data = try JSONEncoder().encode(self)
            
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            
            if #available(iOS 13.0, *) {
                
                var newJson = [String: String]()
                
                if let new = jsonObj as? [String: Any] {
                    
                    for (key, value) in new {
                        
                        var newValue = ""
                        
                        switch value {
                        case let ints as Int:
                            newValue = ints.description
                        case let string as String:
                            newValue = string
                        case let decimal as Decimal:
                            newValue = decimal.description
                        case let double as Double:
                            newValue = double.description
                        default: break
                        }
                    
                        newJson.updateValue(newValue, forKey: key)
                    }
                    
                    return newJson.multipartData()
                }
                
            }
            else {
                if let new = jsonObj as? [String: CustomStringConvertible] {
                    let n = new.mapValues { $0.description }
                    return n.multipartData()
                }
            }

            return ["":""].multipartData()
        }
        catch {
            return ["":""].multipartData()
        }
    }
    
}

func jsonToData(jsonDic: Dictionary<String, Any>) -> Data {
    
    var params = jsonDic
    if !JSONSerialization.isValidJSONObject(params) {
        print("is not a valid json object")
        params = [:]
    }
    
    let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)

    let str = String(data: data!, encoding: String.Encoding.utf8)
    print("Json str:\(str!)")
    return data!
    
}
