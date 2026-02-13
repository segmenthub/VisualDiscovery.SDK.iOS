//
//  VisualDiscoverySDK.swift
//
//  Created by segmenthub on 30.01.2026.
//

import Foundation
import UIKit

public enum VDSupportedLanguage: String {
    case en = "en"
    case tr = "tr"
    case de = "de"
    case fr = "fr"
    case es = "es"
}

public protocol VisualDiscoverySDKProtocol {
    func visiualDiscoveryProductSelected(product: VDProductItem)
}

public class VisualDiscoverySDK {
    
    public static let shared = VisualDiscoverySDK()
    
    public var delegate: VisualDiscoverySDKProtocol?
    private var account_id: String?
    public var selectedLanguage: VDSupportedLanguage?
    private let plistKeyName = "VDAccountID"
    let apiUrl = "https://api.visualdiscovery.net/v1/discover"
    
    private init() {
        self.account_id = Bundle.main.object(forInfoDictionaryKey: plistKeyName) as? String
        if self.account_id == nil {
            print("⚠️ VisualDiscoverySDK: Info.plist içinde \(plistKeyName) bulunamadı.")
        }
    }
    
    public func configure(account_id: String) {
        self.account_id = account_id
    }
    
    public func detect(image: UIImage, completion: @escaping (VDDetectResponse?, Error?) -> Void) {
        
        guard let url = URL(string: "\(self.apiUrl)/detect") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        guard let account_id = self.account_id else { return }
        
        request.httpBody = createBody(
            parameters: ["account_id": account_id],
            boundary: boundary,
            data: imageData,
            mimeType: "image/jpeg",
            filename: "upload.jpg",
            fileKey: "file"
        )
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                completion(nil, error)
                return
            }
            if let data = data {
                data.prettyPrintedJSONString()
                do {
                    let decoder = JSONDecoder()
                    let responseModel = try decoder.decode(VDDetectResponse.self, from: data)
                    completion(responseModel, nil)
                }
                catch {
                    debugPrint(error)
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    public func searchFor(search_url: String?, completion: @escaping (VDSearchResponse?, Error?) -> Void) {
        guard let url = URL(string: search_url ?? "") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                completion(nil, error)
                return
            }
            if let data = data {
                data.prettyPrintedJSONString()
                do {
                    let decoder = JSONDecoder()
                    let responseModel = try decoder.decode(VDSearchResponse.self, from: data)
                    completion(responseModel, nil)
                }
                catch {
                    debugPrint(error)
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    public func getSimilarsFor(productId: String?, requestId: String?, completion: @escaping (VDSearchResponse?, Error?) -> Void) {
        guard let productId = productId,
              let requestId = requestId,
              let account_id = self.account_id else { return }
        let urlString = "\(self.apiUrl)/similar?account_id=\(account_id)&request_id=\(requestId)&id=\(productId)"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                completion(nil, error)
                return
            }
            if let data = data {
                data.prettyPrintedJSONString()
                do {
                    let decoder = JSONDecoder()
                    let responseModel = try decoder.decode(VDSearchResponse.self, from: data)
                    completion(responseModel, nil)
                }
                catch {
                    debugPrint(error)
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    public func sendEventForProduct(eventUrl: String?) {
        guard let eventUrl = eventUrl, let url = URL(string: eventUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                debugPrint(error)
                return
            }
            if let data = data {
                data.prettyPrintedJSONString()
            }
        }
        task.resume()
    }
    
    // MARK: - Helper Functions
    private func createBody(parameters: [String: String], boundary: String, data: Data, mimeType: String, filename: String, fileKey: String) -> Data {
        var body = Data()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(fileKey)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    // MARK: - UI Functions
    public func openUploadPageFor(containerVC: UIViewController) {
        let controller = VDUploadVC()
        let nvc = UINavigationController(rootViewController: controller)
        nvc.modalPresentationStyle = .fullScreen
        containerVC.present(nvc, animated: true)
    }
}
