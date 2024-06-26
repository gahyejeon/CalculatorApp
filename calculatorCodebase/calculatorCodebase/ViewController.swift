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
    
    private func makeButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 40
        return button
    }
    
    private func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    private func addStackViews() {
        let buttonTitles = ["7", "8", "9", "+", "4", "5", "6", "-", "1", "2", "3", "*", "AC", "0", "=", "/"]
        let operationButtons: Set<String> = ["+", "-", "*", "AC", "=", "/"]
        var buttons: [UIButton] = []   // buttons 배열에 버튼 추가
        
        for title in buttonTitles {
            let buttonColor: UIColor = operationButtons.contains(title) ? .orange : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            let button = makeButton(title: title, backgroundColor: buttonColor)
            buttons.append(button)
        }
        
        
        
        // 4개의 버튼을 포함하는 수평 스택뷰를 생성
        let stackViews = stride(from: 0, to: buttons.count, by: 4).map { i in   // stride를 사용해서 4개씩 잘라서 makeHorizontalStackView메서드로 넘김
            makeHorizontalStackView(Array(buttons[i..<min(i + 4, buttons.count)])) // min 은 i + 4가 buttons.count를 초과하지 않도록 한다. buttons 배열의 범위를 벗어나지 않게 하는 안전장치이다.
        }
        
        // 수평 스택뷰를 뷰에 추가하고 제약 조건을 설정
        for (index, stackView) in stackViews.enumerated() { // 각 수평 스택뷰에 포함된 버튼들에 대해 반복
            view.addSubview(stackView)
            stackView.snp.makeConstraints {
                $0.height.equalTo(80)
                $0.width.equalTo(350)
                $0.centerX.equalToSuperview()
                $0.top.equalTo(label.snp.bottom).offset(60 + (90 * index))  // 라벨로부터 60 떨어진 곳에 배치하고 각 스택뷰가 이전 스택뷰에서 90만큼 떨어지게 배치 각 버튼의 높이가 80이고 spacing 이 10이기 때문에
                  
            }
        }
    }
}
