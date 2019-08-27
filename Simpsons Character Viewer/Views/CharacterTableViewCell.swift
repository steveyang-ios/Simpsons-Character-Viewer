//
//  CharacterTableViewCell.swift
//  Simpsons Character Viewer
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var character: Character!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUpCell(character: Character) {
        self.character = character
        nameLabel.text = character.name
        descriptionLabel.text = character.description
    }
}
