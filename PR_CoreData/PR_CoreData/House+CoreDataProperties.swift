//
//  House+CoreDataProperties.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//
//

import Foundation
import CoreData


extension House {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<House> {
        return NSFetchRequest<House>(entityName: "House")
    }


}
