//
//  ViewControllerNotification.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import UIKit

class ViewControllerNotification: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var listNotification:[messageClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listNotification = createList()
    }
    
    func createList() -> Array<messageClass> {
        var list: [messageClass] = []
        list.append(messageClass(imageProfile: "person1", nameProfile: "Alex Edward Martinez", message: "Mensaje de prueba Mensaje de prueba Mensaje de prueba Mensaje de prueba Mensaje de prueba Mensaje de prueba ", date: "04:35 pm"))
        list.append(messageClass(imageProfile: "corazon", nameProfile: "Amber Byrd", message: "", date: "04:35 pm"))


        return list
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "CellN", for: indexPath) as! TableViewCellNotifications


        cell.nameNotification.text = listNotification[indexPath.row].nameProfile
        cell.imageNotification.image = UIImage(named: listNotification[indexPath.row].imageProfile)
        cell.dateNotification.text = listNotification[indexPath.row].date
        cell.messageNotification.text = listNotification[indexPath.row].message
        cell.imageNotification.layer.cornerRadius = cell.imageNotification.frame.size.width/2
        cell.imageNotification.clipsToBounds = true

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
