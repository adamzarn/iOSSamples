//
//  Post+CoreDataProperties.swift
//  Networking
//
//  Created by Adam Zarn on 2/2/18.
//  Copyright © 2018 Adam Zarn. All rights reserved.
//
//

import Foundation
import CoreData

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?

}
