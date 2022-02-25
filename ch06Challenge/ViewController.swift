//
//  ViewController.swift
//  ch06Challenge
//
//  Created by 김규리 on 2022/01/18.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime) // 타이머가 구동되면 살행할 함수
    let interval = 1.0 // 타이머 간격 1초
    var count = 0
    var alarmTime: String? // 선택한 시간
    var alertFlag = false
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 타이머 설정
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender
        
        let formatter = DateFormatter() // 날짜를 출력하기 위한 클래스 상수 선언
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE" // formatter의 속성 설정
        // lblPickerTime에 삽입
        lblPickerTime.text = "선택시간: " + formatter.string(from: datePickerView.date)
        
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
    }
    
    // 현재시간
    @objc func updateTime() {
        let date  = NSDate() // 현재 시간 가져오기
        
        let formatter = DateFormatter() // 날짜를 출력하기 위한 클래스 상수 선언
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE" // formatter의 속성 설정
        // lblCurrentTime에 삽입
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date)
        
        formatter.dateFormat = "hh:mm aaa"
        let currentTime = formatter.string(from: date as Date)
        
        if (alarmTime == currentTime){
            if !alertFlag {
                let sameTimeAlert = UIAlertController(title: "알림", message: "설정된 시간입니다 !!!", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "네, 알겠습니다", style: UIAlertAction.Style.default, handler: nil)
                
                sameTimeAlert.addAction(onAction)
                present(sameTimeAlert, animated: true, completion: nil)
                
                alertFlag = true
            }
        }
        else {
            alertFlag = false
        }
    }
    
}

