//
//  ViewControllerRegister.swift
//  ExamenIos
//
//  Created by Enrique on 23/12/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage

class ViewControllerRegister: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var imagaProfile: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    var vSpinner : UIView?
    var imagePicker: UIImagePickerController!

    enum ImageSource {
           case photoLibrary
           case camera
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TapGesture.dissmissKey(view: view, onView: self.self)
        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imagaProfile.isUserInteractionEnabled = true
        imagaProfile.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewControllerRegister.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
           selectImageFrom(.photoLibrary)
           return
       }
       selectImageFrom(.camera)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func registerClick(){
        let name = nameTextField.text!
        let email = emailTextField.text!
        let pass = passwordTextField.text!
        let confirmPass = confirmPasswordTextField.text!

        if name.isEmpty || email.isEmpty || pass.isEmpty  || confirmPass.isEmpty  {
            AlertString.alert(messageText: "Los datos no pueden estar vacios", onView: self)
        }else{
            if Connectivity.isConnectedToInternet(){
                if(isValidEmail(email)){
                    if(pass == confirmPass){
                        if(pass.count >= 6){
                            vSpinner = ProgressLoading().showSpinner(onView: self.view)

                            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                                if(authResult != nil){
                                    ProgressLoading().removeSpinner(vSpinner: self.vSpinner!)
                                    self.alertClose(messageText: "Usuario registrado correctamente")
                                }else{
                                    AlertString.alert(messageText: "No se pude registar el usuario", onView: self)
                                }
                            }
                        }else{
                            AlertString.alert(messageText: "La contraseña debe contener al menos 6 caracteres", onView: self)
                        }
                    }else{
                        AlertString.alert(messageText: "Las contraseñas no son iguales", onView: self)
                    }
                }else{
                    AlertString.alert(messageText: "Correo no válido", onView: self)
                }
            }else{
                AlertString.alert(messageText: "Verifica tu conexión a internet", onView: self)
            }
        }
    }
    

    @IBAction func doRegister(_ sender: Any) {
        registerClick()
    }
    
    func alertClose(messageText: String){
          let alert = UIAlertController(title: "Atención", message: messageText, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: closeView))
          self.present(alert, animated: true, completion: nil)
    }
    
    func closeView(alert: UIAlertAction!) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func selectImageFrom(_ source: ImageSource){
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            switch source {
            case .camera:
                imagePicker.sourceType = .camera
            case .photoLibrary:
                imagePicker.sourceType = .photoLibrary
            }
            present(imagePicker, animated: true, completion: nil)
        }


        func showAlertWith(title: String, message: String){
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    
        func uploadFile(fileUrl: URL) {
          do {
              let fileExtension = fileUrl.pathExtension
              let fileName = "demoImageFileName.\(fileExtension)"
              let storageReference = Storage.storage().reference().child(fileName)
              let uploadTask = storageReference.putFile(from: fileUrl, metadata: nil) { metadata, error in
                guard let metadata = metadata else {
                  // Uh-oh, an error occurred!
                  return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                // You can also access to download URL after upload.
                storageReference.downloadURL { (url, error) in
                  guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                  }
                }
              }
          } catch {
            print("Error on extracting data from url: \(error.localizedDescription)")
          }
        }

}

extension ViewControllerRegister: UIImagePickerControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imagaProfile.image = selectedImage
        
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
               let imgName = imgUrl.lastPathComponent
               let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
               let localPath = documentDirectory?.appending(imgName)

                let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                let data = image.pngData()! as NSData
               data.write(toFile: localPath!, atomically: true)
               //let imageData = NSData(contentsOfFile: localPath!)!
               let photoURL = URL.init(fileURLWithPath: localPath!)//NSURL(fileURLWithPath: localPath!)
               print(photoURL)

        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
