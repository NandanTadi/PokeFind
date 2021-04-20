//
//  PokeCell.swift
//  PokeFind
//
//  Created by Nandan Tadi on 4/19/21.
//

import UIKit

class PokeCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUpCell(name: String, id: Int){
        pokemonName.text = name
        let poster_path = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        self.pokemonImage.load(url: URL(string: poster_path)!)

    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
