//
//  LoginController.swift
//  UPAPP
//
//  Created by Edgardo Victorino Marin on 28/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

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

        self.usuario_txt.keyboardType = UIKeyboardType.numberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
