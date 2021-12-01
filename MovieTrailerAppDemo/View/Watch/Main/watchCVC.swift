//
//  watchCVC.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import UIKit
import SDWebImage

class watchCVC: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    var assignData: Movie? {
        didSet{
            self.movieTitleLabel?.text = assignData?.title
        }
    }

}
