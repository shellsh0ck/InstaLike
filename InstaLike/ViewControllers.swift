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
    override func viewDidLoad() {
        super.viewDidLoad()
        testFileSystem.Categories = [
            Category(title: "Top", image: "0"),
            Category(title: "Nature", image: "0"),
            Category(title: "Animals", image: "0")
        ]
    }
    
}

class TagsViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var tagsTableViewController: UITableView!
}