//
//  DatabaseClient.swift
//  Networking
//
//  Created by Adam Zarn on 2/2/18.
//  Copyright © 2018 Adam Zarn. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseClient: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func getPosts() -> [Post]? {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        do {
            let results = try DatabaseClient.getContext().fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [Post]
            return results
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func saveAndReturnPosts(postStructs: [PostStruct]) -> [Post]? {
        if deleteAllPosts() {
            let context = DatabaseClient.getContext()
            let entity = NSEntityDescription.entity(forEntityName: "Post", in: context)
            var posts: [Post] = []
            for postStruct in postStructs {
                let post = NSManagedObject(entity: entity!, insertInto: context) as! Post
                post.setValue(postStruct.userId, forKey: "userId")
                post.setValue(postStruct.id, forKey: "id")
                post.setValue(postStruct.title, forKey: "title")
                post.setValue(postStruct.body, forKey: "body")
                posts.append(post)
            }
            do {
                try context.save()
                return posts
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func deleteAllPosts() -> Bool {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try DatabaseClient.getContext().execute(batchDeleteRequest)
            return true
        } catch {
            return false
        }
    }
    
    static let shared = DatabaseClient()
    private override init() {
        super.init()
    }
    
}
