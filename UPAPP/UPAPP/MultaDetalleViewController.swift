//
//  MultaDetalleViewController.swift
//  
//
//  Created by Edgardo Victorino Marin on 27/05/18.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class MultaDetalleViewController: UIViewController {
    @IBOutlet weak var fecha_lbl: UILabel!
    @IBOutlet weak var nombre_lbl: UILabel!
    @IBOutlet weak var costo_lbl: UILabel!
    
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    
    let usuario = (Auth.auth().currentUser?.email)!
    
    var multas_desc = [
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ["","","","",""],
        ]
    
    var indice = Int()
    
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
        
        for index in 1...49{
            
            handler = ref?.child("multa").child("\(user)/\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    let descripcion = value?["descripcion"] as? String ?? ""
                    let fecha = value?["fecha"] as? String ?? ""
                    let costo = value?["costo"] as? Double ?? 0
                    let estatus = value?["estatus"] as? String ?? ""
                    let nombre_libro = value?["libro"] as? String ?? ""
                    if estatus == "pendiente" {
                        print("OKOK")
                        self.multas_desc[index][0] = descripcion
                        self.multas_desc[index][1] = String(costo)
                        self.multas_desc[index][2] = estatus
                        self.multas_desc[index][3] = nombre_libro
                        self.multas_desc[index][4] = fecha
                        print("index: \(index) indice: \(self.indice)")
                        
                        print("\(self.multas_desc[index][0]) \(self.multas_desc[index][1]) \(self.multas_desc[index][2]) \(self.multas_desc[index][3]) \(self.multas_desc[index][4])")
                        if index == self.indice {
                            self.fecha_lbl.text = self.multas_desc[self.indice][4]
                            self.nombre_lbl.text = self.multas_desc[self.indice][3]
                            self.costo_lbl.text = self.multas_desc[self.indice][1]
                        }
                    }
                }
                
            })
        }
        

    }



}
