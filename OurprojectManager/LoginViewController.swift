//
//  LoginViewController.swift
//  OurprojectManager
//
//  Created by 陳永展 on 2019/5/29.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit
import Firebase
var user : User?

class LoginViewController: UIViewController {
    @IBOutlet weak var inputAccount: UITextField!
    
    @IBOutlet weak var inputPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func checkaccount(){
        //建立儲藏庫實體
        let db = Firestore.firestore()
        let inaccount = inputAccount?.text
        let inpassword = inputPassword?.text
        
        //利用 whereField 設定 search 的條件
        //使用 whereField 將.getDocuments與 firebase上的帳號密碼比對
        db.collection("註冊").whereField("account", isEqualTo: inaccount).whereField("password", isEqualTo: inpassword).getDocuments{(querySnapshot, error) in
        //先判定從firebase上.getDocuments的數量不等於0時（就是符合且有取得資料時）執行大括號內performSegue
            if  querySnapshot?.documents.count != 0 {
                self.performSegue(withIdentifier: "Login", sender: self)
                }else{
           //如果沒有成功則跳出錯誤訊息
                let alertcontroller = UIAlertController(title: nil, message: "輸入錯誤", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alertcontroller.addAction(ok)
                self.present(alertcontroller, animated: true, completion: nil)
            }
        }
    }

    
        
        
    
    @IBAction func clickLogin(_ sender: Any) {
        //如果帳號及密碼都有輸入進行大括號呼叫checkaccount()進行後續判定
        if inputAccount.text! != "" && inputPassword.text! != ""  {
            checkaccount()
        }else if inputAccount.text! != "" {
        //如果帳號沒輸入
            let alertcontroller = UIAlertController(title: "錯誤", message: "沒有輸入密碼", preferredStyle: .alert)
            let cannel = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            alertcontroller.addAction(cannel)
            self.present(alertcontroller, animated: true, completion: nil)
        } else if inputPassword.text != ""{
        //如果密碼沒輸入
            let alertcontroller = UIAlertController(title: "錯誤", message: "沒有輸入帳號", preferredStyle: .alert)
            let cannel = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            alertcontroller.addAction(cannel)
            self.present(alertcontroller, animated: true, completion: nil)
        }else {
        //如果帳號及密碼都沒輸入
            let alertcontroller = UIAlertController(title: "錯誤", message: "沒有輸入帳號及密碼", preferredStyle: .alert)
            let cannel = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            alertcontroller.addAction(cannel)
            self.present(alertcontroller, animated: true, completion: nil)
        }
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //    }
}
