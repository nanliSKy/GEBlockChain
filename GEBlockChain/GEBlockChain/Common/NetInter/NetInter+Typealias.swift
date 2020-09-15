//
//  NetInter+Typealias.swift
//  GEBlockChain
//
//  Created by nan li on 2020/7/28.
//  Copyright © 2020 darchain. All rights reserved.
//

import Foundation

import Alamofire

import Moya

public typealias MFData = Moya.MultipartFormData

public typealias TargetType = Moya.TargetType

public typealias Session = Moya.Session

public typealias HTTPHeaders = Alamofire.HTTPHeaders

public typealias ServerTrustPolice = Alamofire.ServerTrustManager

public typealias ServerPoliceEvaluating = Alamofire.ServerTrustEvaluating

public typealias SessionDelegate = Alamofire.SessionDelegate

/// 锚点证书
public typealias PinnedCertificates = Alamofire.PinnedCertificatesTrustEvaluator
