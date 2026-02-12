//
//  VisualDiscoverySDK.swift
//
//  Created by segmenthub on 30.01.2026.
//

import UIKit

class VDDetectCC: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setCellFor(imageUrl: String?, name: String?, isSelected: Bool) {
        self.imageView.loadImage(from: imageUrl)
        self.labelName.text = name
        self.imageView.layer.cornerRadius = 16
        self.viewContainer.layer.cornerRadius = 16
        self.viewContainer.layer.borderWidth = isSelected ? 2 : 0
        self.viewContainer.layer.borderColor = UIColor.systemBlue.cgColor
    }
}
