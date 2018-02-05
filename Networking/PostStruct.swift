//
//  PostStruct.swift
//  Networking
//
//  Created by Adam Zarn on 1/31/18.
//  Copyright © 2018 Adam Zarn. All rights reserved.
//

import Foundation
import CoreData

struct PostStruct: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
}
