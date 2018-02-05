//
//  PostsViewController.swift
//  Networking
//
//  Created by Adam Zarn on 1/31/18.
//  Copyright © 2018 Adam Zarn. All rights reserved.
//

import UIKit

class PostsViewController: UITableViewController, NetworkingClientDelegate {
    
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingClient.shared.delegate = self
        if NetworkingClient.shared.hasConnectivity() {
            NetworkingClient.shared.getPosts()
        } else {
            self.posts = DatabaseClient.shared.getPosts()
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell")!
        cell.textLabel?.text = posts![indexPath.row].title
        cell.detailTextLabel?.text = posts![indexPath.row].body
        return cell
    }
    
    func didReceivePosts(postStructs: [PostStruct]?, error: String?) {
        if let postStructs = postStructs {
            DispatchQueue.main.async {
                self.posts = DatabaseClient.shared.saveAndReturnPosts(postStructs: postStructs)
                self.tableView.reloadData()
            }
        } else {
            print(error!)
        }
    }

}

