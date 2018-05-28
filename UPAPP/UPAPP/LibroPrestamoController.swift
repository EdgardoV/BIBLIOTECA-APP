//
//  LibroPrestamoController.swift
//  UPAPP
//
//  Created by Edgardo Victorino Marin on 27/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import UserNotifications

class LibroPrestamoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    
    
    @IBOutlet weak var prestamo_libro: UITableView!
    @IBOutlet weak var diaprestamo_libro: UILabel!
    @IBOutlet weak var entrega_libro: UILabel!
    @IBOutlet weak var nombre_libro: UILabel!
    @IBOutlet weak var autor_libro: UILabel!
    @IBOutlet weak var editorial_libro: UILabel!
    @IBOutlet weak var portada_libro: UIImageView!
    @IBOutlet weak var edicion_libro: UILabel!
    
    let date = Date()
    let formatter = DateFormatter()
    
    var libros_prestamo:[String] = []
    var nombre = String()
    
    let usuario = (Auth.auth().currentUser?.email)!
    var user = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: self.date)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow, error in
            
        })
        
        ref = Database.database().reference()
        
        let str = self.usuario
        let index_0 = str.index(str.startIndex, offsetBy: 0)
        let index_1 = str.index(str.startIndex, offsetBy: 1)
        let index_2 = str.index(str.startIndex, offsetBy: 2)
        let index_3 = str.index(str.startIndex, offsetBy: 3)
        let index_4 = str.index(str.startIndex, offsetBy: 4)
        let index_5 = str.index(str.startIndex, offsetBy: 5)
        self.user = "\(str[index_0])\(str[index_1])\(str[index_2])\(str[index_3])\(str[index_4])\(str[index_5])"
        
        diaprestamo_libro.isHidden = true
        entrega_libro.isHidden = true
        nombre_libro.isHidden = true
        autor_libro.isHidden = true
        editorial_libro.isHidden = true
        edicion_libro.isHidden = true
        for index in 1...18{
            handler = ref?.child("libro").child("libro\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    let propietario = String(value?["propietario"] as? Int ?? 0)
                    print(propietario)
                    let nombre = value?["nombre"] as? String ?? ""
                    let estatus = value?["status"] as? String ?? ""
                    let fechaentrega = value?["Fecha_de_entrega"] as? String ?? ""
                    if propietario == self.user{
                        if estatus == "prestamo"{
                            self.libros_prestamo.append(nombre)
                        }
                    }
                    
                    print(result)
                    if  fechaentrega < result {
                        print("Multa")
                    }
                    
                    
                }
                self.prestamo_libro?.reloadData()
            })
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libros_prestamo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
                                                                                                                                                                          let libro_celda = UITableViewCell(style: .default, reuseIdentifier: "libro_prestamo")
        libro_celda.textLabel?.text = libros_prestamo[indexPath.row]
        libro_celda.textLabel?.textColor = UIColor.white
        libro_celda.contentView.backgroundColor = UIColor(red: (42/255.0), green: (88/255.0), blue: (128/255.0), alpha: 1.0)
        return libro_celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ref = Database.database().reference()
        
        let libro_celda = prestamo_libro.cellForRow(at: indexPath)
        let valor = libro_celda?.textLabel?.text
        let nombrelibro = valor!
        print(nombrelibro)
        for index in 1...18{
            handler = ref?.child("libro").child("libro\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    let propietario = String(value?["propietario"] as? Int ?? 0)
                    print(propietario)
                    let nombre = value?["nombre"] as? String ?? ""
                    let fechaprestamo = value?["Fecha_de_prestamo"] as? String ?? ""
                    let fechaentrega = value?["Fecha_de_entrega"] as? String ?? ""
                    let autor = value?["autor"] as? String ?? ""
                    let edicion = String(value?["edicion"] as? Int ?? 0)
                    let editorial = value?["editorial"] as? String ?? ""
                    let estatus = value?["status"] as? String ?? ""
                    if nombre == nombrelibro && propietario == self.user{
                        if estatus == "prestamo"{
                            self.diaprestamo_libro.isHidden = false
                            self.entrega_libro.isHidden = false
                            self.nombre_libro.isHidden = false
                            self.autor_libro.isHidden = false
                            self.editorial_libro.isHidden = false
                            self.edicion_libro.isHidden = false
                            
                            self.diaprestamo_libro.text = fechaprestamo
                            self.entrega_libro.text = fechaentrega
                            self.nombre_libro.text = nombre
                            self.autor_libro.text = autor
                            self.editorial_libro.text = editorial
                            self.edicion_libro.text = edicion
                            self.portada_libro.image = #imageLiteral(resourceName: "libro\(arc4random_uniform(5) + 1).jpg")
                        }
                    }
                    
                    
                }
                self.prestamo_libro?.reloadData()
            })
        }
        
    }
    

}
