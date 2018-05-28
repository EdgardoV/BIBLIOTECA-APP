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
    var Disponibe = String()
    var consulta:[String] = []
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    @IBOutlet weak var lbnombre: UILabel!
    @IBOutlet weak var lbAutor: UILabel!
    @IBOutlet weak var lbEditorial: UILabel!
    @IBOutlet weak var lbEdicion: UILabel!
    @IBOutlet weak var lbDispo: UILabel!
    @IBOutlet weak var Tabla: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(consulta.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = consulta[indexPath.row]
        return(cell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if(be == 1){
            if(Nombre != "" && Autor != "" && Editorial != "" && Edicion != "" && Disponibe == "Si"){
                
            }else if(Nombre != "" && Autor != "" && Editorial != "" && Edicion != "" && Disponibe == "No"){
                
            }
        }else if(be == 0){
            handler = ref?.child("libro").child(Nombre).observe(DataEventType.value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                    if(value != nil){
                        self.consulta.append(value?["nombre"] as? String ?? "")
                        self.Tabla.reloadData()
                    }
                
            })
        }
        
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
