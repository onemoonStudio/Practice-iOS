//
//  HtmlData+CoreDataProperties.swift
//  PR_WebView
//
//  Created by Hyeontae on 16/02/2019.
//  Copyright © 2019 onemoonStudio. All rights reserved.
//
//

import Foundation
import CoreData


extension HtmlData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HtmlData> {
        return NSFetchRequest<HtmlData>(entityName: "HtmlData")
    }

    @NSManaged public var html: String?
    @NSManaged public var htmldata: NSData?

}
