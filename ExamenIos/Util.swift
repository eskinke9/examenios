//
//  Util.swift
//  ExamenIos
//
//  Created by Enrique on 22/12/21.
//

import Foundation
import UIKit
import CoreData
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class TapGesture {
    class func dissmissKey (view: UIView, onView: UIViewController){
        let tap = UITapGestureRecognizer(target: onView.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}

class ProgressLoading{
    func showSpinner(onView: UIView)-> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        } else {
            // Fallback on earlier versions
            ai = UIActivityIndicatorView.init()
        }
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    func removeSpinner(vSpinner : UIView) {
       DispatchQueue.main.async { vSpinner.removeFromSuperview()}
    }
}

class AlertString{
    class func alert(messageText: String, onView: UIViewController){
        let alert = UIAlertController(title: "Atención", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        onView.present(alert, animated: true, completion: nil)
    }
}

class postClass{
    var imageProfile: String = ""
    var nameProfile: String = ""
    var locationPost: String = ""
    var messagePost: String = ""
    var imagePost: String = ""
    var pricePost: String = ""
    
    init(imageProfile: String, nameProfile: String, locationPost: String, messagePost: String, imagePost: String, pricePost: String) {
        self.imageProfile = imageProfile
        self.nameProfile = nameProfile
        self.locationPost = locationPost
        self.imagePost = imagePost
        self.messagePost = messagePost
        self.pricePost = pricePost
    }
}

class messageClass{
    var imageProfile: String = ""
    var nameProfile: String = ""
    var message: String = ""
    var date: String = ""

    
    init(imageProfile: String, nameProfile: String, message: String, date: String) {
        self.imageProfile = imageProfile
        self.nameProfile = nameProfile
        self.message = message
        self.date = date

    }
}



class Welcome: Codable {
    let colors: [String]
    let questions: [Question]

    init(colors: [String], questions: [Question]) {
        self.colors = colors
        self.questions = questions
    }
}


class Question: Codable {
    let total: Int
    let text: String
    let chartData: [ChartData]

    init(total: Int, text: String, chartData: [ChartData]) {
        self.total = total
        self.text = text
        self.chartData = chartData
    }
}


class ChartData: Codable {
    let text: String
    let percetnage: Int

    init(text: String, percetnage: Int) {
        self.text = text
        self.percetnage = percetnage
    }
}

