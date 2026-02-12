//
//  VisualDiscoverySDK.swift
//
//  Created by segmenthub on 30.01.2026.
//

import UIKit

public class VDUploadVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var buttonUpload: UIButton!
    @IBOutlet weak var buttonCamera: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var selectedImage: UIImage?
    
    public init() {
        super.init(nibName: "VDUploadVC", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.cornerRadius = 40
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeTapped))
        self.navigationItem.rightBarButtonItem = closeButton
    }

    @IBAction func uploadTapped() {
        self.openPickerFor(source: .photoLibrary)
    }
    
    @IBAction func cameraTapped() {
        self.openPickerFor(source: .camera)
    }
    
    func setUIForServiceCall(isLoading: Bool) {
        isLoading ? self.loadingIndicator.startAnimating() : self.loadingIndicator.stopAnimating()
        self.buttonCamera.isEnabled = !isLoading
        self.buttonUpload.isEnabled = !isLoading
    }
    
    func detectParts() {
        guard let image = self.selectedImage else { return }
        self.setUIForServiceCall(isLoading: true)
        VisualDiscoverySDK.shared.detect(image: image) { result, error in
            DispatchQueue.main.async {
                self.setUIForServiceCall(isLoading: false)
                if let detects = result?.detections, detects.count > 0 {
                    self.openDetectPage(detects: detects, requestId: result?.request_id)
                } else {
                    self.showErrorFor()
                }
            }
        }
    }
    
    func showErrorFor() {
        let alert = UIAlertController(title: "Error", message: "No items detected. Please try another image.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openPickerFor(source: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = source
        self.present(picker, animated: true)
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openDetectPage(detects: [VDDetectItem], requestId: String?) {
        let controller = VDDetectsVC()
        controller.detectList = detects
        controller.requestId = requestId
        controller.selectedImage = self.selectedImage
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension VDUploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.selectedImage = image
            self.detectParts()
        }
        picker.dismiss(animated: true)
    }
}
