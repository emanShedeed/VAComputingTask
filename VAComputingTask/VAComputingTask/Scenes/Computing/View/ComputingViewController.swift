//
//  ComputingViewController.swift
//  VAComputingTask
//
//  Created by gody on 9/20/21.
//  Copyright © 2021 BSS. All rights reserved.
//

import UIKit

class ComputingViewController: UIViewController {
    
    @IBOutlet  var textFields: [UITextField]!
    @IBOutlet var textFieldsTitleLabels: [UILabel]!
    @IBOutlet var validationLabels: [UILabel]!
    @IBOutlet weak var operatorBtn: UIButton!
    @IBOutlet weak var operatorValidationLabel: UILabel!
    @IBOutlet weak var operatorAutoCombleteTV: UITableView!
    
    var placeHolder = ""
    var validOperators:[String] = ["+","-","*","/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //      let supportedOpeartions = OperationContainer(operations: [Plus(),Minus(),Multiplication(),Division()])
        //
        //        let firstOp = Operation(operation: supportedOpeartions, operationType: "/", name: "Operation1", delayTime: 15.0, numbers: [1,2,3,4,6])
        //       print(firstOp)
        setupView()
    }
    func setupView(){
        //textFields
        textFields.forEach { (textField) in
            textField.delegate=self
            textField.addBorderWith(borderColor: UIColor.ButtonBorder!, borderWith: 1.0, borderCornerRadius: 10)
            textField.setLeftPaddingPoints(10.0)
            ///
            textField.keyboardToolbar.nextBarButton.setTarget(self, action: #selector(nextBtnPressed))
            textField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(nextBtnPressed))
        }
        operatorAutoCombleteTV.dataSource = self
        operatorAutoCombleteTV.delegate = self
    }
    
    @IBAction func didTapCalculateButton(_ sender: Any) {
        var isCompleted=true
        for (index,textField) in textFields.enumerated(){
            let (valid, message) = validate(textField)
            validationLabels[index].isHidden=valid
            validationLabels[index].text=message
            if(!valid){
                isCompleted=false
                // break
            }
        }
        if(operatorBtn.tag == -1)
        {
            isCompleted = false
            operatorValidationLabel.isHidden = false
        }else{
            operatorValidationLabel.isHidden = true
        }
        if isCompleted{
            
        }
    }
    @IBAction func didTapOperatorButton(_ sender: Any) {
        operatorAutoCombleteTV.isHidden = !( operatorAutoCombleteTV.isHidden)
        
    }
}
extension ComputingViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFields[0]:
            let (valid, message) = validate(textField)
            
            if valid {
                textFields[1].becomeFirstResponder()
            }
            
            // Update Password Validation Label
            validationLabels[0].text = message
            
            // Show/Hide Password Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.validationLabels[0].isHidden = valid
            })
            
        default:
            let (valid, message) = validate(textField)
            
            if valid {
                textFields[1].resignFirstResponder()
            }
            
            // Update Password Validation Label
            validationLabels[1].text = message
            
            // Show/Hide Password Validation Label
            UIView.animate(withDuration: 0.25, animations: {
                self.validationLabels[1].isHidden = valid
            })
        }
        return true
    }
    @objc func nextBtnPressed(textField:UITextField){
        _ = textFieldShouldReturn(textField)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addBorderWith(borderColor: UIColor.appColor!, borderWith: 1.0, borderCornerRadius: 10)
        placeHolder = textField.placeholder ?? ""
        textField.placeholder = ""
        textFieldsTitleLabels.forEach { (titleLbl) in
            if(titleLbl.tag == textField.tag){
                titleLbl.isHidden = false
                titleLbl.textColor = UIColor.appColor
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.addBorderWith(borderColor: UIColor.ButtonBorder!, borderWith: 1.0, borderCornerRadius: 10)
        if textField.placeholder == ""{
            textField.placeholder = placeHolder
        }
        
        textFieldsTitleLabels.forEach { (titleLbl) in
            if(titleLbl.tag == textField.tag){
                if(textField.text != ""){
                    titleLbl.isHidden = false
                    titleLbl.textColor = UIColor.ButtonBorder
                }else{
                    titleLbl.isHidden = true
                }
            }
        }
    }
    // MARK: - Helper Methods
    fileprivate func validate(_ textField: UITextField) -> (Bool, String?) {
        guard let text = textField.text else {
            return (false, nil)
        }
        
        if textField == textFields[0] {
            let numbersRegEx = "^[0-9,]*$"
            let numbersTest = NSPredicate(format:"SELF MATCHES %@", numbersRegEx)
            return (text.count == 0 ? ( (text.count > 0, "Required Field") ) : (numbersTest.evaluate(with:textField.text), "Invalid Sequence."))
        }
        if textField == textFields[1] {
            let delayRegex="^[0-9]+$"
            let delayTest=NSPredicate(format: "SELF MATCHES %@", delayRegex)
            return (text.count == 0 ? ( (text.count > 0, "Required Field") ) : (delayTest.evaluate(with:textField.text), "Invalid Sequence."))
        }
        
        
        return (text.count > 0, "Required Field.")
    }
}
extension ComputingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return validOperators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "autoCompleteCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "autoCompleteCell")
        }
        cell.textLabel?.text = validOperators[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        operatorValidationLabel.isHidden=true
        operatorAutoCombleteTV.isHidden=true
        
        let  selectedName = validOperators[indexPath.row]
        operatorBtn.setTitle(selectedName, for: .normal)
        operatorBtn.tag = 1
        operatorBtn.setTitleColor(UIColor.black, for: .normal)
    }
    
}
