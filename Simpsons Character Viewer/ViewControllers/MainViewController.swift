//
//  MainViewController.swift
//  Simpsons Character Viewer
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var mainArray: [Character] = []
    var array: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    private func loadData() {
        let api = API()
        api.getCharacters(urlKey: .BASE) { (response) in
            switch (response) {
            case .success(let object):
                guard let characterArray = object as? [Character] else {
                    self.alert(title: "Error!", message: "Unable to load characters!")
                    self.array = []
                    self.reloadData()
                    return
                }
                self.mainArray = characterArray
                self.array = characterArray
                self.reloadData()
            case .failure(let error):
                print("ERROR: \(error)")
                self.alert(title: "Error!", message: "Unable to load characters!")
                self.array = []
                self.reloadData()
            }
        }
    }
    
    private func reloadData() {
        tableView.reloadData()
    }
    
    private func searchCharacters(string: String) {
        if string == "" {
            array = mainArray
        } else {
            let filterArray = mainArray.filter( { $0.name.lowercased().contains(string) } )
            array = filterArray
        }
        reloadData()
    }
    
    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - TEXTFIELD DELEGATE

extension MainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            searchCharacters(string: text + string)
        } else {
            searchCharacters(string: "")
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            searchCharacters(string: text)
        }
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - TABLEVIEW DELEGATE

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CharacterTableViewCell {
            let character = array[indexPath.row]
            cell.selectionStyle = .none
            cell.setUpCell(character: character)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = array[indexPath.row]
        let vc = DetailsViewController()
        vc.character = selectedCharacter
        present(vc, animated: true, completion: nil)
    }
}

