//
//  HouseManager.swift
//  PR_CoreData
//
//  Created by Hyeontae on 07/03/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//

import UIKit
import CoreData

public final class HouseManager {
    static var managedContext: NSManagedObjectContext = {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return NSManagedObjectContext()
        }
        let managedContext: NSManagedObjectContext =
            appDelegate.persistentContainer.viewContext
        
        return managedContext
    }()
    
    static func insert(memberType: MemberType, data: HouseMemberData) -> Void {
        guard
            let targetDescription =
            NSEntityDescription.entity(forEntityName: memberType.stringValue.capitalized, in: managedContext),
            let baseDescription =
            NSEntityDescription.entity(forEntityName: "Base", in: managedContext),
            let baseEntity =
            NSManagedObject(entity: baseDescription, insertInto: managedContext) as? Base
            else { return }
        baseEntity.type = memberType.rawValue
        baseEntity.name = data.name
        switch memberType {
        case .pet:
            guard let data = data as? PetData else { return }
            let newPet = Pet(entity: targetDescription, insertInto: managedContext)
            newPet.adopted = data.adopted
            newPet.base = baseEntity
        case .people:
            guard let data = data as? PeopleData else { return }
            let newPeople = People(entity: targetDescription, insertInto: managedContext)
            newPeople.job = data.job
            newPeople.base = baseEntity
        }
        do {
            try managedContext.save()
            print("saved!")
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    
    
}
