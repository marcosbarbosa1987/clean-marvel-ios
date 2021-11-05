//
//  CharacterTableViewCell.swift
//  UI
//
//  Created by Marcos Barbosa on 04/11/21.
//

import UIKit
import Domain
import Nuke
import Data

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var charecterName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(_ data: CharacterResult) {
        charecterName.text = data.name ?? ""
        if let stringUrl = data.thumbnail?.path, let type = data.thumbnail?.extensionType {
            
            let url = URL(string: "\(stringUrl)/\(Standard.large.rawValue).\(type)")!
            Nuke.loadImage(with: url, into: characterImage)
        }
    }
}
