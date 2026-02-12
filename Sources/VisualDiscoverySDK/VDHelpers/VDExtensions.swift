//
//  VDExtensions.swift
//  VD Demo
//
//  Created by segmenthub on 12.02.2026.
//

import Foundation
import UIKit
import Kingfisher

extension Data {
    func prettyPrintedJSONString() {
        
        if let jsonResponseString = NSString(data: self, encoding: String.Encoding.utf8.rawValue) {
            print("""
                    __
                   / _)
            .-^^^-/ /
         __/       /
        <__.|_|-|_|
        """)
            debugPrint(jsonResponseString)
            print("""
                    __
                   / _)
            .-^^^-/ /
         __/       /
        <__.|_|-|_|
        """)
        }
    }
}

extension UIImageView {
    func loadImage(from urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension String {
    var strikeThroughText : NSAttributedString {
        let strikeThroughText = NSAttributedString(string: self, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        return strikeThroughText
    }
}
