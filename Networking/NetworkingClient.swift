//
//  NetworkingClient.swift
//  Networking
//
//  Created by Adam Zarn on 1/31/18.
//  Copyright © 2018 Adam Zarn. All rights reserved.
//

import Foundation

protocol NetworkingClientDelegate {
    func didReceivePosts(postStructs: [PostStruct]?, error: String?)
}

class NetworkingClient: NSObject {
    
    var delegate: PostsViewController?
    
    let baseURL = "https://jsonplaceholder.typicode.com/"
    let posts = "posts"
    
    func getPosts() {
        let urlString = baseURL + posts
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error {
                    self.delegate?.didReceivePosts(postStructs: nil, error: error.localizedDescription)
                }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        self.delegate?.didReceivePosts(postStructs: nil, error: response.description)
                    }
                }
                if let data = data {
                    do {
                        let postStructs = try JSONDecoder().decode([PostStruct].self, from: data)
                        self.delegate?.didReceivePosts(postStructs: postStructs, error: nil)
                    } catch let error {
                        self.delegate?.didReceivePosts(postStructs: nil, error: error.localizedDescription)
                    }
                }
            }).resume()
        } else {
            delegate?.didReceivePosts(postStructs: nil, error: "Bad URL")
        }
    }
    
    func hasConnectivity() -> Bool {
        do {
            let reachability = Reachability()
            let networkStatus: Int = reachability!.currentReachabilityStatus.hashValue
            return (networkStatus != 0)
        }
    }

    static let shared = NetworkingClient()
    private override init() {
        super.init()
    }
    
}
