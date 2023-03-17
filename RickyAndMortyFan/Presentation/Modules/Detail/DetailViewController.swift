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

	var viewModel: DetailViewModelProtocol!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    @IBOutlet weak var imageDetail: UIImageView! {
        didSet {
            imageDetail.layer.cornerRadius = 6.0
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

    override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel.viewDidAppear()
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
                if let character = self?.viewModel.getCharacter() {
                    self?.imageDetail.sd_setImage(with: URL(string: character.image))
                    self?.labelName.text = "\(character.name) (\(character.status.capitalized))"
                    self?.labelLocation.text = "Location: \(character.location)"
                    self?.labelEpisodes.text = "Appears on \(character.episode.count) episodes"
                }
            }
        }
    }
}
