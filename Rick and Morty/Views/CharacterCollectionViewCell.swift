//
//  CharacterCollectionViewCell.swift
//  Rick and Morty
//
//  Created by Shahid Aaqeel on 2/8/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    func setup (data: Character) {
        let url = URL(string: data.image)
        characterName.text = data.name
        characterImage.load(url: url!)
        characterImage.layer.cornerRadius = 20
        characterImage.layer.masksToBounds = true
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

