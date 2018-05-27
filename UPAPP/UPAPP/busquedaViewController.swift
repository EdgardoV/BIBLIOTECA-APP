//
//  busquedaViewController.swift
//  UPAPP
//
//  Created by Stephany H.M. on 26/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit

class busquedaViewController: UIViewController {
    
    @IBOutlet weak var txtNombre: UISearchBar!
    @IBOutlet weak var txtAutor: UITextField!
    @IBOutlet weak var txtEditorial: UITextField!
    @IBOutlet weak var texEdicion: UITextField!
    @IBOutlet weak var lblDisp: UILabel!
    @IBOutlet weak var opcDisp: UISwitch!
    @IBOutlet weak var opcBusquedaA: UISwitch!
    @IBOutlet weak var lblAlert1: UILabel!
    var Dispo = String()
    
    @IBAction func opcBusqueda(_ sender: UISwitch) {
        if(opcBusquedaA.isOn){
            txtAutor.isHidden = false
            txtEditorial.isHidden = false
            lblDisp.isHidden = false
            opcDisp.isHidden = false
            texEdicion.isHidden = false
            if(opcDisp.isOn){
                Dispo = "Si"
            }else{
                Dispo = "No"
            }
            
        }else{
            txtAutor.isHidden = true
            txtEditorial.isHidden = true
            lblDisp.isHidden = true
            opcDisp.isHidden = true
            texEdicion.isHidden = true
            
        }
    }
    @IBAction func btnBuscar(_ sender: Any) {
        if (txtNombre.text != "" || txtAutor.text != "" || txtEditorial.text != "" || texEdicion.text != ""){
            performSegue(withIdentifier: "Cbusqueda", sender: self)
        }else{
            lblAlert1.isHidden = false
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var resultBusqueda = segue.destination as! ResultBusViewController
        resultBusqueda.Nombre = txtNombre.text!
        resultBusqueda.Autor = txtAutor.text!
        resultBusqueda.Editorial = txtEditorial.text!
        resultBusqueda.Autor = texEdicion.text!
        resultBusqueda.Disponibe = Dispo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblAlert1.isHidden = true
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
