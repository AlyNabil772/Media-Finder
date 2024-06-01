//
//  categoriesTableViewCell.swift
//  mediafinder
//
//  Created by ALY NABIL on 31/05/2024.
//

import UIKit

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
    func configurCell(_ data: MediaModel) { 
        movieImage.image = UIImage(named: data.image)
        movieName.text = data.name
        movieYear.text = data.year
    }
}
