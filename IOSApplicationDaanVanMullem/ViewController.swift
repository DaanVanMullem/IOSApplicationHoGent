//
//  ViewController.swift
//  FirstProjectTest2
//
//  Created by user208206 on 12/24/21.
//
import UIKit

class ViewController: UIViewController  {

    @IBOutlet var searchField: UITextField!
    @IBOutlet var regionPicker: UIPickerView!
    @IBOutlet var searchButton: UIButton!
    
    let regions = ["au","ca","dk","eu","no","ru","ch","gb","us"]
    var selectedRegion = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regionPicker.dataSource = self
        regionPicker.delegate = self
        regionPicker.selectRow(3, inComponent: 0, animated: true)
        searchField.textAlignment = .center
        searchField.placeholder = "Please enter your Game title"
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
        storeVC.searchRegion = selectedRegion
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

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return regions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return regions[row]
    }
    
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRegion = regions[row]
    }
}




