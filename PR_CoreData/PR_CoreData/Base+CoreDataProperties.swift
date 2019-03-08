//
//  Base+CoreDataProperties.swift
//  PR_CoreData
//
//  Created by Hyeontae on 08/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//
//

import Foundation
import CoreData


extension Base {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Base> {
        return NSFetchRequest<Base>(entityName: "Base")
    }

    @NSManaged public var name: String
    @NSManaged public var type: Int16
    @NSManaged public var people: People?
    @NSManaged public var pet: Pet?

}
