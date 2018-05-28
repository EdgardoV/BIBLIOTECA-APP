//
//  histViewController.swift
//  UPAPP
//
//  Created by Stephany H.M. on 28/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit
import FirebaseDatabase
class histViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    
    @IBOutlet weak var Tabla: UITableView!
    var consulta:[String] = []
    var handler:DatabaseHandle?
    var ref: DatabaseReference?
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        handler = ref?.child("historial").child("150009").observe(.childAdded, with: { (snapshot) in
            //let value = snapshot.value as? NSDictionary
            if let item = snapshot.value as? String{
                self.consulta.append(item)
                self.Tabla.reloadData()
                
            }
            
        })
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
