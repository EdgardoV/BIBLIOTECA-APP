//
//  ResultBusViewController.swift
//  UPAPP
//
//  Created by Stephany H.M. on 26/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseDatabase
class ResultBusViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var be = Int()
    var Nombre = String()
    var Autor = String()
    var Editorial = String()
    var Edicion = String()
    var consulta:[String] = []
    var librosMostrados:[String] = []
    var myIndex = 0
    var contador = Int()
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    @IBOutlet weak var lbnombre: UILabel!
    @IBOutlet weak var lbAutor: UILabel!
    @IBOutlet weak var lbEditorial: UILabel!
    @IBOutlet weak var lbEdicion: UILabel!
    @IBOutlet weak var lbDispo: UILabel!
    @IBOutlet weak var Tabla: UITableView!
    @IBOutlet weak var lbNotfound: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(consulta.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = consulta[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.contentView.backgroundColor = UIColor(red: (42/255.0), green: (88/255.0), blue: (128/255.0), alpha: 1.0)
        Tabla.backgroundColor = UIColor(red: (42/255.0), green: (88/255.0), blue: (128/255.0), alpha: 1.0)
        return(cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lbnombre.isHidden = false
        lbAutor.isHidden = false
        lbEdicion.isHidden = false
        lbEditorial.isHidden = false
        lbDispo.isHidden = false
        self.myIndex = indexPath.row
        handler = ref?.child("libro").child(librosMostrados[myIndex]).observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if(value != nil){
                self.lbnombre.text = value?["nombre"] as? String ?? ""
                self.lbAutor.text = value?["autor"] as? String ?? ""
                self.lbEditorial.text = value?["editorial"] as? String ?? ""
                self.lbEdicion.text = String(value?["edicion"] as? Int ?? 0)
                self.lbDispo.text = value?["status"] as? String ?? ""
            }
            
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if(be == 1){
            for index in 1...18{
                handler = ref?.child("libro").child("libro\(index)").observe(DataEventType.value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    if(value != nil){
                        if(value?["nombre"] as? String ?? "" == self.Nombre && value?["autor"] as? String ?? "" == self.Autor && value?["editorial"] as? String ?? "" == self.Editorial && value?["edicion"] as? Int ?? 0 == Int(self.Edicion)){
                            self.consulta.append(value?["nombre"] as? String ?? "")
                            self.librosMostrados.append("libro\(index)")
                            self.contador = self.contador + 1
                            self.Tabla.reloadData()
                            self.Tabla.isHidden = false
                            self.lbNotfound.isHidden = true
                        }
                    }
                    
                })
            }
        }else if(be == 0){
            for index in 1...18{
                handler = ref?.child("libro").child("libro\(index)").observe(DataEventType.value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    if(value != nil){
                        if(value?["nombre"] as? String ?? "" == self.Nombre){
                            self.consulta.append(value?["nombre"] as? String ?? "")
                            self.librosMostrados.append("libro\(index)")
                            self.contador = self.contador + 1
                            self.Tabla.reloadData()
                            self.Tabla.isHidden = false
                            self.lbNotfound.isHidden = true
                        }
                    }
                    
                })
            }
            //self.lbEditorial.text = String(self.contador)
            if(self.contador == 0){
                Tabla.isHidden = true
                lbNotfound.isHidden = false
            }else{
                
            }
            
        }
        
        lbnombre.isHidden = true
        lbAutor.isHidden = true
        lbEdicion.isHidden = true
        lbEditorial.isHidden = true
        lbDispo.isHidden = true
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
