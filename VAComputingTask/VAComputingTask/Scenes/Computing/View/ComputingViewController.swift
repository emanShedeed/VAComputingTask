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
    @IBOutlet weak var resultTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var resultTableView: FullHeightTableView!{ didSet{
        resultTableView.contentSizeChanged = {
            [weak self] newHeight in
            self?.resultTableViewHeight.constant = newHeight
        }
        }
    }
    
    
    var placeHolder = ""
    var validOperators:[String] = ["+","-","*","/"]
    let supportedOpeartions = OperationContainer(operations: [Plus(),Minus(),Multiplication(),Division()])
    var operationID = 1
    var presenter: ComputingPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
        setupTableView()
        presenter = ComputingPresenter(view: self)
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
            let delay = Int(textFields[1].text ?? "0") ?? 0
            let numbersArray = createArrayOfDoublesFromString(string: textFields[1].text ?? "")
            let op = Operation(operation: supportedOpeartions, operationType: validOperators[operatorBtn.tag] , name: "Operation\(operationID)", delayTime: Double(delay) , numbers: numbersArray)
            presenter.performOperation(obj: op)
            operationID+=1
        }
    }
    @IBAction func didTapOperatorButton(_ sender: Any) {
        operatorAutoCombleteTV.isHidden = !( operatorAutoCombleteTV.isHidden)
        
    }
    
    func createArrayOfDoublesFromString(string: String )->[Double]{
        guard string != "" else { return []}
        let stringArray = textFields[0].text?.components(separatedBy: ",") ?? []
        let doublesArray = stringArray.compactMap(Double.init)
        return doublesArray
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

extension ComputingViewController: ComputingProtocol{
    func reloadResultTVData() {
        resultTableView.reloadData()
    }
    
}
