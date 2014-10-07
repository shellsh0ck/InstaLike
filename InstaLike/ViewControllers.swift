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
                    TagsSet(tags: "#love #TagsForLikes #TFLers #tweegram #photooftheday #20likes #amazing #smile #follow4follow #like4like #look #instalike #igers #picoftheday #food #instadaily #instafollow #followme #girl #iphoneonly #instagood #bestoftheday #instacool #instago #all_shots #follow #webstagram #colorful #style #swag", title: "Love"),
                    TagsSet(tags: "#love #TagsForLikes #photooftheday #me #instamood #cute #igers #picoftheday #girl #guy #beautiful #fashion #instagramers #follow #smile #pretty #followme #friends #hair #swag #photo #life #funny #cool #hot #bored #portrait #baby #girls #iphonesia", title: "Love"),
                    TagsSet(tags: "#girl #girls #love #TagsForLikes #TFLers #me #cute #picoftheday #beautiful #photooftheday #instagood #fun #smile #pretty #follow #followme #hair #friends #swag #sexy #hot #cool #kik #fashion #igers #instagramers #style #sweet #eyes #beauty", title: "Love"),
                    TagsSet(tags: "#love #couple #cute #adorable #TagsForLikes #kiss #kisses #hugs #romance #forever #girlfriend #boyfriend #gf #bf #bff #together #photooftheday #happy #me #girl #boy #beautiful #instagood #instalove #loveher #lovehim #pretty #fun #smile #xoxo", title: "Love"),
                    TagsSet(tags: "Allah, Allah, Allah", title: "Love")
                ]
            ),
            Category(title: "Nature", image: "nature"),
            Category(title: "Animals", image: "animals"),
            Category(title: "Candy", image: "candy"),
            Category(title: "Food", image: "food")
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
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        self.backBtn.layer.borderWidth = 0.8
        self.backBtn.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
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
            cell.copyBtn.layer.borderWidth = 1.0
            cell.copyBtn.layer.borderColor = (UIColor(red: 138/255.0, green: 61/255.0, blue: 139/255.0, alpha: 1.0)).CGColor
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