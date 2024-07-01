//
//  ViewController.swift
//  calculatorCodebase
//
//  Created by 내꺼다 on 6/24/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var number: Int = 12345
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addStackViews()
    }
    
    // label 생성
    private func configureUI() {
        view.backgroundColor = .black
        label.text = "\(number)"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 60)
        label.textAlignment = .right
        
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.centerY.equalToSuperview().offset(-200)
        }
    }
    
    // 버튼 생성
    private func makeButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = backgroundColor
        button.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(80)
        }
        button.layer.cornerRadius = 40
        return button
    }
    
    // 수평 스택뷰를 생성
    private func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {  // 수평스택뷰 함수
        // 주어진 뷰들을 수평으로 정렬하는 UIStackView 생성
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    // 수직 스택뷰를 생성
    private func makeVerticalStackView(_ views: [UIView]) -> UIStackView { // 수직스택뷰
        // 주어진 뷰들을 수직으로 정렬하는 UIStackView 생성
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    // 스택뷰들을 추가
    private func addStackViews() {
        let buttonTitles = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "AC", "0", "=", "/"]
        let operationButtons: Set<String> = ["+", "-", "*", "AC", "=", "/"] // 연산자 버튼들
        var buttons: [UIButton] = []
        
        // 버튼 생성해서 배열에 추가
        for title in buttonTitles {
            let buttonColor: UIColor = operationButtons.contains(title) ? .orange : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            let button = makeButton(title: title, backgroundColor: buttonColor)
            buttons.append(button)
        }
        
        // 4개의 버튼을 포함하는 수평 스택뷰 생성
        let stackViews = stride(from: 0, to: buttons.count, by: 4).map { i in  // stride를 사용해서 4개씩 잘라서 makeHorizontalStackView 메서드로 넘김
            makeHorizontalStackView(Array(buttons[i..<min(i + 4, buttons.count)]))  // min 은 i + 4 가 buttons.count를 초과하지 않도록 한다. buttons 배열의 범위를 벗어나지 않게 하는 안전장치이다.
        }
        
        // 수평 스택뷰들을 모아서 수직 스택뷰 생성
        let verticalStackView = makeVerticalStackView(stackViews)
        view.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.width.equalTo(350)
        }
    }
}
