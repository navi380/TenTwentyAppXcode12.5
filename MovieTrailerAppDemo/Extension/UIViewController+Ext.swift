//
//  UIViewController+Ext.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation
import UIKit


fileprivate let overlayViewTag: Int = 999
fileprivate let loadingViewTag: Int = 555
fileprivate let activityIndicatorViewTag: Int = 1000

extension UIViewController {
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// Public interface
extension UIView {
    func displayAnimatedActivityIndicatorView() {
        setActivityIndicatorView()
    }
    
    func hideAnimatedActivityIndicatorView() {
        removeActivityIndicatorView()
    }
}

extension UIViewController {
    private var overlayContainerView: UIView {
        if let navigationView: UIView = navigationController?.view {
            return navigationView
        }
        return view
    }
    
    func displayAnimatedActivityIndicatorView() {
        DispatchQueue.main.async {
            self.overlayContainerView.displayAnimatedActivityIndicatorView()
        }
        
    }
    
    func hideAnimatedActivityIndicatorView() {
        DispatchQueue.main.async {
            self.overlayContainerView.hideAnimatedActivityIndicatorView()
        }
    }
}

// Private interface
extension UIView {
    //read only computed property
    private var activityIndicatorView: UIActivityIndicatorView {
        let view: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tag = activityIndicatorViewTag
        return view
    }
    
    private var overlayView: UIView {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.4
        view.tag = overlayViewTag
        return view
    }
    
    private var loadingView: UIView {
        let loadingView: UIView = UIView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.backgroundColor = .black.withAlphaComponent(0.8)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        loadingView.tag = loadingViewTag
        return loadingView
    }
    
    
    private func setActivityIndicatorView() {
        guard !isDisplayingActivityIndicatorOverlay() else { return }
        
        let overlayView: UIView = self.overlayView
        
        let loadingView: UIView = self.loadingView
        
        let activityIndicatorView: UIActivityIndicatorView = self.activityIndicatorView
        
        
        //add subviews
        //        overlayView.addSubview(loadingView)
        
        loadingView.addSubview(activityIndicatorView)
        
        let window = self.window
        
        //        addSubview(overlayView)
        
        window?.addSubview(overlayView)
        window?.addSubview(loadingView)
        
        //add overlay constraints
        overlayView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        overlayView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        //
        //add loadingView constraints
        loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        //add indicator constraints
        activityIndicatorView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        
        
        //animate indicator
        activityIndicatorView.startAnimating()
    }
    
    private func removeActivityIndicatorView() {
        self.window?.subviews.forEach({ view in
            if view.tag == overlayViewTag {
                view.removeFromSuperview()
            }
            else if view.tag == loadingViewTag {
                view.removeFromSuperview()
            }
            else if view.tag == activityIndicatorViewTag{
                view.removeFromSuperview()
            }
        })
        
    }
    
    
    private func isDisplayingActivityIndicatorOverlay() -> Bool {
        getActivityIndicatorView() != nil && getLoadingView() != nil && getOverlayView() != nil
    }
    
    private func getActivityIndicatorView() -> UIActivityIndicatorView? {
        viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView
    }
    
    private func getOverlayView() -> UIView? {
        viewWithTag(overlayViewTag)
    }
    
    private func getLoadingView() -> UIView? {
        viewWithTag(loadingViewTag)
    }
}


extension UIViewController{
    public func popController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    public func pushController(vc: UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



