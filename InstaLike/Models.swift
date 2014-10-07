//
//  Models.swift
//  InstaLike
//
//  Created by Vitaly Sulimov on 2014-10-07.
//  Copyright (c) 2014 FIM Studio. All rights reserved.
//

import Foundation
import UIKit
/* Basic class to store UIView elements for cell representing tags set */
class TagsCell: UITableViewCell {
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet var copyBtn: UIButton!
    @IBAction func copyBtn_Click() {
        UIPasteboard.generalPasteboard().string = tagsLabel.text
        UIView.animateWithDuration(0.5, animations: {
            self.copyBtn.backgroundColor = UIColor(red: 255/255.0, green: 59/255.0, blue: 107/255.0, alpha: 1.0)
            self.copyBtn.setTitle("Copied!", forState: UIControlState.Normal)
            self.copyBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.copyBtn.setTitle("Copy", forState: UIControlState.Normal)
                    self.copyBtn.backgroundColor = UIColor.clearColor()
                    self.copyBtn.setTitleColor(UIColor(red: 255/255.0, green: 59/255.0, blue: 107/255.0, alpha: 1.0), forState: UIControlState.Normal)
                })
        })
    }
    
}
/* end */

/* Basic class to store UIView elements for cell representing category of tags */
class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!

}
/* end */

/* Bacis class describing Set of tags, consist of Tags {written separated by "," symbol} (String) and Title (String) */
class TagsSet {
    var Tags: String
    var Title: String
    
    init(tags: String, title:String) {
        self.Tags = tags
        self.Title = title
    }
}
/* end */

/* Bacis class describing Category, containing: Title (String), Image { which is used as a base of UIImage further } (String) and array of sets of tags (TagsSet) */
class Category {
    var Title: String
    var Image: String
    var TagSets: [TagsSet]
    
    init(title: String, image: String) {
        self.Title = title
        self.Image = image
        self.TagSets = [TagsSet]()
    }
    
    init(title: String, image: String, tagSets:[TagsSet]) {
        self.Title = title
        self.Image = image
        self.TagSets = tagSets
    }
}
/* end */

/* Root class to interact with  data model. Consist of categories array (Category) */
class FileSystem {
    var Categories: [Category]
    
    init() {
        self.Categories = [Category]()
    }
    
    
}
/* end */

/* Test zone, testing UI without JSON data */

var testFileSystem = FileSystem()
/* end */