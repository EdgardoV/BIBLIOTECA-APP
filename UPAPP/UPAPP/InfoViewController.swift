//
//  InfoViewController.swift
//  UPAPP
//
//  Created by Edgardo Victorino Marin on 28/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class InfoViewController: UIViewController {
    
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    
    @IBOutlet weak var nombre_lbl: UILabel!
    @IBOutlet weak var matricula_lbl: UILabel!
    @IBOutlet weak var correo_lbl: UILabel!
    @IBOutlet weak var carrera_lbl: UILabel!
    @IBOutlet weak var semestre_lbl: UILabel!
    @IBOutlet weak var libros_lbl: UILabel!
    @IBOutlet weak var multas_lbl: UILabel!
    
    let usuario = (Auth.auth().currentUser?.email)!
    
    @IBAction func action(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = self.usuario
        let index_0 = str.index(str.startIndex, offsetBy: 0)
        let index_1 = str.index(str.startIndex, offsetBy: 1)
        let index_2 = str.index(str.startIndex, offsetBy: 2)
        let index_3 = str.index(str.startIndex, offsetBy: 3)
        let index_4 = str.index(str.startIndex, offsetBy: 4)
        let index_5 = str.index(str.startIndex, offsetBy: 5)
        let user = "\(str[index_0])\(str[index_1])\(str[index_2])\(str[index_3])\(str[index_4])\(str[index_5])"
    
        
        ref = Database.database().reference()
        
        handler = ref?.child("usuario/\(user)").observe(DataEventType.value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            if value != nil{
                let nombre = value?["nombre"] as? String ?? ""
                let matricula = value?["matricula"] as? Int ?? 0
                let correo = self.usuario
                let carrera = value?["carrera"] as? String ?? ""
                let semestre = String(value?["semestre"] as? Int ?? 0)
                
                self.nombre_lbl.text = nombre
                self.matricula_lbl.text = String(matricula)
                self.correo_lbl.text = correo
                self.carrera_lbl.text = carrera
                self.semestre_lbl.text = "Semestre \(semestre)"
                self.getlibros(usuario: user)
                self.getmultas(usuario: user)
                
            }
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getmultas(usuario:String){
        print("Usuario: \(usuario)")
        var i = 0
        for index in 1...49{
            
            handler = ref?.child("multa").child("\(usuario)/\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    print(value)
                    let estatus = value?["estatus"] as? String ?? ""
                    print(estatus)
                    if estatus == "pendiente" {
                        print("Aumenta multas")
                       i += 1
                        print("Indice multas \(i)")
                        self.multas_lbl.text = String(i)
                    }
                }
                
            })
        }
        
    }
    
    func getlibros(usuario:String) {
        print("Usuario: \(usuario)")
        var indice = 0
        for index in 1...18{
            handler = ref?.child("libro").child("libro\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    let propietario = String(value?["propietario"] as? Int ?? 0)
                    print("Propietario: \(propietario)")
                    let estatus = value?["status"] as? String ?? ""
                    if propietario == usuario{
                        if estatus == "prestamo"{
                            print("Aumenta libros")
                            indice += 1
                            print("Indice libros \(indice)")
                            self.libros_lbl.text = String(indice)
                        }
                    }
                    
                    
                }
            })
        }
        
        
    }
    


}
