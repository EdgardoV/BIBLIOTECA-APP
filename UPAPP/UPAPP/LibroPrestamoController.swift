//
//  LibroPrestamoController.swift
//  UPAPP
//
//  Created by Edgardo Victorino Marin on 27/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseDatabase
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
    
    var libros_prestamo:[String] = []
    var nombre = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        diaprestamo_libro.isHidden = true
        entrega_libro.isHidden = true
        nombre_libro.isHidden = true
        autor_libro.isHidden = true
        editorial_libro.isHidden = true
        
        for index in 1...16{
            handler = ref?.child("libro").child("libro\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    let propietario = String(value?["propietario"] as? Int ?? 0)
                    print(propietario)
                    let nombre = value?["nombre"] as? String ?? ""
                    let estatus = value?["status"] as? String ?? ""
                    if propietario == "150794"{
                        if estatus == "prestamo"{
                            self.libros_prestamo.append(nombre)
                        }
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
        
        for index in 1...18{
            handler = ref?.child("libro").child("libro\(index)").observe(DataEventType.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                if value != nil{
                    let propietario = String(value?["propietario"] as? Int ?? 0)
                    print(propietario)
                    let nombre = value?["nombre"] as? String ?? ""
                    let fechaprestamo
                    let fechaentrega
                    
                    let estatus = value?["status"] as? String ?? ""
                    let isbn = value?["ISBN"] as? String ?? ""
                    if nombre == nombrelibro && propietario == "150794"{
                        if estatus == "prestamo"{
                            self.diaprestamo_libro.text =
                            self.entrega_libro.text =
                            self.nombre_libro.text =
                            self.autor_libro.text =
                            self.editorial_libro.text =
                            self.portada_libro.image = //#imageLiteral(resourceName: "libro1.jpg")
                        }
                    }
                    
                    
                }
                self.prestamo_libro?.reloadData()
            })
        }
        
    }
    

}
