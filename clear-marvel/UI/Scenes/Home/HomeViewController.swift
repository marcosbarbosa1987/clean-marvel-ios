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
    
    // MARK: - Properties
    
    private let cellName = "CharacterTableViewCell"
    private let bundle = Bundle(for: CharacterTableViewCell.self)
    private var characters: CharactersViewModel?
    public var url: URL?
    public var requestCharacters: ((URL) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            self.loadingView.isHidden = true
        }
    }
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: cellName, bundle: bundle), forCellReuseIdentifier: cellName)
        }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = self.url {
            requestCharacters?(url)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.characters.data?.results?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        if let data = characters?.characters.data?.results?[indexPath.row] {
            cell.setData(data)
        }
        
        
        return cell
    }
}

extension HomeViewController: LoadingView {

    public func display(_ viewModel: LoadingViewModel) {
        
        if viewModel.isLoading {
            loadingIndicator?.startAnimating()
            loadingView.isHidden = false
        } else {
            loadingIndicator?.stopAnimating()
            loadingView.isHidden = true
        }
    }
}

extension HomeViewController: AlertView {
    
    public func display(_ viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension HomeViewController: CharactersView {
    
    public func displayCharacter(_ viewModel: CharactersViewModel) {
        self.characters = viewModel
        self.tableView.reloadData()
    }
}
