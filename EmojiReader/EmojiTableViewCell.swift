//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by brubru on 14.03.2022.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desctiptionLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    func setEmoji(_ emodji: Emoji) {
        emojiLabel.text = String(emodji.emoji)
        nameLabel.text = emodji.name
        desctiptionLabel.text = emodji.description
        favoriteLabel.isHidden = !emodji.isFavorite
    }
}
