//
//  LoginViewController.swift
//  NewsReader_Day6
//
//  Created by 田中陽子 on 2019/10/08.
//  Copyright © 2019 Yoko Tanaka. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    var activityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTappedBtn(_ sender: Any) {
        guard let email = emailTextField.text,
            let passward = passTextField.text else{ return }
        if email.isEmpty{
            self.singleAlert(title: "エラーです", message:"メールアドレスを入力してください" )
            return
        }
        if passward.isEmpty{
            self.singleAlert(title: "エラーです", message: "パスワードを入力してください")
            return
        }
        self.emailSignUp(email: email, password: passward)
    }
    
    
    @IBAction func signInTappedBtn(_ sender: Any) {
        guard let email = emailTextField.text,
            let passward = passTextField.text else{ return }
        if email.isEmpty{
            self.singleAlert(title: "エラーです", message:"メールアドレスを入力してください" )
            return
        }
        if passward.isEmpty{
            self.singleAlert(title: "エラーです", message: "パスワードを入力してください")
            return
        }
        self.emailSignIn(email: email, password: passward)
    }
    
    func emailSignUp(email:String,password:String){
    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error{
                print("登録失敗")
                self.signUpErrAlert(err)
            }else{
                print("登録成功")
                self.presentTaskList()
            }
        }
        
    }
    func emailSignIn(email:String,password:String){
    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let err = error{
                print("登録失敗")
                self.signInErrAlert(err)
            }else{
                print("登録成功")
                self.presentTaskList()
            }
        }
        
    }
    
    
    //Firebaseからエラーコードを取得し、「イーナム」で定義されたパターンをメッセージにセット
    func signUpErrAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .invalidEmail:      message =  "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse: message = "既に登録されているメールアドレスです"
            case .weakPassword:      message = "パスワードは６文字以上で入力してください"
            default:                 message = "エラー: \(error.localizedDescription)"
            }
            self.singleAlert(title: "登録できません", message: message)
        }
    }
    
    func signInErrAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .userNotFound:  message = "アカウントが見つかりませんでした"
            case .wrongPassword: message = "パスワードを確認してください"
            case .userDisabled:  message = "アカウントが無効になっています"
            case .invalidEmail:  message = "Eメールが無効な形式です"
            default:             message = "エラー: \(error.localizedDescription)"
            }
            self.singleAlert(title: "ログインできません", message: message)
        }
    }
    
    func presentTaskList(){
        let mailSB = UIStoryboard(name: "Main", bundle: nil)
        let taskNavi = mailSB.instantiateViewController(withIdentifier: "NavigationController")
        self.present(taskNavi,animated: true,completion: nil)
        
    }

}
