//
//  VisualDiscoverySDK.swift
//
//  Created by Mehmet Kılınçkaya on 30.01.2026.
//

import UIKit

class VDDetectsVC: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewBot: UIView!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    var detectList: [VDDetectItem] = []
    var requestId: String?
    var selectedImage: UIImage?
    var selectedIndex = 0
    var boxView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "VDDetectCC", bundle: nil), forCellWithReuseIdentifier: "VDDetectCC")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageView.image = selectedImage
        self.bgImageView.image = selectedImage
        self.imageView.layer.cornerRadius = 20
        self.viewBot.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        self.setImageWidth()
        self.drawBoxFor(index: selectedIndex)
    }
    
    func setImageWidth() {
        let cgImage = self.selectedImage?.cgImage
        let imageWidth = cgImage?.width ?? 0
        let imageHeight = cgImage?.height ?? 0
        
        let ratio = CGFloat(imageWidth) / CGFloat(imageHeight)
        self.imageWidth.constant = self.imageView.frame.height * ratio
    }

    func drawBoxFor(index: Int) {
        self.boxView?.removeFromSuperview()
        let box = self.detectList[index].box
        let frame = self.getBoxFrameFor(box: box)
        let view = UIView(frame: frame)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = .white.withAlphaComponent(0.1)
        let cornerRadius: CGFloat = frame.height > 32 ? 16 : frame.height / 4
        view.layer.cornerRadius = cornerRadius
        imageView.addSubview(view)
        self.boxView = view
    }
    
    func getBoxFrameFor(box: VDBoxModel?) -> CGRect {
        let x = box?.x1 ?? 0
        let y = box?.y1 ?? 0
        let w = ((box?.x2 ?? 0) - x)
        let h = ((box?.y2 ?? 0) - y)
        
        let cgImage = self.selectedImage?.cgImage
        let imageWidth = cgImage?.width ?? 0
        let imageHeight = cgImage?.height ?? 0
        
        let widthRatio = self.imageView.frame.width / CGFloat(imageWidth)
        let heightRatio = self.imageView.frame.height / CGFloat(imageHeight)
        
        return CGRect(x: CGFloat(x)*widthRatio, y: CGFloat(y)*heightRatio, width: CGFloat(w)*widthRatio, height: CGFloat(h)*heightRatio)
    }
    
    @IBAction func showProductTapped() {
        let detect = self.detectList[self.selectedIndex]
        let controller = VDProductsVC()
        controller.searchUrl = detect.search_url
        controller.requestId = self.requestId
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension VDDetectsVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VDDetectCC", for: indexPath)
        let isSelected = indexPath.row == selectedIndex
        let model = detectList[indexPath.row]
        if let cell = cell as? VDDetectCC {
            cell.setCellFor(imageUrl: model.image_url, name: model.label, isSelected: isSelected)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.drawBoxFor(index: indexPath.row)
        self.collectionView.reloadData()
    }
}
