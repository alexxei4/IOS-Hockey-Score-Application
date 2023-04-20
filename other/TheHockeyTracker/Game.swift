//
//  Game.swift
//  HockeyTracker
//
//  I, Alexei Ougriniouk, Student number 000776331 Certify this is my own work
//  and no one else has used it
//

import Foundation
class Game: Codable {
    var opponent: String

    var goals: Int
    var assists: Int
    var points: Int

    var plusMinus: Int
    var gameDate : Date
    
    
    
    
    init(){
        opponent = " "
        goals = 0
        assists = 0
        points = 0
        plusMinus = 0
        gameDate = Date()
    }
    
    
    
    
    
    
     
     
}
