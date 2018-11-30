//
//  sharedValue.swift
//  Mashup_Calculator
//
//  Created by 김현태 on 27/11/2018.
//  Copyright © 2018 onemoon. All rights reserved.
//

import Foundation

struct SharedClass {
    // TODO: variable 자체를 shared 할순 없을까?
    static var shared: SharedClass = SharedClass()
    
    var value: String?
}
