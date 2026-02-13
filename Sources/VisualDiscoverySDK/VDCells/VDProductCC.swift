//
//  VDProductCC.swift
//
//  Created by segmenthub on 5.02.2026.
//

import UIKit

public protocol VDProductCCProtocol {
    func similarProductsTappedFor(productId: String?)
}

public class VDProductCC: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelOldPrice: UILabel!
    @IBOutlet weak var labelPercent: UILabel!
    @IBOutlet weak var viewPercent: UIView!
    
    var delegate: VDProductCCProtocol?
    var model: VDProductItem?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.viewContainer.layer.cornerRadius = 10
        self.viewPercent.layer.cornerRadius = 10
    }
    
    func setCellFor(model: VDProductItem, delegate: VDProductCCProtocol?) {
        self.delegate = delegate
        self.model = model
        let percent = model.similarity ?? 0
        self.labelPercent.text = "\(Int(percent))% Match"
        self.imageView.loadImage(from: model.image_url)
        self.labelBrand.text = model.brand
        self.labelName.text = model.name
        let hasDiscount = model.price != model.old_price
        let price = model.price ?? 0
        let old_price = model.old_price ?? 0
        self.labelPrice.text = "\(price) " + (model.currency ?? "")
        let oldPriceText = "\(old_price) " + (model.currency ?? "")
        self.labelOldPrice.attributedText = oldPriceText.strikeThroughText
        self.labelOldPrice.isHidden = !hasDiscount
    }
    
    @IBAction func similarTapped() {
        self.delegate?.similarProductsTappedFor(productId: self.model?.id)
    }
}
