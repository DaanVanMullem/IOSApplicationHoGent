//
//  ViewController.swift
//  FirstProjectTest2
//
//  Created by user208206 on 12/24/21.
//
import UIKit

class ViewController: UIViewController  {

    @IBOutlet var searchField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.textAlignment = .center
        searchField.placeholder = "Please enter your Game titel"
        searchField.returnKeyType = .search
        searchField.autocapitalizationType = .words
        searchField.autocorrectionType = .no
        searchField.delegate = self
    }
    
    @IBAction func search(_ sender: Any) {
        if let text = searchField.text{
            print("\(text)")
            performSegue(withIdentifier: "showStores", sender: self)
        }
}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let storeVC = segue.destination as? StoresViewController else { return }
        let toSearch = searchField.text?.replacingOccurrences(of: " ", with: "-")
        storeVC.searchTerm = toSearch
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = searchField.text{
            print("\(text)")
            self.performSegue(withIdentifier: "showStores", sender: self)
        }
        return true
    }
}
