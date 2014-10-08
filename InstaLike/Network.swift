//
//  Network.swift
//  InstaLike
//
//  Created by Vitaly Sulimov on 2014-10-07.
//  Copyright (c) 2014 FIM Studio. All rights reserved.
//

import Foundation

//class Network {
//    func getTagsForCategory(#category: String) -> [TagsSet] {
//        let URL = NSURL(string: "http://localhost:8888/TagsServer/getTags.php?category=\(category.lowercaseString)")
//        
//        var TagsSets: [TagsSet] = [TagsSet]()
//        var output = NSMutableArray()
//        
//        let sharedSession = NSURLSession.sharedSession()
//        
//        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(URL, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
//            
//            if error == nil {
//                let dataObject = NSData(contentsOfURL: location)
//                let tagsSetsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//                 TagsSets = self.jsonToCategory(tagsSetsDictionary) as [TagsSet]
//                
//            }
//            else {
//                println(error)
//            }
//        })
//        downloadTask.resume()
//        println("Done")
//        
//    }
//    
//    func jsonToCategory(json: NSDictionary) -> AnyObject {
//        var output: NSMutableArray = NSMutableArray()
//        for item in json["result"]! as NSMutableArray {
//            println("New object: \n\(item)")
//            output.addObject(TagsSet(tags: item["tags"] as String))
//        }
//        
//        return output
//    }
//}
