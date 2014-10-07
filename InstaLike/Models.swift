//
//  Models.swift
//  InstaLike
//
//  Created by Vitaly Sulimov on 2014-10-07.
//  Copyright (c) 2014 FIM Studio. All rights reserved.
//

import Foundation
import UIKit

class TagsCell: UITableViewCell {
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBAction func copyBtn_Click() {
    }
    
}

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!

}

class TagsSet {
    var Tags: String
    var Title: String
    
    init(tags: String, title:String) {
        self.Tags = tags
        self.Title = title
    }
}

class Category {
    var Title: String
    var Image: String
    var TagSets: [TagsSet]
    
    init(title: String, image: String) {
        self.Title = title
        self.Image = image
        self.TagSets = [TagsSet]()
    }
}

class FileSystem {
    var Categories: [Category]
    
    init() {
        self.Categories = [Category]()
    }
    
    
}


var testFileSystem = FileSystem()
