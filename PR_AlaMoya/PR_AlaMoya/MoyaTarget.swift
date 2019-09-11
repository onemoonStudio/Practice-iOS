//
//  MoyaTarget.swift
//  PR_AlaMoya
//
//  Created by Hyeontae on 11/09/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation
import Moya

public enum TestTarget {
    case getData
    case getPath
    case postRaw(rawData: Data)
    case postData(data: Data)
}


extension TestTarget: TargetType {
    public var baseURL: URL {
        return URL(string: "https://postman-echo.com")!
    }
    
    public var path: String {
        switch self {
        case .getData, .getPath:
            return "/get"
        case .postRaw, .postData:
            return "/post"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getData, .getPath:
            return .get
        case .postRaw, .postData:
            return .post
        }
    }
    
    public var sampleData: Data {
        // 테스팅을 위한 가짜 객체
        return Data()
    }
    
    public var task: Task {
        // TODO: check
        switch self {
        case .getData:
            return .requestPlain
        case .getPath:
            return .requestParameters(parameters: ["foo1": "bar", "foo2": "bar2"] , encoding: URLEncoding.default)
        case .postRaw(let data):
            return .requestData(data)
        case .postData(let data):
            return .requestData(data)
        }
    }
    
    public var headers: [String : String]? {
        // JSON 응답을 반환하기 때문에
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        // 성공적인 API 요청의 정의 Optional 이다.
        return .successCodes
    }
    
}
