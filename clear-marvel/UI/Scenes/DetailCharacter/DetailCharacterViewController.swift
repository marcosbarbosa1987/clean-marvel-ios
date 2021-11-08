//
//  DetailCharacterViewController.swift
//  UI
//
//  Created by Marcos Barbosa on 07/11/21.
//

import UIKit

class DetailCharacterViewController: UIViewController, Xibed {

    // MARK: - IBOutlets
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
