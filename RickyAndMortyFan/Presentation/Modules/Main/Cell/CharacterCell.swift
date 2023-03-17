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

    @IBOutlet weak var viewCustomBackground: UIView! {
        didSet {
            viewCustomBackground.layer.cornerRadius = 6.0
            viewCustomBackground.clipsToBounds = true
            viewCustomBackground.layer.shadowColor = UIColor.gray.cgColor
            viewCustomBackground.layer.shadowOffset = CGSize(width: 0.8, height: 0.8)
            viewCustomBackground.layer.shadowRadius = 2.0
            viewCustomBackground.layer.shadowOpacity = 0.4
            viewCustomBackground.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView! {
        didSet {
            imageAvatar.layer.cornerRadius = 6.0
            imageAvatar.clipsToBounds = true
            imageAvatar.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var viewLabel: UIView! {
        didSet {
            viewLabel.clipsToBounds = true
            viewLabel.layer.cornerRadius = 6.0
            viewLabel.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                             .layerMinXMaxYCorner]
        }
    }

    var cellData: CharacterEntity? {
        didSet {
            labelName.text = "\(cellData?.name ?? "") \(cellData?.isAlive ?? "🫤")"
            imageAvatar.sd_setImage(with: URL(string: cellData?.image ?? ""))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
