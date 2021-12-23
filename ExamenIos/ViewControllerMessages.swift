//
//  ViewControllerMessages.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import UIKit

class ViewControllerMessages: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let devCourses = [("Laravel"),("Swift"),("Apple"),("Window"),("Android")]
    var listMessahges:[messageClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // self.tableView.rowHeight = 44.0
        listMessahges = createList()
    }
    
    func createList() -> Array<messageClass> {
        var list: [messageClass] = []
        list.append(messageClass(imageProfile: "person1", nameProfile: "Nombre 1", message: "Mensaje de prueba", date: "04:35 pm"))
        list.append(messageClass(imageProfile: "person1", nameProfile: "Nombre 2", message: "Mensaje de prueba", date: "04:35 pm"))
        list.append(messageClass(imageProfile: "person1", nameProfile: "Nombre 3", message: "Mensaje de prueba", date: "04:35 pm"))
        list.append(messageClass(imageProfile: "person1", nameProfile: "Nombre 4", message: "Mensaje de prueba", date: "04:35 pm"))
        list.append(messageClass(imageProfile: "person1", nameProfile: "Nombre 5", message: "Mensaje de prueba", date: "04:35 pm"))
        list.append(messageClass(imageProfile: "person1", nameProfile: "Nombre 6", message: "Mensaje de prueba", date: "04:35 pm"))

        return list
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessahges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cellM", for: indexPath) as! TableViewCellMessage


        cell.nameMessage.text = listMessahges[indexPath.row].nameProfile
        cell.imageMessage.image = UIImage(named: listMessahges[indexPath.row].imageProfile)
        cell.messageMessage.text = listMessahges[indexPath.row].message
        cell.dateMessage.text = listMessahges[indexPath.row].date
        
        cell.imageMessage.layer.cornerRadius = cell.imageMessage.frame.size.width/2
        cell.imageMessage.clipsToBounds = true

        //cell.photo.image=Images

        return cell
    }
    


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
