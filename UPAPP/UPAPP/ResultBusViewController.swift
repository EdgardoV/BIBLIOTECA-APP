//
//  ResultBusViewController.swift
//  UPAPP
//
//  Created by Stephany H.M. on 26/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import Firebase
class ResultBusViewController: UIViewController {
    var Nombre = String()
    var Autor = String()
    var Editorial = String()
    var Edicion = String()
    var Disponibe = String()
    @IBOutlet weak var lbnombre: UILabel!
    @IBOutlet weak var lbAutor: UILabel!
    @IBOutlet weak var lbEditorial: UILabel!
    @IBOutlet weak var lbEdicion: UILabel!
    @IBOutlet weak var lbDispo: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbnombre.text = Nombre
        lbAutor.text = Autor
        lbEditorial.text = Editorial
        lbEdicion.text = Edicion
        lbDispo.text = Disponibe
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
