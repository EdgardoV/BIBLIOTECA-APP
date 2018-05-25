//
//  ViewController.swift
//  UPAPP
//
//  Created by Edgardo Victorino Marin on 09/05/18.
//  Copyright © 2018 Edgardo Victorino Marin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return multas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = multas_list.dequeueReusableCell(withIdentifier: "multa")
        celda?.textLabel?.text = multas[0].capitalized
        return celda!
    }
    

    var multas = [String]()
    var i = 0
    @IBOutlet weak var multas_list: UITableView!
    @IBOutlet weak var buscador: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        //multas.append("Nombre del libro de la multa 1")
        multas.append("Nombre del libro de la multa 2")
        multas.append("Nombre del libro de la multa 3")
        multas.append("Nombre del libro de la multa 4")
        multas_list?.delegate = self
        multas_list?.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

