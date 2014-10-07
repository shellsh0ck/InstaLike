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
            Category(title: "Love", image: "love", tagSets:
                [
                    TagsSet(tags: "Allah, Allah, Allah", title: "Love"),
                    TagsSet(tags: "Allah, Allah, Allah", title: "Love"),
                    TagsSet(tags: "Allah, Allah, Allah", title: "Love"),
                    TagsSet(tags: "Allah, Allah, Allah", title: "Love"),
                    TagsSet(tags: "Allah, Allah, Allah", title: "Love")
                ]
            ),
            Category(title: "Nature", image: "nature"),
            Category(title: "Animals", image: "animals")
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
            vc.categoryTitle = testFileSystem.Categories[index!.row].Title
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
    
    var categoryTitle: String = ""
    
    var category: Category?
    
    override func viewWillAppear(animated: Bool) {
        loadDataModel()
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            self.headerImageView.image = UIImage(named: self.category!.Image)
            self.headerTitleLabel.text = self.category!.Title
        })
    }
    
    func loadDataModel() {
        self.category = testFileSystem.Categories.filter{$0.Title == self.categoryTitle}[0]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell! {
        var cell = tagsTableViewController.dequeueReusableCellWithIdentifier("tagsCell", forIndexPath: indexPath) as TagsCell
        var cellModel = category?.TagSets[indexPath.row]
        dispatch_async(dispatch_get_main_queue(), {() -> Void in
            cell.tagsLabel.text = cellModel?.Tags
        })
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.category!.TagSets.count
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}