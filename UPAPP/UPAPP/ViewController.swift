//
//  ViewController.swift
//  UPAPP
//  
//  Created by Edgardo Victorino Marin on 09/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var buscar_multas: UISearchBar!
    @IBOutlet weak var consulta_multas: UITableView!
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    var multas_lbl:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        for index in 1...50{
        
            handler = ref?.child("multa").child("150009/\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    print(value)
                }
                let descripcion = value?["descripcion"] as? String ?? ""
                let costo = value?["costo"] as? String ?? ""
                let estatus = value?["estatus"] as? String ?? ""
                let nombre_libro = value?["nombre_libro"] as? String ?? ""
                if descripcion != ""{
                    if estatus != "pendiente"{
                        self.multas_lbl.append(descripcion)
                    }
                    
                }
                self.consulta_multas?.reloadData()
            })
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return multas_lbl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let multa_celda = UITableViewCell(style: .default, reuseIdentifier: "multa_desc")
        multa_celda.textLabel?.text = multas_lbl[indexPath.row]
        multa_celda.contentView.backgroundColor = UIColor.white
        return multa_celda
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

