//
//  VisualDiscoverySDK.swift
//
//  Created by segmenthub on 30.01.2026.
//

import UIKit

public class VDProductsVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyListLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var searchUrl: String?
    var requestId: String?
    var products: [VDProductItem] = []
    
    public init() {
        super.init(nibName: "VDProductsVC", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addSearchBarToNavigationBar( )
        self.collectionView.register(UINib(nibName: "VDProductCC", bundle: nil), forCellWithReuseIdentifier: "VDProductCC")
        self.makeSearchFor(search_url: self.searchUrl)
        let resetButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetSearch))
        self.navigationItem.rightBarButtonItem = resetButton
    }
    
    func addSearchBarToNavigationBar() {
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Refine search (e.g. 'red', 'cotton', 'female')"
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @objc func resetSearch() {
        self.makeSearchFor(search_url: self.searchUrl)
    }

    func makeSearchFor(search_url: String?) {
        self.loadingIndicator.startAnimating()
        VisualDiscoverySDK.shared.searchFor(search_url: search_url) { response, error in
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                
                if let products = response?.similar_products, products.count > 0 {
                    self.products = products
                    self.collectionView.isHidden = false
                    self.emptyListLabel.isHidden = true
                } else {
                    debugPrint(error?.localizedDescription)
                    self.products = []
                    self.collectionView.isHidden = true
                    self.emptyListLabel.isHidden = false
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    func refineSearchFor(text: String?) {
        var newUrl = self.searchUrl
        if let text = text {
            newUrl = self.searchUrl?.appending("&search=\(text)")
        }
        self.makeSearchFor(search_url: newUrl)
    }
    
    func getSimilarsFor(productId: String?) {
        self.loadingIndicator.startAnimating()
        VisualDiscoverySDK.shared.getSimilarsFor(productId: productId, requestId: self.requestId) { response, error in
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                
                if let products = response?.similar_products, products.count > 0 {
                    self.products = products
                    self.collectionView.isHidden = false
                    self.emptyListLabel.isHidden = true
                } else {
                    debugPrint(error?.localizedDescription)
                    self.products = []
                    self.collectionView.isHidden = true
                    self.emptyListLabel.isHidden = false
                }
                self.collectionView.reloadData()
            }
        }
    }
}

extension VDProductsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VDProductCC", for: indexPath)
        let model = self.products[indexPath.row]
        if let cell = cell as? VDProductCC {
            cell.setCellFor(model: model, delegate: self)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width-50)/2
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.products[indexPath.row]
        VisualDiscoverySDK.shared.sendEventForProduct(eventUrl: model.click_event_url)
        self.navigationController?.dismiss(animated: true) {
            VisualDiscoverySDK.shared.delegate?.visiualDiscoveryProductSelected(product: model)
        }
    }
}

extension VDProductsVC: UISearchControllerDelegate {
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.refineSearchFor(text: nil)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.refineSearchFor(text: searchBar.text)
    }
}

extension VDProductsVC: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {}
}

extension VDProductsVC: VDProductCCProtocol {
    public func similarProductsTappedFor(productId: String?) {
        self.getSimilarsFor(productId: productId)
    }
}
