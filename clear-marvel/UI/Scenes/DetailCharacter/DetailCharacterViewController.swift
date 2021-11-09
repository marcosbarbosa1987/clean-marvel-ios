//
//  DetailCharacterViewController.swift
//  UI
//
//  Created by Marcos Barbosa on 07/11/21.
//

import UIKit
import Domain
import Nuke
import Data

public class DetailCharacterViewController: UIViewController, Xibed {

    // MARK: - IBOutlets
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    
    public var item: CharacterResult?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setName(item?.name)
        setDescription(item?.description)
        setImage(item?.thumbnail)
    }
    
    func setName(_ name: String?) {
        characterName.text = name ?? ""
    }
    
    func setDescription(_ description: String?) {
        characterDescription.text = description ?? ""
    }
    
    func setImage(_ data: CharacterThumb?) {
        if let stringUrl = data?.path, let type = data?.extensionType {
            
            let url = URL(string: "\(stringUrl)/\( Landscape.amazing.rawValue).\(type)")!
            Nuke.loadImage(with: url, into: characterImage)
        }
    }
}
