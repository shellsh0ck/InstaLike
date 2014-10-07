//
//  Network.swift
//  InstaLike
//
//  Created by Vitaly Sulimov on 2014-10-07.
//  Copyright (c) 2014 FIM Studio. All rights reserved.
//

import Foundation

class Network {
    func getTagsForCategory(#category: String) {
        let URL = NSURL(string: "http://localhost:8888/TagsServer/getTags.php?category=\(category.lowercaseString)")
        
        var TagsSets: [TagsSet] = [TagsSet]()
        
        let sharedSession = NSURLSession.sharedSession()
        
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(URL, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if error == nil {
                let dataObject = NSData(contentsOfURL: location)
                let tagsSetsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: nil, error: nil) as NSDictionary
                self.jsonToCategory(tagsSetsDictionary)
            }
            else {
                println(error)
            }
        })
        downloadTask.resume()
        println("Done")
        
    }
    
    func jsonToCategory(json: NSDictionary)  {
            let curr = json["result"] as NSDictionary
    }
}