//
//  ViewController.swift
//  FirstProjectTest2
//
//  Created by user208206 on 12/24/21.
//
import UIKit

class ViewController: UIViewController  {

    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func search(_ sender: Any) {
        performSegue(withIdentifier: "showStores", sender: self)
    }
}

