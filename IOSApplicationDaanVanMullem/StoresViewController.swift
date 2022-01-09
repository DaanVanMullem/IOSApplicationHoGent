//
//  StoresViewController.swift
//  FirstProjectTest2
//
//  Created by user208206 on 12/27/21.
//

import UIKit

class StoresViewController: UITableViewController  {

    var game = Game(currency: "", currentLowestPrice: 0, developer: "", id: "", name: "", releaseDate: "", stores: [], type: "")
    var searchTerm: String! = ""
    var searchRegion: String! = ""
    let customAlert = Alert()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headers = [
            "x-rapidapi-host": "game-prices.p.rapidapi.com",
            "x-rapidapi-key": "c513e51ec6msh882eb3b4c9d62c4p17cedcjsndf0ee44625fc"
        ]

        let request = NSMutableURLRequest(url: NSURL(string:"https://game-prices.p.rapidapi.com/game/\(searchTerm ?? "Minecraft")?region=\(searchRegion ?? "eu")&type=game")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if(httpResponse.statusCode != 200){
                DispatchQueue.main.async {
                    self.customAlert.showAlert(with: "Game Not Found", message: "The game with name \(self.searchTerm ?? "...") has not been found", on: self)
                }
            }

            guard let data = data else {
                print(error.debugDescription)
                return
            }
            
            if let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? {
                print(result)
            }
            
            self.parse(json: data)
            
        }
        dataTask.resume()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonGames = try? decoder.decode(Game.self, from: json){
            game = Game(currency: jsonGames.currency, currentLowestPrice: jsonGames.currentLowestPrice, developer: jsonGames.developer, id: jsonGames.id, name: jsonGames.name, releaseDate: jsonGames.releaseDate, stores: jsonGames.stores, type: jsonGames.type)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Store prices for the game: \(searchTerm ?? "No game Found")"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.stores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let store = game.stores[indexPath.row]
        cell.textLabel?.text = store.seller
        cell.detailTextLabel?.text = String(format: "%.2f", store.price)
        cell.imageView?.image =  UIImage(named: store.seller)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let store = game.stores[indexPath.row]
        if let url = URL(string: store.url){
            UIApplication.shared.open(url)
        }
    }
}

