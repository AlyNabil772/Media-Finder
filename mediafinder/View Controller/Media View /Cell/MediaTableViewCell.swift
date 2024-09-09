//
//  categoriesTableViewCell.swift
//  mediafinder
//
//  Created by ALY NABIL on 31/05/2024.
//

import UIKit
import SDWebImage

class MediaTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    //MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    //MARK: - Public Methods
    func configurCell(_ data: Result, type: MediaType) {
        switch type {
        case .tvShow:
            movieName.text = data.artistName
            movieYear.text = data.longDescription
        case .music:
            movieName.text = data.trackName
            movieYear.text = data.artistName
        case .movie:
            movieName.text = data.artistName
            movieYear.text = data.longDescription
        case .all:
            movieName.text = data.artistName
            movieYear.text = data.trackName
        }
        if let url = data.artworkUrl {
            movieImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            movieImage.image = UIImage(named: "placeholder.png")
        }
    }
    
    @IBAction func imageAnimateBtnTapped(_ sender: UIButton) {
        let imqgeFrameX = movieImage.frame.origin.x
        self.movieImage.frame.origin.x += 4
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
            self.movieImage.frame.origin.x -= 8
            self.movieImage.frame.origin.x = imqgeFrameX
        }, completion: nil)
    }
}
