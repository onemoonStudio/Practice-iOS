//
//  MemberProtocols.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import Foundation

protocol HouseMemberData {
    var name: String {get set}
}

struct PetData: HouseMemberData {
    var name: String
    let adopted: Bool
}

struct PeopleData: HouseMemberData {
    var name: String
    let job: String
}


