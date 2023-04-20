//
//  DetailViewController.swift
//  TheHockeyTracker
//
//  I, Alexei Ougriniouk, Student number 000776331 Certify this is my own work
//  and no one else has used it
//

import Foundation
import UIKit

class DetailViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var OpponentField: UITextField!
    
    @IBOutlet var GoalsField: UITextField!
    
    @IBOutlet var AssistsField: UITextField!
    
    @IBOutlet var PlusMinusField: UITextField!
    @IBOutlet var GameDateField: UIDatePicker!
    
    
    
  
    var game: Game! {
        didSet{
            navigationItem.title = game.opponent
        }
    }
    
    

  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        OpponentField.text = game.opponent
        GoalsField.text = "\(game.goals)"
        AssistsField.text = "\(game.assists)"
        PlusMinusField.text = "\(game.plusMinus)"
        GameDateField.date = game.gameDate
    
        
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        game.opponent = OpponentField.text ?? ""
        if Int(GoalsField.text!) != nil{
            let convertedgoals = Int(GoalsField.text!)!
            game.goals = convertedgoals
            
        
        }
        else {
            let convertedgoals = 0
            game.goals = convertedgoals
        }
        if Int(AssistsField.text!) != nil{
            let convertedassists = Int(AssistsField.text!)!
            game.assists = convertedassists
            
        
        }
        else {
            let convertedassists = 0
            game.assists = convertedassists
        }
            
        if Int(PlusMinusField.text!) != nil{
            let convertedplusminus = Int(PlusMinusField.text!)!
            game.plusMinus = convertedplusminus
            if Int(PlusMinusField.text!) == 0{
                game.points = 1
                
               // cell.customImageView.image =
               
            }
            if (Int(PlusMinusField.text!)! > 0){
                game.points = 3
                
            }
            if (Int(PlusMinusField.text!)! < 0) {
                game.points = 0
            
            }
            
        
        }
        else {
            let convertedplusminus = 0
            game.plusMinus = convertedplusminus
        }
    
        game.gameDate = GameDateField.date
         
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
       
    }
    @IBAction func backgroundtapped(_ sender: Any) {
        view.endEditing(true)
    }
  
    
}
