//
//  GameViewController.swift
//  HockeyTracker
//
//  I, Alexei Ougriniouk, Student number 000776331 Certify this is my own work
//  and no one else has used it
//

import Foundation
import UIKit

class GamesViewController: UITableViewController {
    var totalpoints = 0
    
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter
        }()
    
    var gameStore: GameStore!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameStore.Games.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        
        //Set the text on the cell with the description of the item
        
        let game = gameStore.Games[indexPath.row]
        if(game.opponent == " "){
            cell.textLabel?.text = " New Game , Details Required "
        }
        else{
            cell.textLabel?.text = "\(game.opponent) - \(dateFormatter.string(from: game.gameDate)) - \(game.points) "
            if(game.points == 0){
                cell.ImageView.image = UIImage(named: "Red.png")
                totalpoints += 0
            }
            if(game.points == 3){
                cell.ImageView.image = UIImage(named: "Green.png")
                totalpoints += 3

            }
            if(game.points == 1){
                cell.ImageView.image = UIImage(named: "Yellow.png")
                totalpoints += 1

            }
            
           
        }
        
     
        
        return cell
        
    }
    @IBAction func addNewGame(_ sender: UIBarButtonItem) {
        
        
            gameStore.createItem()
           
           // Make a new index path for the 0th section, last row
           
           // Build an index path that reflects that the new item
           // is now the last item in the array
           let lastRow = gameStore.Games.count - 1
           let indexPath = IndexPath(row: lastRow, section: 0)
            
           
           // Insert this new row into the table
           tableView.insertRows(at: [indexPath], with: .automatic)
          navigationItem.title = "\(gameStore.Games.count) Games - \(totalpoints) points"

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            gameStore.removeItem(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // I tried implementing a system where the points would be taken off when deleted but it didnt work as expected
           // let game = gameStore.Games[indexPath.row]
            //totalpoints -= game.points
            navigationItem.title = "\(gameStore.Games.count) Games - \(totalpoints) points"
            
        }
    }
    override func tableView(_ tableView:UITableView,
                            moveRowAt sourceIndexPath:IndexPath,
                            to destinationIndexPath: IndexPath){
        gameStore.moveItem(from: sourceIndexPath.row , to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "showgame":
            if let row = tableView.indexPathForSelectedRow?.row {
                        // Get the item associated with this row and pass it along
                        let game = gameStore.Games[row]
                        let detailViewController = segue.destination as! DetailViewController
                        detailViewController.game = game
                    }
                default:
                    preconditionFailure("Unexpected segue identifier.")
                }
       
            
        }
    override func viewWillAppear(_ animated: Bool){
        
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        //break;
    }
    }

