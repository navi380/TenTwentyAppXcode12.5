//
//  UIView+Ext.swift
//  MovieTrailerApp
//
//  Created by Naveed Tahir on 29/11/2021.
//

import Foundation
import UIKit


@IBDesignable
extension UIView{
    
    func roundCorner(value: CGFloat){
        self.layer.cornerRadius = value
        self.clipsToBounds = true
    }
    
    @IBInspectable var roundRadius : CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.roundRadius
        }
    }
    
    /// automatically set cornerRadius as half of height
    @IBInspectable var isRounded : Bool {
        set {
            let radius = newValue ? self.frame.height/2 : 0
            self.layer.cornerRadius = radius
        }
        get {
            return self.isRounded
        }
    }
    
    @IBInspectable var borderWidth : CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.masksToBounds = false
            layer.shadowRadius = newValue
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    

   
}
