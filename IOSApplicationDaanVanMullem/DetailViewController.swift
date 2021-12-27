//
//  DetailViewController.swift
//  FirstProjectTest2
//
//  Created by user208206 on 12/27/21.
//

import UIKit

class DetailViewController: UIViewController {

    var detailItem: Store?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }
        
        if let url = URL(string: detailItem.url){
            UIApplication.shared.open(url)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
