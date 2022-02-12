//
//  InfoViewController.swift
//  Rick and Morty
//
//  Created by Shahid Aaqeel on 2/9/22.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    var data: Character?
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        if let url = URL(string: data!.image) {
            image.load(url: url)
        }
    }
    
}
