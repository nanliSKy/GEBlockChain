//
//  NetProvider.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import Moya

import ReactiveSwift

open class NetProvider<T: TargetType>: MoyaProvider<T>, NetworkingSession {
    public override init(endpointClosure: @escaping MoyaProvider<T>.EndpointClosure = MoyaProvider<T>.defaultEndpointMapping, requestClosure: @escaping MoyaProvider<T>.RequestClosure = MoyaProvider<T>.defaultRequestMapping, stubClosure: @escaping MoyaProvider<T>.StubClosure = MoyaProvider<T>.neverStub, callbackQueue: DispatchQueue? = nil, session: Session = NetProvider<T>.defaultSession(), plugins: [PluginType] = [], trackInflights: Bool = false) {
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, session: session, plugins: plugins, trackInflights: trackInflights)
    }
}


/// 解析Code
public final class CodeInfo: CodeParse {
    
    public static let `default` = CodeInfo()
    
    private init() { }
    
    /// 解析的工具
    public var tool: CodeParse?
    
    public func message(by code: Int?) -> String? {
        return tool?.message(by: code)
    }
}

public protocol CodeParse {
    func message(by code: Int?) -> String?
}
