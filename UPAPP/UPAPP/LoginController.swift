//
//  LoginController.swift
//  UPAPP
//
//  Created by Edgardo Victorino Marin on 28/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var usuario_txt: UITextField!
    @IBOutlet weak var pass_txt: UITextField!
    @IBOutlet weak var ingresa_btn: UIButton!
    @IBAction func accion_btn(_ sender: UIButton) {
        
        if self.usuario_txt.text != "" && self.pass_txt.text != ""{
            let email = "\(self.usuario_txt.text!)@upslp.edu.mx"
            print(email)
            Auth.auth().signIn(withEmail: email, password: self.pass_txt.text!, completion: {(user,error)in
                if user != nil {
                    self.performSegue(withIdentifier: "login", sender: self)
                }else{
                    if let myError = error?.localizedDescription {
                        print(myError)
                    }else{
                        print("ERROR")
                    }
                }
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usuario_txt.delegate = self
        self.pass_txt.delegate = self
        self.usuario_txt.keyboardType = UIKeyboardType.numberPad
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usuario_txt.resignFirstResponder()
        pass_txt.resignFirstResponder()
        return (true)
    }


}
