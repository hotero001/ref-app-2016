//
//  ScoreViewController.swift
//  SurfJournal
//
//  Created by Hector Otero on 1/16/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ScoreViewController: UIViewController {
    
    //declare steppers that increment/decrement score
    @IBOutlet weak var homeScoreStepper: UIStepper!
    @IBOutlet weak var awayScoreStepper: UIStepper!
    
    //buttons that enable and disable steppers to change score
    @IBOutlet weak var changeScoreButton: UIButton!
    @IBOutlet weak var disableScoreChangeButton: UIButton!
    
    //Labels for home team name and away team name
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    //Labels for home team score and away team score
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeScoreStepper.enabled = false
        awayScoreStepper.enabled = false
        //changeScoreButton.enabled = true
        
        disableScoreChangeButton.enabled = false
        disableScoreChangeButton.hidden = true
    }
    
    @IBAction func doneChangingScore(sender: AnyObject) {
        homeScoreStepper.enabled = false
        awayScoreStepper.enabled = false
        
        disableScoreChangeButton.hidden = true
        disableScoreChangeButton.enabled = false
        
        changeScoreButton.hidden = false
        changeScoreButton.enabled = true
    }
    
    @IBAction func changeScore(sender: AnyObject) {
        homeScoreStepper.enabled = true
        awayScoreStepper.enabled = true
        
        disableScoreChangeButton.hidden = false
        disableScoreChangeButton.enabled = true
        
        changeScoreButton.hidden = true
        changeScoreButton.enabled = false
    }
    
    @IBAction func homeScoreStepper(sender: UIStepper) {
        homeTeamScoreLabel.text = Int(sender.value).description
    }
    
    @IBAction func awayScoreStepper(sender: UIStepper) {
        awayTeamScoreLabel.text = Int(sender.value).description
    }
}