//
//  NetProvider+Methods.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import ReactiveSwift

import Moya

// MARK: - Launch - 返回方式为 `<NetResult<解析>, NetError>`
extension NetProvider {
    
    
    public func transform<Engine>(_ decodable: Engine.Type, _ decoder: JSONDecoder/* = JSONDecoder()*/) -> (Response) -> NetResult<Engine> {
        return { (response) -> NetResult<Engine> in
            do {
                var result = try decoder.decode(NetResult<Engine>.self, from: response.data)
                if decodable == DontCare.self { result.result = (DontCare() as! Engine) }
                return result
            }
            catch {
                //FIXME: 临时
                if response.statusCode != 200 {
                    return NetResult(result: nil, message: "网络错误 \(response.statusCode)", code: response.statusCode, good: false)
                }
                return NetResult.ParseWrong
            }
        }
    }
    
    /// 网络请求 <NetResult<解析>, NetError>
    ///
    ///   - (1) 将未成功的网络请求(`MoyaError`)转译为`NetError`
    ///   - (2) 分析网络是否响应成功(200)
    ///   - (3) 解析数据
    /// - Parameters:
    ///   - target: 网络目标
    ///   - codable: 解析方式
    /// - Returns: NetResult<解析>, NetError
    open func launch<Engine>(_ target: T, _ decodable: Engine.Type, _ decoder: JSONDecoder/* = JSONDecoder()*/) -> SignalProducer<NetResult<Engine>, NetError> where Engine: Decodable {
        return super.reactive.request(target)
            .parachute()
            .attempt({ (response) -> Swift.Result<(), NetError> in
                switch response.statusCode {
                case 200: return .success(())
                default: return .failure(NetError.network("网络错误 \(response.statusCode)", response))
                }
            })
            .attemptMap({ (response) -> Result<NetResult<Engine>, NetError> in
                do {
                    let result = try decoder.decode(NetResult<Engine>.self, from: response.data)
                    if result.good {
                        return .success(result)
                    }
                    return .failure(result.errorInfo)
                } catch {
                    print(error)
                    return .failure(.ParseWrong)
                }
            })
    }
    
    /// 网络请求 <NetResult<DontCare>, NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    /// - Returns: NetResult<DontCare>, NetError
    open func launch(_ target: T,  _ decoder: JSONDecoder = JSONDecoder()) -> SignalProducer<NetResult<DontCare>, NetError> {
        return self.launch(target, DontCare.self, decoder)
    }
    
}

// MARK: - Detach - 返回方式为 `<解析, NetError>`
extension NetProvider {
    /// 网络请求 <解析, NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    ///   - codable: 解析方式
    /// - Returns: 解析, NetError
    public func detach<Engine: Decodable>(_ target: T, _ codable: Engine.Type, _ decoder: JSONDecoder = JSONDecoder()) -> SignalProducer<Engine, NetError> {
        return self.launch(target, codable, decoder).attemptMap({ (result) -> Result<Engine, NetError> in
            guard let result = result.result else { return .failure(.ParseWrong) }
            return .success(result)
        })
    }
    
    /// 网络请求 <(), NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    /// - Returns: (), NetError
    public func detach(_ target: T) -> SignalProducer<(), NetError> {
        return self.detach(target, DontCare.self).map { _ in () }
    }
    
}


// MARK: - Brief - 返回方式为 `<(解析, BasicInfo), NetError>`  or  `<BasicInfo, NetError>`
extension NetProvider {
    
    /// 网络请求 <(解析, BasicInfo), NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    ///   - codable: 解析方式
    /// - Returns: <(解析, BasicInfo), NetError>
    public func briefing<Engine: Decodable>(_ target: T, _ codable: Engine.Type, _ decoder: JSONDecoder = JSONDecoder()) -> SignalProducer<(Engine, BasicInfo), NetError> {
        return self.launch(target, codable, decoder).attemptMap({ (result) -> Result<(Engine, BasicInfo), NetError> in
            guard let value = result.result else { return .failure(.ParseWrong) }
            return .success((value, result.info))
        })
    }
    
    /// 网络请求 <BasicInfo, NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    ///   - codable: 解析方式
    /// - Returns: <BasicInfo, NetError>
    public func brief<Engine: Decodable>(_ target: T, _ codable: Engine.Type) -> SignalProducer<BasicInfo, NetError> {
        return self.briefing(target, codable).map { $1 }
    }
    
    /// 网络请求 <BasicInfo, NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    /// - Returns: <BasicInfo, NetError>
    public func brief(_ target: T) -> SignalProducer<BasicInfo, NetError> {
        return self.briefing(target, DontCare.self).map { $1 }
    }
    
}


// MARK: - 主/次解析方式
extension NetProvider {
    
    /// 用于解析的结果
    ///
    /// - main: 首要解析方式
    /// - second: 次要解析方式
    public enum Engine<Main: Decodable, Second: Decodable>: Decodable {
        case main(Main), second(Second)
        
        public init(from decoder: Decoder) throws {
            self = Engine<DontCare, DontCare>.main(DontCare()) as! NetProvider<T>.Engine<Main, Second>
        }
    }
    
    
    
    
    /// 尝试解码2次 <NetProvider.Engine<Engine, Second>, NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    ///   - engine: 主解析，失败后采用副解析
    ///   - second: 副解析
    /// - Returns: <NetProvider.Engine<Engine, Second>, NetError>
    open func launch<Engine: Decodable, Second: Decodable>(_ target: Target, main engine: Engine.Type, second: Second.Type) -> SignalProducer<NetProvider.Engine<Engine, Second>, NetError> {
        
        return super.reactive.request(target)
            .parachute()
            .attemptMap { (response) -> Result<NetProvider.Engine<Engine, Second>, NetError> in
                
                do {
                    let mainEngine = try JSONDecoder().decode(NetResult<Engine>.self, from: response.data)
                    if mainEngine.good == false { return .failure(mainEngine.errorInfo) }
                    if let res = mainEngine.result { return .success(.main(res)) }
                    throw NetError.ParseWrong
                }
                catch {
                    do {
                        let secondEngine = try JSONDecoder().decode(NetResult<Second>.self, from: response.data)
                        guard let res = secondEngine.result else { throw NetError.ParseWrong }
                        return .success(.second(res))
                    } catch {
                        return .failure(NetError.ParseWrong)
                    }
                }
                
        }
    }
    
}

extension NetProvider {
    
    public func progressed(_ target: Target) -> SignalProducer<ProgressResponse, NetError> {
        return reactive.requestWithProgress(target).parachute()
    }
    
}


extension NetProvider {
    
    
    /// 网络请求 <(target, BasicInfo), NetError>
    ///
    /// - Parameters:
    ///   - target: 网络目标
    /// - Returns: (网络目标, BasicInfo)
    /// 暂时不建议使用
    public func echo(_ target: T) -> SignalProducer<(T, BasicInfo), NetError> {
        return self.briefing(target, DontCare.self).map { (target, $1) }
    }
    
    
    public struct EchoSidesError<T>: Error {
        let target: T
        let error: NetError
    }
    
}


extension SignalProducer where Error == MoyaError {
    
    
    /// 将 `MoyaError` 转换为 `NetError`
    ///
    /// - Returns: SignalProducer<Value, NetError>
    func parachute() -> SignalProducer<Value, NetError> {
        
      return mapError { (error) -> NetError in
            print(error)
            
            var msg = "您的网络不稳定，请更换网络环境并尝试"
            
            if let res = error.response {
                return .network("\(msg) '\(res.statusCode)'", res)
            }
            
            switch error {
            case .imageMapping, .jsonMapping, .stringMapping(_), .objectMapping(_, _), .encodableMapping(_),
                 .parameterEncoding, .requestMapping:
                break
            case .statusCode(let a):
                msg = "\(msg) '\(a.statusCode)'"
            case .underlying(_, _):
                msg = "无法连接到服务器"
            }
            return .network(msg, error.response)
        }
        
//        return mapError { (my) -> NetError in
//
//            print(my)
//
//            var msg = "您的网络不稳定，请更换网络环境并尝试"
//
//            if let res = my.response {
//                return .network("\(msg) '\(res.statusCode)'", res)
//            }
//
//            switch my {
//            case .imageMapping, .jsonMapping, .stringMapping(_), .objectMapping(_, _), .encodableMapping(_),
//                 .parameterEncoding, .requestMapping:
//                break
//            case .statusCode(let a):
//                msg = "\(msg) '\(a.statusCode)'"
//            case .underlying(_, _):
//                msg = "无法连接到服务器"
//            }
//            return .network(msg, my.response)
//        }
    }
    
}
