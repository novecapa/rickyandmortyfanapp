//
//  CharacterCell.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 23/1/23.
//

import UIKit
import SDWebImage

class CharacterCell: UICollectionViewCell {

    static let identifier = "CharacterCell"

    private enum Constants {
        static let cornerRadius: Double = 6.0
        static let shadowSize = CGSize(width: 0.8, height: 0.8)
        static let shadowRadius: Double = 2.0
        static let shadowOpacity: Float = 0.4
    }

    @IBOutlet weak var viewCustomBackground: UIView! {
        didSet {
            viewCustomBackground.layer.cornerRadius = Constants.cornerRadius
            viewCustomBackground.clipsToBounds = true
            viewCustomBackground.layer.shadowColor = UIColor.gray.cgColor
            viewCustomBackground.layer.shadowOffset = Constants.shadowSize
            viewCustomBackground.layer.shadowRadius = Constants.shadowRadius
            viewCustomBackground.layer.shadowOpacity = Constants.shadowOpacity
            viewCustomBackground.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView! {
        didSet {
            imageAvatar.layer.cornerRadius = Constants.cornerRadius
            imageAvatar.clipsToBounds = true
            imageAvatar.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var viewLabel: UIView! {
        didSet {
            viewLabel.clipsToBounds = true
            viewLabel.layer.cornerRadius = Constants.cornerRadius
            viewLabel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }

    var cellData: CharacterEntity? {
        didSet {
            guard let cellData else { return }
            labelName.text = "\(cellData.name) \(cellData.isAlive)"
            if let imageUrl = URL(string: cellData.image) {
                imageAvatar.sd_imageTransition = .fade
                imageAvatar.sd_setImage(with: imageUrl)
            }
        }
    }
}
