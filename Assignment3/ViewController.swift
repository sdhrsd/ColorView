                        /* Name - Hera Siddiqui
                           Date - 10/08/2017
                         Used iPhone 8 as Simulator */


//
//  ViewController.swift
//  Assignment3
//
//  Created by Admin on 10/2/17.
//  Copyright © 2017 Hera Siddiqui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var currentRedValue = 0.0
    var currentGreenValue = 0.0
    var currentBlueValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        currentRedValue = defaults.double(forKey: "previousRedValue")
        currentGreenValue = defaults.double(forKey: "previousGreenValue")
        currentBlueValue = defaults.double(forKey: "previousBlueValue")
    
        redTextField.text = "\(currentRedValue)"
        greenTextField.text = "\(currentGreenValue)"
        blueTextField.text = "\(currentBlueValue)"
        
        currentRedValue = ((redTextField.text! as NSString).doubleValue)/100
        currentGreenValue = ((greenTextField.text! as NSString).doubleValue)/100
        currentBlueValue = ((blueTextField.text! as NSString).doubleValue)/100
        
        redSlider.value = (redTextField.text! as NSString).floatValue
        blueSlider.value = (blueTextField.text! as NSString).floatValue
        greenSlider.value = (greenTextField.text! as NSString).floatValue

        redSlider.tintColor = UIColor.red
        greenSlider.tintColor = UIColor.green
        blueSlider.tintColor = UIColor.blue
        
        colorView.backgroundColor = UIColor(red: CGFloat(currentRedValue), green: CGFloat(currentGreenValue), blue: CGFloat(currentBlueValue), alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /************************************FUNCTION FOR COLOR BUTTON ********************************/
    @IBAction func colorButtonPressed(_ sender: Any) {
        hideKeyboard()
        currentRedValue = ((redTextField.text! as NSString).doubleValue)/100
        redSlider.value = (redTextField.text! as NSString).floatValue

        currentGreenValue = ((greenTextField.text! as NSString).doubleValue)/100
        blueSlider.value = (blueTextField.text! as NSString).floatValue

        currentBlueValue = ((blueTextField.text! as NSString).doubleValue)/100
        greenSlider.value = (greenTextField.text! as NSString).floatValue

        colorView.backgroundColor = UIColor(red: CGFloat(currentRedValue), green: CGFloat(currentGreenValue), blue: CGFloat(currentBlueValue), alpha: 1.0)
        savingAllValues()
    }
    
    /********************************** RED SLIDER *********************************************/
    @IBAction func redSliderChanged(_ sender: UISlider) {
        let currentRedValue = sender.value
        redTextField.text = "\(currentRedValue)"
        colorButtonPressed(self)
    }
    /******************************** GREEN SLIDER *********************************************/
    @IBAction func greenSliderChanged(_ sender: UISlider) {
        let currentGreenValue = sender.value
        greenTextField.text = "\(currentGreenValue)"
        colorButtonPressed(self)
    }
    /*********************************** BLUE SLIDER *******************************************/
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        let currentBlueValue = sender.value
        blueTextField.text = "\(currentBlueValue)"
        colorButtonPressed(self)
    }
    
    func hideKeyboard() {
        view.endEditing(false)
    }
    
    /************************************** VALUE IN TEXT FIELD CHANGES ************************/
    @IBAction func textValueChanged(_ sender: UITextField) {
        if validateInput(text: sender.text!) {
            if(sender.tag == 1){
            currentRedValue = ((redTextField.text! as NSString).doubleValue)/100
            colorButtonPressed(self)
            }
            else if (sender.tag == 2) {
                currentGreenValue = ((greenTextField.text! as NSString).doubleValue)/100
                colorButtonPressed(self)
            }
            else if (sender.tag == 3) {
                currentBlueValue = ((blueTextField.text! as NSString).doubleValue)/100
                colorButtonPressed(self)
            }
        }
        else {
            let alert = UIAlertController(title: "Wrong Value", message: "Enter a Value between 0 and 100", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in
                self.startOver(sender)
            })
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    /******************************** INPUT IN PROPER RANGE *******************************/
    func startOver(_ sender: UITextField) {
        if (sender.tag == 1) {
            if(self.redTextField.text == "") {
                self.redTextField.text = "0.0"
            }
            else {
            self.redTextField.text = "100.0"
            }
            currentRedValue = ((redTextField.text! as NSString).doubleValue)/100
            colorButtonPressed(self)
            self.redTextField.becomeFirstResponder()
        }
        else if (sender.tag == 2) {
            if(self.greenTextField.text == "") {
                self.greenTextField.text = "0.0"
            }
             else {
             self.greenTextField.text = "100.0"
             }
             currentGreenValue = ((greenTextField.text! as NSString).doubleValue)/100
             colorButtonPressed(self)
             self.greenTextField.becomeFirstResponder()
        }
        else if (sender.tag == 3) {
            if(self.blueTextField.text == "") {
                self.blueTextField.text = "0.0"
            }
            else {
            self.blueTextField.text = "100.0"
            }
            currentBlueValue = ((blueTextField.text! as NSString).doubleValue)/100
            colorButtonPressed(self)
            self.blueTextField.becomeFirstResponder()
        }
        savingAllValues()
    }
    /********************************* VALIDATING THE INPUT ***************************/
    func validateInput(text: String) -> Bool {
        var result = false
        if let checking = Float(text) {
            if (checking >= 0 && checking <= 100) {
                result = true
            }
        }
        return result
    }
    /******************************** SAVING THE VALUES ******************************/
    func savingAllValues() {
        let defaults = UserDefaults.standard
        defaults.set(currentRedValue * 100, forKey: "previousRedValue")
        defaults.set(currentGreenValue * 100, forKey: "previousGreenValue")
        defaults.set(currentBlueValue * 100, forKey: "previousBlueValue")
    }
}

