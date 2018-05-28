//
//  ViewController.swift
//  UPAPP
//  
//  Created by Edgardo Victorino Marin on 09/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var buscar_multas: UISearchBar!
    @IBOutlet weak var consulta_multas: UITableView!
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    var multas_lbl:[String] = []
    var indice = 0
    let usuario = (Auth.auth().currentUser?.email)!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        let str = self.usuario
        let index_0 = str.index(str.startIndex, offsetBy: 0)
        let index_1 = str.index(str.startIndex, offsetBy: 1)
        let index_2 = str.index(str.startIndex, offsetBy: 2)
        let index_3 = str.index(str.startIndex, offsetBy: 3)
        let index_4 = str.index(str.startIndex, offsetBy: 4)
        let index_5 = str.index(str.startIndex, offsetBy: 5)
        let user = "\(str[index_0])\(str[index_1])\(str[index_2])\(str[index_3])\(str[index_4])\(str[index_5])"
        
        for index in 0...50{
            handler = ref?.child("multa").child("\(user)/\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    let descripcion = value?["descripcion"] as? String ?? ""
                    let costo = value?["costo"] as? String ?? ""
                    let estatus = value?["estatus"] as? String ?? ""
                    let nombre_libro = value?["nombre_libro"] as? String ?? ""
                    if descripcion != ""{
                        if estatus == "pendiente"{
                            self.multas_lbl.append(descripcion)
                        }
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
        multa_celda.textLabel?.textColor = UIColor.white
        multa_celda.contentView.backgroundColor = UIColor(red: (42/255.0), green: (88/255.0), blue: (128/255.0), alpha: 1.0)
        return multa_celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indice = indexPath.row + 1
        performSegue(withIdentifier: "MostrarDetalle", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destino = segue.destination as? MultaDetalleViewController{
            destino.indice = self.indice
        }
    }


}

