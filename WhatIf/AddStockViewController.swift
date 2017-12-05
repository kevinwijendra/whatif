//
//  AddStockViewController.swift
//  WhatIf
//
//  Created by Kevin Wijendra on 12/5/17.
//  Copyright © 2017 Kevin Wijendra. All rights reserved.
//

import UIKit

class AddStockViewController: UIViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var addStockTextField: UITextField!
    
    var stockSymbol: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStockTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSave" {
            stockSymbol = addStockTextField.text
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
