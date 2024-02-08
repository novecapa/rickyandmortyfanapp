//
//  DetailViewController.swift
//  RickyAndMortyFan
//
//  Created by Josep Cerdà Penadés on 24/1/23.
//  
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {

    static let identifier = "DetailViewController"

    private enum Constants {
        static let cornerRadius: Double = 6.0
    }

	var viewModel: DetailViewModelProtocol!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    @IBOutlet weak var imageDetail: UIImageView! {
        didSet {
            imageDetail.layer.cornerRadius = Constants.cornerRadius
            imageDetail.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelEpisodes: UILabel!

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()
    }

    private func setupBindings() {
        viewModel.startActivityIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
            }
        }

        viewModel.stopActivityIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
        }
        viewModel.refresh = { [weak self] in
            DispatchQueue.main.async {
                if let character = self?.viewModel.character {
                    self?.imageDetail.sd_setImage(with: URL(string: character.image))
                    self?.labelName.text = "\(character.name) (\(character.status.capitalized))"
                    self?.labelLocation.text = "\(NSLocalizedString("Location:", comment: "")) \(character.location)"
                    let appearsOn = NSLocalizedString("Appears on", comment: "")
                    let episodes = NSLocalizedString("episodes", comment: "")
                    self?.labelEpisodes.text = "\(appearsOn) \(character.episode.count) \(episodes)"
                }
            }
        }
    }
}
