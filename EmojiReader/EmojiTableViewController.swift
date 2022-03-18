//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by brubru on 14.03.2022.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    private var emojies = Emoji.getEmoji()
    private var isEvent = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Emoji Reader"
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController else { return }
        guard let newEmojiTVC = navController.topViewController as? NewEmojiTableViewController else { return }
        newEmojiTVC.emoji = sender as? Emoji
    }

    // MARK: - IBAction
    
    @IBAction func addNewEmojiButton(_ sender: UIBarButtonItem) {
        isEvent = true
        performSegue(withIdentifier: "showNewEmoji", sender: nil)
    }
    
    @IBAction func unwindSegue(for segue: UIStoryboardSegue) {
        guard let newEmojiTVC = segue.source as? NewEmojiTableViewController else { return }
        
        let emoji = Emoji(name: newEmojiTVC.nameTextField.text ?? "",
                          emoji: Character(newEmojiTVC.emojiTextField.text ?? ""),
                          description:  newEmojiTVC.descriptionTextField.text ?? "",
                          isFavorite: false)
        
        if isEvent {
            emojies.append(emoji)
        } else {
            guard let index = tableView.indexPathForSelectedRow else { return }
            emojies[index.row] = emoji
        }
        tableView.reloadData()
    }
    
}

extension EmojiTableViewController {
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emojies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? EmojiTableViewCell
        else { return UITableViewCell()}
        
        let emoji = emojies[indexPath.row]
        cell.setEmoji(emoji)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isEvent = false
        let emoji = emojies[indexPath.row]
        performSegue(withIdentifier: "showNewEmoji", sender: emoji)
    }
    
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
        let favorite = faivoriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    private func faivoriteAction(at index: IndexPath) -> UIContextualAction {
        var emoji = emojies[index.row]
        let favorite = UIContextualAction(style: .normal, title: "Favorite") { _, _, isDone in
            emoji.isFavorite.toggle()
            self.emojies[index.row] = emoji
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.reloadData()
            }
            isDone(true)
        }
        
        favorite.backgroundColor = emoji.isFavorite ? .systemPink : .systemYellow
        favorite.image = UIImage(systemName: "heart.fill")
        
        return favorite
    }
}
