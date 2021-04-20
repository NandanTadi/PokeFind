//
//  DetailPokeViewController.swift
//  PokeFind
//
//  Created by Nandan Tadi on 4/20/21.
//

import UIKit

class DetailPokeViewController: UIViewController {

    var poke: Pokemon?
    
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokeballImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeName.text = poke?.name
        heightLabel.text = "\(String(describing: poke!.height))"
        weightLabel.text = "\(String(describing: poke!.weight))"
        let poster_path = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(poke!.id).png"
        pokeImage.load(url: URL(string: poster_path)!)
      
    }

}
