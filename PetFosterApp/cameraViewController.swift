//
//  cameraViewController.swift
//  PetFosterApp
//
//  Created by Alexis Sanchez on 4/15/22.
//
import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var speciesPicker: UIPickerView!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    var speciesData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speciesData = ["Dog", "Cat", "Rabbit"]
        self.speciesPicker.delegate = self
        self.speciesPicker.dataSource = self
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill:size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Listing")

        post["name"] = commentField.text!
        post["author"] = PFUser.current()!
        post["age"] = Int(ageField.text!)
        post["description"] = descField.text!
        post["species"] = speciesData[speciesPicker.selectedRow(inComponent: 0)]
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)

        post["image"] = file

        post.saveInBackground(){(success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return speciesData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return speciesData[row]
    }

   
    
}
