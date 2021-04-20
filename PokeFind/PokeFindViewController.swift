//
//  ViewController.swift
//  PokeFind
//
//  Created by Nandan Tadi on 4/19/21.
//

import UIKit

struct Pokemon{
    var name: String
    var id: Int
    var height: Int
    var weight: Int
}

class PokeFindViewController: UIViewController{
    
    @IBOutlet weak var PokeFindTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    public var pokemons: [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeFindTable.dataSource = self
        PokeFindTable.delegate = self
        
        for value in 1...50{
            fetchJSON(key: value){ (jsonData) in
                DispatchQueue.main.async {
                    self.pokemons.append(Pokemon(name: jsonData.name, id: jsonData.id, height: jsonData.height, weight: jsonData.weight))
                    self.PokeFindTable.reloadData()
                }
            }
        }
        PokeFindTable.reloadData()
    }
    
    func fetchJSON(key: Int, completion: @escaping(PokeJSON) -> ()){
            let urlstr = "https://pokeapi.co/api/v2/pokemon/\(key)"
            guard let url = URL(string: urlstr) else {return}
            let request = URLRequest(url: url)
            let session = URLSession.shared
            session.dataTask(with: request){ (data,response,error) in
                if error == nil{
                    if data != nil{
                        let decoder = JSONDecoder()
                        do{
                            let jsonData = try decoder.decode(PokeJSON.self, from: data!)
                            completion(jsonData)
                        }catch{
                            print(error.localizedDescription)
                        }
                    }else{
                        print("Error fetching data")
                    }
                }else{
                    print("Error making request")
                }
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "pokeToDetail"){
            let dest = segue.destination as! DetailPokeViewController
            dest.poke = sender as? Pokemon
        }
    }
    
    
    @IBAction func fetchMore(_ sender: Any) {
        for value in 1...50{
            fetchJSON(key: value+pokemons.count){ (jsonData) in
                DispatchQueue.main.async {
                    self.pokemons.append(Pokemon(name: jsonData.name, id: jsonData.id, height: jsonData.height, weight: jsonData.weight))
                    self.PokeFindTable.reloadData()
                }
            }
        }
        PokeFindTable.reloadData()
    }
    
}

extension PokeFindViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell") as! PokeCell
        let pokemon = pokemons[indexPath.row]
        cell.setUpCell(name: pokemon.name, id: pokemon.id)
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let poke = pokemons[indexPath.row]
        performSegue(withIdentifier: "pokeToDetail", sender: poke)
        
    }
    
}
