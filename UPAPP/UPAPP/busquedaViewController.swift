//
//  busquedaViewController.swift
//  UPAPP
//
//  Created by Stephany H.M. on 26/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit

class busquedaViewController: UIViewController, UITextFieldDelegate , UISearchBarDelegate{
    
    
    @IBOutlet weak var txtNombre: UISearchBar!
    @IBOutlet weak var txtAutor: UISearchBar!
    @IBOutlet weak var txtEditorial: UISearchBar!
    @IBOutlet weak var texEdicion: UISearchBar!
    @IBOutlet weak var opcBusquedaA: UISwitch!
    @IBOutlet weak var lblAlert1: UILabel!
    @IBOutlet weak var busesp1: UILabel!
    @IBOutlet weak var busesp2: UILabel!
    var Nombre = String()
    var Autor = String()
    var Editorial = String ()
    var Edicion = String()
    var be:Int = 1
    
    @IBAction func opcBusqueda(_ sender: UISwitch) {
        if(opcBusquedaA.isOn){
            txtAutor.isHidden = false
            txtEditorial.isHidden = false
            texEdicion.isHidden = false
            be = 1
            
            
        }else{
            txtAutor.isHidden = true
            txtEditorial.isHidden = true
            texEdicion.isHidden = true
            be = 0
        }
    }
    @IBAction func btnBuscar(_ sender: Any) {
        
        if (be == 1){
            Nombre = txtNombre.text!
            Autor = txtAutor.text!
            Editorial = txtEditorial.text!
            Edicion = texEdicion.text!
            if(txtNombre.text != "" && txtAutor.text != "" && txtEditorial.text != "" && texEdicion.text != ""){
                performSegue(withIdentifier: "Cbusqueda", sender: self)
            }else{
                busesp1.isHidden = false
                busesp2.isHidden = false
            }
        }else if(be == 0){
            Nombre = txtNombre.text!
            if(txtNombre.text != ""){
                performSegue(withIdentifier: "Cbusqueda", sender: self)
            }else{
                lblAlert1.isHidden = false
            }
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let resultBusqueda = segue.destination as? ResultBusViewController {
            resultBusqueda.Nombre = Nombre
            resultBusqueda.Autor = Autor
            resultBusqueda.Editorial = Editorial
            resultBusqueda.Autor = Autor
            resultBusqueda.Edicion = Edicion
            resultBusqueda.be = be
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblAlert1.isHidden = true
        busesp1.isHidden = true
        busesp2.isHidden = true
        self.txtAutor.delegate = self
        self.txtEditorial.delegate = self
        self.texEdicion.delegate = self
        self.txtNombre.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        txtAutor.endEditing(true)
        txtEditorial.endEditing(true)
        texEdicion.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        txtNombre.endEditing(true)
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
