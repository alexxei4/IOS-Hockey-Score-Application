//
//  GameStore.swift
//  HockeyTracker
//
//  I, Alexei Ougriniouk, Student number 000776331 Certify this is my own work
//  and no one else has used it
//

import Foundation
import UIKit

class GameStore {
    
    var Games = [Game]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("Games.plist")
    }()
    
    init(){
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            let unarchiver = PropertyListDecoder()
            let items = try unarchiver.decode([Game].self, from: data)
            Games = items
        } catch {
            print("Error reading in saved items: \(error)")
        }
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveChanges),
                                       name: UIScene.didEnterBackgroundNotification,
                                       object: nil)
    }
    
    func removeItem(at index: Int) {
        Games.remove(at: index)
    }
    
    @discardableResult func createItem() -> Game {
        
        
       let newGame = Game()
        
        Games.append(newGame)
        
        return newGame
    }
    
    
     
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being move so you can reinsert it
        let movedItem = Games[fromIndex]
        
        // Remove item from array
        Games.remove(at: fromIndex)
        
        // Insert item in array at new location
        Games.insert(movedItem, at: toIndex)
    }
    
    @objc func saveChanges()-> Bool {
        print("Saving items to: \(itemArchiveURL)")
        do{
            let encoder = PropertyListEncoder()
            let data =  try encoder.encode(Games)
            try data.write(to: itemArchiveURL,options: [.atomic])
            print("Save is successfull")
            return true
        } catch let encodingError {
            print ("Error Encoding items: \(encodingError)")
        }
        return false
        
    }
    
    
    
    
    
}
