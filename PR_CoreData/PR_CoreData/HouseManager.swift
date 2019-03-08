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
            baseEntity.pet = newPet
        case .people:
            guard let data = data as? PeopleData else { return }
            let newPeople = People(entity: targetDescription, insertInto: managedContext)
            newPeople.job = data.job
            newPeople.base = baseEntity
            baseEntity.people = newPeople
        }
        do {
            try managedContext.save()
            print("saved!")
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    static func edit(nsManagedObject: NSManagedObject, data: HouseMemberData) -> Void {
        switch data {
        case is PetData:
            guard
                let data = data as? PetData,
                let managedObject = nsManagedObject as? Pet
                else { return }
            managedObject.base.name = data.name
        case is PeopleData:
            guard
                let data = data as? PeopleData,
                let managedObject = nsManagedObject as? People
                else { return }
            managedObject.base.name = data.name
            managedObject.job = data.job
        default:
            fatalError("check Type")
        }
        do {
            try managedContext.save()
            print("edited!")
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    static func filter(_ targetMemberType: MemberType?) -> [NSManagedObject] {
        guard let targetMemberType = targetMemberType else {
            return try! managedContext.fetch(NSFetchRequest(entityName: "House"))
        }
        let predicate = NSPredicate(
            format: "%K == %@",
            #keyPath(Base.type),
            NSNumber(value: targetMemberType.rawValue)
        )
        let filterRequest = NSFetchRequest<NSManagedObject>(entityName: "Base")
        filterRequest.predicate = predicate
        
        do {
            let baseList = try managedContext.fetch(filterRequest)
            var result: [NSManagedObject]
            switch targetMemberType {
            case .people:
                result = baseList.map({ (object) -> People in
                    object.value(forKey: "people") as! People
                })
            case .pet:
                result = baseList.map({ (object) -> Pet in
                    object.value(forKey: "pet") as! Pet
                })
            }
            return result
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    static func deleteObject(object: NSManagedObject) {
        try! managedContext.delete(object)
        try! managedContext.save()
        print("deleted!")
    }
    
    static func removeAll() {
        let requestBase = NSFetchRequest<NSManagedObject>(entityName: "Base")
        var resultBase = try! managedContext.fetch(requestBase)
        let requestHouse = NSFetchRequest<NSManagedObject>(entityName: "House")
        var resultHouse = try! managedContext.fetch(requestHouse)
        for obj in resultBase {
            managedContext.delete(obj)
        }
        for obj in resultHouse {
            managedContext.delete(obj)
        }
        try! managedContext.save()
    }
    
}
