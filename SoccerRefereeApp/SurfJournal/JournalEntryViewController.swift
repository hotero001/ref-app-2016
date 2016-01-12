/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData

protocol JournalEntryDelegate {
  
  func didFinishViewController(
    viewController:JournalEntryViewController, didSave:Bool)
}

class JournalEntryViewController: UITableViewController {
    
  @IBOutlet weak var heightTextField: UITextField!
  @IBOutlet weak var periodTextField: UITextField!
  @IBOutlet weak var windTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  
  //added this extra text field for the home team name
  @IBOutlet weak var homeTeamTextField: UITextField!
  //added this extra text field for the away team name
  @IBOutlet weak var awayTeamTextField: UITextField!
    
  //added these text fields for home color, away color, and game start
  @IBOutlet weak var homeColor: UITextField!
  @IBOutlet weak var awayColor: UITextField!
  @IBOutlet weak var gameStartTextField: UITextField!
  
  
  //added the three buttons below for starting/stopping/resetting time
  @IBOutlet weak var startButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var resetButton: UIButton!
  
  //added the timer label
  @IBOutlet weak var timerLabel: UILabel!
  
  
  //@IBOutlet weak var ratingSegmentedControl:
  //  UISegmentedControl!
  
  //additional labels for the colon and seconds labels in the timer
  @IBOutlet weak var colonForTimerLabel: UILabel!
  @IBOutlet weak var secondsForTimerLabel: UILabel!
  
  //submit half time length button
  @IBOutlet weak var submitHalfLengthButton: UIButton!
    
  //add yellow card label
  
  var journalEntry: JournalEntry! {
    didSet {
      self.configureView()
    }
  }
    
  var context: NSManagedObjectContext!
  var delegate:JournalEntryDelegate?
  
  //variables declared for counter, secondsCounter, and NSTimer()
  var counter:Int?
  var secondsCounter:Int?
  var timer = NSTimer()
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    timerLabel.text = "44"
    colonForTimerLabel.text = ":"
    secondsForTimerLabel.text = "\(60)"
    secondsCounter = Int(60)
  }
  
  
  // MARK: View Setup
  
  func configureView() {
    
    title = journalEntry.stringForDate()
    
    if let textField = heightTextField {
      if let value = journalEntry.height {
        textField.text = value
      }
    }
    
    if let textField = periodTextField {
      if let value = journalEntry.period {
        textField.text = value
      }
    }
    
    if let textField = windTextField {
      if let value = journalEntry.wind {
        textField.text = value
      }
    }
    
    if let textField = locationTextField {
      if let value = journalEntry.location {
        textField.text = value
      }
    }
    
    //added this block below which appears to set the model value of the text field
    if let textField = homeTeamTextField {
      if let value = journalEntry.homeTeam {
        textField.text = value
      }
    }
    //ended here
    
    //added this block for the core data storage of the away team name
    if let textField = awayTeamTextField {
      if let value = journalEntry.awayTeam {
        textField.text = value
      }
    }
    //ended here
    
    //this block is for the game start text field
    if let textField = gameStartTextField {
      if let value = journalEntry.gameStart {
        textField.text = value
      }
    }
    
    //this block is for the home team color
    if let textField = homeColor {
      if let value = journalEntry.homeTeamColor {
        textField.text = value
      }
    }
    
    //this block is for the away team color
    if let textField = awayColor {
      if let value = journalEntry.awayTeamColor {
        textField.text = value
      }
    }
    
    //if let segmentControl = ratingSegmentedControl {
    //  if let rating = journalEntry.rating {
    //    segmentControl.selectedSegmentIndex =
    //      rating.integerValue - 1
    //  }
    //}
  }
  
  func updateJournalEntry() {
    
    if let entry = journalEntry {
      entry.date = NSDate()
      entry.height = heightTextField.text
      entry.period = periodTextField.text
      entry.wind = windTextField.text
      entry.location = locationTextField.text
      
      //added this line
      entry.homeTeam = homeTeamTextField.text
      //ended here
      //entry.rating =
      //  NSNumber(integer:
      //    ratingSegmentedControl.selectedSegmentIndex + 1)
      
      //added this line to save the away team name
      entry.awayTeam = awayTeamTextField.text
      //added the three lines below to save the home color, away color, and game start
      entry.gameStart = gameStartTextField.text
      entry.homeTeamColor = homeColor.text
      entry.awayTeamColor = awayColor.text
    }
  }
  
  // MARK: Target Action
  
  @IBAction func cancelButtonWasTapped(sender: AnyObject) {
    delegate?.didFinishViewController(self, didSave: false)
  }
  
  @IBAction func saveButtonWasTapped(sender: AnyObject) {
    updateJournalEntry()
    delegate?.didFinishViewController(self, didSave: true)
  }
  
  @IBAction func startButtonWasTapped(sender: AnyObject) {
      //this function will take the input from periodTextField and start the countdown from x minutes
      //counter = Int(periodTextField.text!)
      //var newTime = Int(periodTextField.text!)! - 1
      //counter = Int(newTime)
      //timerLabel.text = periodTextField.text
      //timerLabel.text = String(newTime)
      //if nothing was entered in the period length default to 45
      if !timer.valid {
          timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
    }
  }
  
  func countDown() {
      secondsCounter = secondsCounter! - 1
    if (secondsCounter == 0) {
        secondsCounter = 60
        counter = counter! - 1
    }
    updateText()
  }
  
  func updateText() {
      let _:Int?
      timerLabel.text = String(counter!)
      secondsForTimerLabel.text = String(secondsCounter!)
  }
  
  @IBAction func stopButtonWasTapped(sender: AnyObject) {
      timer.invalidate()
  }
  
  @IBAction func resetButtonWasTapped(sender: AnyObject) {
      timer.invalidate()
      secondsCounter = Int(60)
      var restartTime = Int(periodTextField.text!)! - 1
      counter = Int(restartTime)
      timerLabel.text = String(counter!)
      secondsForTimerLabel.text = String(secondsCounter!)
  }
  @IBAction func submitHalfLengthButtonWasTapped(sender: AnyObject) {
      //this action sets the timer's initial values
      var newTime = Int(periodTextField.text!)! - 1
      counter = Int(newTime)
      timerLabel.text = String(newTime)
  }
}

