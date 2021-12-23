//
//  ViewController.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import UIKit
import Firebase

class ViewControllerLogin: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var viewRed: UIView!
    @IBOutlet weak var viewYellow: UIView!
    @IBOutlet weak var emailUITextField: UITextField!
    @IBOutlet weak var passwordUITextField: UITextField!
    var vSpinner : UIView?
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TapGesture.dissmissKey(view: view, onView: self.self)
        viewRed.layer.cornerRadius = viewRed.layer.bounds.width / 2
        viewRed.clipsToBounds = true
        
        viewYellow.layer.cornerRadius = viewYellow.layer.bounds.width / 2
        viewYellow.clipsToBounds = true
        
        emailUITextField.delegate = self
        passwordUITextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewControllerLogin.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        if textField.tag == 1{
            passwordUITextField.becomeFirstResponder()
        }else if textField.tag == 2 {
            passwordUITextField.resignFirstResponder()
            loginClick()
        }
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func loginClick(){
        let user = emailUITextField.text!
        let pass = passwordUITextField.text!
        if user.isEmpty || pass.isEmpty {
            AlertString.alert(messageText: "El usuario o contraseña estan vacios", onView: self)
        }else{
            if Connectivity.isConnectedToInternet(){

                if(isValidEmail(user)){
                    vSpinner = ProgressLoading().showSpinner(onView: self.view)

                    login(userLogin: user, passLogin: pass)
                }else{
                    AlertString.alert(messageText: "Correo no válido", onView: self)
                }
            }else{
                AlertString.alert(messageText: "Verifica tu conexión a internet", onView: self)
            }
        }
    }
    
    func login (userLogin: String, passLogin: String){
        Auth.auth().signIn(withEmail: userLogin, password: passLogin) { authDataResult, error in
            if(authDataResult != nil){
                ProgressLoading().removeSpinner(vSpinner: self.vSpinner!)

                 let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let mainViewController = storyBoard.instantiateViewController(withIdentifier: "tabBarView") as! ViewControllerTabBar
                 mainViewController.modalPresentationStyle = .fullScreen
                 self.present(mainViewController, animated: true, completion: nil)
            }else{
                AlertString.alert(messageText: "Usuario no registrado", onView: self)
            }
        }
    }
    @IBAction func doLogin(_ sender: Any) {
        loginClick()
    }
}

