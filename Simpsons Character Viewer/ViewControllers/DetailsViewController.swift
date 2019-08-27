//
//  DetailsViewController.swift
//  Simpsons Character Viewer
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadUI() {
        if let currentChar = character {
            nameLabel.text = currentChar.name
            descriptionLabel.text = currentChar.description
            characterImageView.load(urlString: currentChar.imageUrl)
        }
    }
}
