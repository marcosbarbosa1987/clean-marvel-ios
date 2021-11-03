//
//  HomeViewController.swift
//  UI
//
//  Created by Marcos Barbosa on 02/11/21.
//

import Foundation
import UIKit
import Presentation

public class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    var url: URL?
    var getCharacters: ((URL) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = self.url {
            getCharacters?(url)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}

extension HomeViewController: LoadingView {

    public func display(_ viewModel: LoadingViewModel) {
        
        if viewModel.isLoading {
            loadingIndicator?.startAnimating()
        } else {
            loadingIndicator?.stopAnimating()
        }
    }
}

extension HomeViewController: AlertView {
    
    public func display(_ viewModel: AlertViewModel) {
        
    }
}
