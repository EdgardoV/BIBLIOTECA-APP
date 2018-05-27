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
        
        handler = ref?.child("multa/150009_001").observe(.childAdded, with: {(snapshot) in
            if let item = snapshot.value!["descripcion"] as? [String : AnyObject]
            {
                self.multas_lbl.append(item)
                self.consulta_multas?.reloadData()
            }
        })
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

