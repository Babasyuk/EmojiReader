//
//  Emoji.swift
//  EmojiReader
//
//  Created by brubru on 14.03.2022.
//

import Foundation

struct Emoji {
    var name: String
    var emoji: Character
    var description: String
    var isFavorite: Bool
    
    static func getEmoji() -> [Emoji] {
        [
            Emoji(name: "Smile", emoji: "😄", description: "Keep smiling every day", isFavorite: false),
            Emoji(name: "Footboll", emoji: "⚽️", description: "Let's play footboll", isFavorite: false),
            Emoji(name: "Love", emoji: "🥰", description: "Love is everywhere", isFavorite: false),
        ]
    }
}
