//
//  ProfileViewController.swift
//  gamies.com
//
//  Created by Akira Norose on 2019/03/10.
//  Copyright © 2019 hanakawa kazuya. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseUI
import FirebaseStorage

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    // 選択した写真を取得
    image = info[.originalImage] as? UIImage
    // ImageViewに表示する
    self.imageView.image = image
    // 写真を選ぶビューを消す
    self.dismiss(animated: true)
    }
    
    let user = Auth.auth().currentUser
    var ref: DatabaseReference!
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var image: UIImage!
    
    @IBOutlet weak var gamename: UILabel!
    var GameName = UserDefaults.standard.object(forKey: "GameName") as! String
    let gameID =  UserDefaults.standard.object(forKey: "gameID") as! String

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBAction func btnReset(_ sender: Any) {
        self.imageView.image = UIImage(named: "defaultimage.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GameChooseで選択したゲーム名をs受け取る
        gamename.text = GameName
        imageView.image = UIImage(named: "defaultimage.png")
        
        //現在ログイン中のユーザーのuserNameを表示
        username.text = user?.displayName
        // Do any additional setup after loading the view, typically from a nib.
        }
    
    
    
    @IBAction func btnSelect(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // ライブラリから選ぶ
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            // 表示
            self.present(pickerView, animated: true)
            
        }
    }
    
    //

    @IBAction func btnUpload(_ sender: Any) {
        
        let UID = user?.uid
        
        
        let storageref = storage.reference()
        //userID下のGameNameに画像を保存
        let usericonref = storageref.child(UID!).child("\(gameID).jpeg")
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let usericonimage = image?.jpegData(compressionQuality: 0.2)
        usericonref.putData(usericonimage!, metadata: metadata){metadata, error in
            if let error = error{
                print(error)
            }else{
                print("usericonimage saved")
            }
        }
    }
    

    
    @IBOutlet weak var NicknameTextField: UITextField!
    
    
    @IBOutlet weak var IntroduceTextField: UITextField!
    
    
    @IBAction func DecideButtonTapped(_ sender: Any) {
      
       /*    db.collection("users").document((user?.uid)!).collection("Games").document(GameName).setData([
            "nickname": NicknameTextField.text!,
            "introduce": IntroduceTextField.text!
            ])
         */
        let gameUserRef =  db.collection(gameID).document((user?.uid)!)
        gameUserRef.setData([
            "nickname": NicknameTextField.text!,
            "introduce": IntroduceTextField.text!
            ])
        
        db.collection("users").document(user!.uid).collection("Games").document(gameID).setData ([
            "ref": gameUserRef,
            "title": GameName
            ])
        
        print("Profile Saved")
        
        
        self.performSegue(withIdentifier: "ToMainView", sender: (Any).self)

        
        
        }
}
    







