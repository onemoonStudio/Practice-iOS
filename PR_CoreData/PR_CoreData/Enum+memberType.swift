//
//  Enum+memberType.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//


enum MemberType: Int16 {
    case people = 1
    case pet
    
    var stringValue: String {
        return "\(self)"
    }
}
