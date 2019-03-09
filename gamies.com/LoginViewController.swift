//
//  LoginViewController.swift
//  gamies.com
//
//  Created by hanakawa kazuya on 2019/03/09.
//  Copyright © 2019 hanakawa kazuya. All rights reserved.
//

import UIKit
import NCMB
let user = NCMBUser()

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func LoginButtonTapped(_ sender: Any) {
        NCMBUser.logInWithUsername(inBackground:userEmailTextField.text, password: userPasswordTextField.text, block:{(user: NCMBUser!, error: NSError!) in
            if error != nil {
                // ログイン失敗時の処理
            }else{
                // ログイン成功時の処理
            }
            } as! NCMBUserResultBlock)
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
