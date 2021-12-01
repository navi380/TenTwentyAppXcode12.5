//
//  ViewController.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import UIKit
import SDWebImage

class WatchVC: BaseVC {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var watchCollectionView  : UICollectionView!
    @IBOutlet weak var countOfPages         : UILabel!
    
    // MARK: -  PROPERTIES
    var watchViewModel = ProvideViewModel.provide.watchViewModel()
    
    var responseModel: [MovieAttributes]?
    
    var currentPage: Int?
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        popularMovieAPICall()
    }
    
    // MARK: - IBACTIONS
    @IBAction func NextTapped(_ sender: Any) {
        var seletedPage = currentPage ?? 0
        if Reachability.isConnectedToNetwork(){
            if seletedPage >= 500{
                self.hideAnimatedActivityIndicatorView()
                self.showToast(message: "No More Movies Left", font: .systemFont(ofSize: 14.0))
            }
            else{
                self.displayAnimatedActivityIndicatorView()
                seletedPage += 1
                watchViewModel.getPopularPoginationMovies(page: seletedPage)
                watchViewModel.responseData.bind { [self] result in
                    hideAnimatedActivityIndicatorView()
                    responseModel = result?.results
                    currentPage = result?.page
                    countOfPages.text = "\(currentPage ?? 5) ... \(result?.total_pages ?? 500)"
                    watchCollectionView.reloadData()
                }
                showErrorMessage()
            }
        }
        else{
            showAlertMessage(alertText: "Alert", alertMessage: "No internet Connection")
        }
    }
    
    @IBAction func previousTapped(_ sender: Any) {
        var seletedPage = currentPage ?? 0
        if Reachability.isConnectedToNetwork(){
            if seletedPage <= 1{
                self.hideAnimatedActivityIndicatorView()
                self.showToast(message: "No More Movies Left", font: .systemFont(ofSize: 14.0))
            }
            else{
                self.displayAnimatedActivityIndicatorView()
                seletedPage -= 1
                watchViewModel.getPopularPoginationMovies(page: seletedPage)
                watchViewModel.responseData.bind { [self] result in
                    hideAnimatedActivityIndicatorView()
                    responseModel = result?.results
                    currentPage = result?.page
                    countOfPages.text = "\(currentPage ?? 5) ... \(result?.total_pages ?? 500)"
                    watchCollectionView.reloadData()
                }
                showErrorMessage()
            }
        }
        else{
            showAlertMessage(alertText: "Alert", alertMessage: "No internet Connection")
        }
    }
}


// MARK: - FUNCTIONS EXTENSION
extension WatchVC{
    
    func configuration(){
        watchCollectionView.delegate = self
        watchCollectionView.dataSource = self
        watchCollectionView.register(UINib(nibName: "watchCVC", bundle: nil), forCellWithReuseIdentifier: "watchCVC")
        watchCollectionView.register(UINib(nibName: "WatchEmptyCVC", bundle: nil), forCellWithReuseIdentifier: "WatchEmptyCVC")
        watchCollectionView.reloadData()
    }
    
    // MARK: - API CALL
    func popularMovieAPICall(){
        if Reachability.isConnectedToNetwork(){
            self.displayAnimatedActivityIndicatorView()
            watchViewModel.getPopularMovies()
            watchViewModel.responseData.bind { [self] result in
                hideAnimatedActivityIndicatorView()
                responseModel = result?.results
                currentPage = result?.page
                countOfPages.text = "\(currentPage ?? 5) ... \(result?.total_pages ?? 500)"
                watchCollectionView.reloadData()
            }
            showErrorMessage()
        }
        else{
            responseModel = []
        }
    }
    
    func showErrorMessage(){
        watchViewModel.errorMessage.bind { message in
            self.hideAnimatedActivityIndicatorView()
        }
    }
}

// MARK: - EXTENSION COLLECTIONVIEW DATASOURCE AND DELEGATE
extension WatchVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if responseModel?.count == 0{
            return 1
        }
        return responseModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if responseModel?.count == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchEmptyCVC", for: indexPath) as! WatchEmptyCVC
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchCVC", for: indexPath) as! watchCVC
            cell.movieTitleLabel.text = responseModel?[indexPath.item].title
            cell.movieImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(responseModel?[indexPath.row].poster_path ?? "")"), completed: nil)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetVc  = self.storyboard?.instantiateViewController(withIdentifier: "WatchDetailVC") as! WatchDetailVC
        targetVc.movieId = responseModel?[indexPath.item].id
        self.navigationController?.pushViewController(targetVc, animated: true)
    }
    
}

// MARK: - COLLECTIONVIEW DELEGATE FLOWLAYOUT
extension WatchVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 20  , height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
