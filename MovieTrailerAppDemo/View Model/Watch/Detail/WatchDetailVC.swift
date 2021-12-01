//
//  WatchDetailVC.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 30/11/2021.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper


class WatchDetailVC: BaseVC {
    // MARK: - IBOUTLETS
    @IBOutlet weak var MovieImageView       : UIImageView!
    @IBOutlet weak var dataLabel            : UILabel!
    @IBOutlet weak var genresLabel          : UILabel!
    @IBOutlet weak var overViewLabel        : UILabel!
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var YtVideoPlyer         : YTPlayerView!
    
    // MARK: - PROPERTIES
    var watchDetailViewModel = ProvideViewModel.provide.watchDetailViewModel()
    
    var movieId: Int?
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMovieDetail()
    }
    
    // MARK: - IBACTIONS
    @IBAction func watchTrailerAction(_ sender: Any) {
        watchDetailViewModel.getMovieVideos(id: movieId ?? 580489)
        watchDetailViewModel.responseVideoData.bind { [self] movieVideos in
            if movieVideos?.results?.count == 0{
                showAlert(alertText: "Error", alertMessage: "No Trailer Available")
            }
            else{
                YtVideoPlyer.isHidden = false
                let disableMyButton = sender as? UIButton
                disableMyButton?.isEnabled = false
                disableMyButton?.setTitle("Watched", for: .disabled)
                disableMyButton?.setTitleColor(.red, for: .disabled)
                self.YtVideoPlyer.load(withVideoId: movieVideos?.results?[0].key ?? "")
            }
        }
    }
}


// MARK: - FUNCTIONS EXTENSION
extension WatchDetailVC{
    
    func getMovieDetail(){
        if Reachability.isConnectedToNetwork(){
            self.displayAnimatedActivityIndicatorView()
            watchDetailViewModel.getMovieDetail(id: movieId ?? 580489)
            watchDetailViewModel.responseData.bind { [self] MovieDetail in
                self.hideAnimatedActivityIndicatorView()
                dataLabel.text = MovieDetail?.release_date
                overViewLabel.text = MovieDetail?.overview
                titleLabel.text = MovieDetail?.title
                MovieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                MovieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(MovieDetail?.poster_path ?? "")"), completed: nil)
                MovieDetail?.genres?.forEach({$0.name.map{genresLabel.text = $0}})
                YtVideoPlyer.isHidden = true
            }
            watchDetailViewModel.errorMessage.bind { message in
                print(message as Any)
            }
        }
        else{
            showAlertMessage(alertText: "Internet", alertMessage: "No Internet Connection") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
