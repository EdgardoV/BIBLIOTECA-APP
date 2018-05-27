//
//  busquedaViewController.swift
//  UPAPP
//
//  Created by Stephany H.M. on 26/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit

class busquedaViewController: UIViewController {
    
    @IBOutlet weak var txtAutor: UITextField!
    @IBOutlet weak var txtEditorial: UITextField!
    @IBOutlet weak var texEdicion: UITextField!
    @IBOutlet weak var lblDisp: UILabel!
    @IBOutlet weak var opcDisp: UISwitch!
    @IBOutlet weak var opcBusquedaA: UISwitch!
    
    @IBAction func opcBusqueda(_ sender: UISwitch) {
        if(opcBusquedaA.isOn){
            txtAutor.isHidden = false
            txtEditorial.isHidden = false
            lblDisp.isHidden = false
            opcDisp.isHidden = false
            texEdicion.isHidden = false
        }else{
            txtAutor.isHidden = true
            txtEditorial.isHidden = true
            lblDisp.isHidden = true
            opcDisp.isHidden = true
            texEdicion.isHidden = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
