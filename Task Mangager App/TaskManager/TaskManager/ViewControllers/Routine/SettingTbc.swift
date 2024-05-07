//
//  SettingTbc.swift
//  TaskManager
//
//  Created by Hamas Mahroof on 26/04/2024.
//

import UIKit

class SettingTbc: UITableViewController {

    @IBOutlet weak var sessionField: UITextField!
    @IBOutlet weak var breakField: UITextField!
    @IBOutlet weak var totalGoalField: UITextField!
    @IBOutlet weak var rounfPerSessionField: UITextField!
    
    var currentTextField : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        rounfPerSessionField.text =  "\(AppSettings.totalRound)"
        totalGoalField.text =  "\(AppSettings.totalGoals)"
        breakField.text =  "\(AppSettings.breakTime)"
        sessionField.text =  "\(AppSettings.sessionTime)"
    }



}
extension SettingTbc : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard !textField.text!.isEmpty else {
            return
        }
        
        switch (currentTextField) {
        case rounfPerSessionField:
            AppSettings.totalRound = Int(rounfPerSessionField.text!)!
        case totalGoalField:
            AppSettings.totalGoals = Int(totalGoalField.text!)!
        case breakField:
            AppSettings.breakTime = Int(breakField.text!)!
        case sessionField:
            AppSettings.sessionTime = Int(sessionField.text!)!
        default:
            print("")
        }

    }
 
}
