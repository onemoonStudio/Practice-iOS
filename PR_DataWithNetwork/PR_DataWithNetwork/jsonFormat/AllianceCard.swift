//
//  AllianceCard.swift
//  PR_DataWithNetwork
//
//  Created by Hyeontae on 30/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import Foundation

struct AllianceCard: Codable {
    let name: String
    let kind: String
    let locatiionStr: String
    let imageURL: String
    let targetId: String
    
    init(){
        name = ""
        kind = ""
        locatiionStr = ""
        imageURL = ""
        targetId = ""
        
    }
    
    enum CodingKeys: String,CodingKey {
        case name, kind, locatiionStr, imageURL, targetId
    }
    
}
// {"name":"Ra'mie","kind":"인디밴드","locatiionStr":"서울시 성북구 석관동\n화랑로 30길-17","imageURL":"https://s3.ap-northeast-2.amazonaws.com/onemoon-empathy-s3/back/singer.jpg","targetId":"1"}
