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
    
    func setEmoji(object: Emoji) {
        emojiLabel.text = object.emoji
        nameLabel.text = object.name
        desctiptionLabel.text = object.description
    }
}
