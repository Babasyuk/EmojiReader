//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by brubru on 14.03.2022.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    private var emojies = [
        Emoji(name: "Smile", emoji: "😄", description: "Keep smiling every day", isFavorite: false),
        Emoji(name: "Footboll", emoji: "⚽️", description: "Let's play footboll", isFavorite: false),
        Emoji(name: "Love", emoji: "🥰", description: "Love is everywhere", isFavorite: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emojies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EmojiTableViewCell
        let emoji = emojies[indexPath.row]
        cell.setEmoji(object: emoji)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveEmoji = emojies.remove(at: sourceIndexPath.row)
        emojies.insert(moveEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favorite = faivoriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favorite])
    }
    
    private func doneAction(at index: IndexPath) -> UIContextualAction {
        let doneAction = UIContextualAction(style: .destructive, title: "Done") { [self] _, _, isDone in
            self.emojies.remove(at: index.row)
            self.tableView.deleteRows(at: [index], with: .fade)
            isDone(true)
        }
        
        doneAction.backgroundColor = .systemBlue
        doneAction.image = UIImage(systemName: "circle")
        return doneAction
    }
    
    private func faivoriteAction(at index: IndexPath) -> UIContextualAction {
        var emoji = emojies[index.row]
        let faivorite = UIContextualAction(style: .normal, title: "Favorite") { _, _, isDone in
            emoji.isFavorite.toggle()
            self.emojies[index.row] = emoji
            isDone(true)
        }
        
        faivorite.backgroundColor = emoji.isFavorite ? .systemPink : .systemYellow
        faivorite.image = UIImage(systemName: "heart.fill")
        
        return faivorite
    }
}
