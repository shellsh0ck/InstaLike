//
//  ViewControllers.swift
//  InstaLike
//
//  Created by Vitaly Sulimov on 2014-10-07.
//  Copyright (c) 2014 FIM Studio. All rights reserved.
//

import Foundation
import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        testFileSystem.Categories = [
            Category(title: "Nature", image: "nature"),
            Category(title: "Love", image: "nature"),
            Category(title: "Weather", image: "weather"),
            Category(title: "Animals", image: "animals"),
            Category(title: "People", image: "people"),
            Category(title: "Selfies", image: "selfie"),
            Category(title: "Holidays", image: "holidays"),
            Category(title: "Party", image: "party"),
            Category(title: "Family", image: "family"),
            Category(title: "B&W", image: "b&w"),
            Category(title: "Urban", image: "urban"),
            Category(title: "Food", image: "food"),
            Category(title: "Candy", image: "candy"),
            Category(title: "Drinks", image: "drinks"),
            Category(title: "Fashion", image: "fashion"),
            Category(title: "Music", image: "music"),
            Category(title: "Video Games", image: "game"),
            Category(title: "Electronics", image: "electronics"),
            Category(title: "Travel", image: "travel")
        ]
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return testFileSystem.Categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCell", forIndexPath: indexPath)as CategoryCell
        var cellModel = testFileSystem.Categories[indexPath.row]
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            cell.cellImage.image = UIImage(named: cellModel.Image)
            cell.cellTitle.text = cellModel.Title
        })
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "expandCategory" {
            var vc = segue.destinationViewController as TagsViewController
            var cell = sender as UICollectionViewCell
            var index = categoriesCollectionView.indexPathForCell(cell)
            vc.category = testFileSystem.Categories[index!.row]
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}

class TagsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var tagsTableViewController: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        self.backBtn.layer.borderWidth = 0.8
        self.backBtn.layer.borderColor = UIColor.whiteColor().CGColor
        
        loadDataModel()
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.headerImageView.image = UIImage(named: self.category!.Image)
            self.headerTitleLabel.text = self.category!.Title
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    var categoryTitle: String = ""
    
    var category: Category?
    
    func loadDataModel() {
        getTagsForCategory(categoryTitlle: self.category!.Title)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell! {
        var cell = tagsTableViewController.dequeueReusableCellWithIdentifier("tagsCell", forIndexPath: indexPath) as TagsCell
        var cellModel = category?.TagSets[indexPath.row]
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            cell.tagsLabel.text = cellModel?.Tags
            cell.copyBtn.layer.borderWidth = 1.0
            cell.copyBtn.layer.borderColor = (UIColor(red: 138/255.0, green: 61/255.0, blue: 139/255.0, alpha: 1.0)).CGColor
        })
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        
         if let result = self.category?.TagSets {
            return result.count
         }
         else {
            return 0
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    func getTagsForCategory(#categoryTitlle: String) {
        let URL = NSURL(string: "http://localhost:8888/TagsServer/getTags.php?category=\(categoryTitlle)")
        
        var TagsSets: [TagsSet] = [TagsSet]()
        var output = NSMutableArray()
        
        let sharedSession = NSURLSession.sharedSession()
        
        let downloadTask: NSURLSessionDownloadTask = sharedSession.downloadTaskWithURL(URL, completionHandler: { (location: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            
            if error == nil {
                let dataObject = NSData(contentsOfURL: location)
                let tagsSetsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataObject, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                self.category?.TagSets = self.jsonToCategory(tagsSetsDictionary) as [TagsSet]
                
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    println("Reloading data...")
                    self.tagsTableViewController.reloadData()
                    println("Done!")
                })
                println("Data has beem loaded")
                
            }
            else {
                println(error)
            }
        })
        downloadTask.resume()
        println("Done")
        
    }
    
    func jsonToCategory(json: NSDictionary) -> AnyObject {
        var output: NSMutableArray = NSMutableArray()
        for item in json["result"]! as NSMutableArray {
            println("New object: \n\(item)")
            output.addObject(TagsSet(tags: item["tags"] as String))
        }
        
        return output
    }

}