//
//  MyChessBoard.swift
//  MyChineseChess
//
//  Created by Cheryl on 2022/6/1.
//

import UIKit

class MyChessBoard: UIView {
    let allChessTitles: [Int: String] = [
        100: "车",
        101: "马",
        102: "象",
        103: "仕",
        104: "将",
        105: "仕",
        106: "象",
        107: "马",
        108: "车",
        121: "炮",
        127: "炮",
        130: "卒",
        132: "卒",
        134: "卒",
        136: "卒",
        138: "卒",
        190: "車",
        191: "馬",
        192: "相",
        193: "士",
        194: "帥",
        195: "士",
        196: "相",
        197: "馬",
        198: "車",
        171: "炮",
        177: "炮",
        160: "兵",
        162: "兵",
        164: "兵",
        166: "兵",
        168: "兵",
    ]
    var allChessItems: [Int: MyChessItem] = [:]
    var existsChessKeys: [Int: Int] = [:]
    var chessTips: [Int: MyChessTip] = [:]

    let itemWidth = (UIScreen.main.bounds.width - 40) / 9.0

   
    var isRedStep = true

    var fromPos = 0
    var toPos = 0

    /*
     Only override draw() if you perform custom drawing.
     An empty implementation adversely affects performance during animation.
     */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let myContext = UIGraphicsGetCurrentContext()
        if myContext != nil {
            myContext?.setStrokeColor(UIColor.black.cgColor)
            myContext?.setLineWidth(1)

            
            for i in 0 ... 9 {
                myContext?.beginPath()
                myContext?.move(to: CGPoint(x: itemWidth / 2, y: itemWidth / 2 + itemWidth * CGFloat(i)))
                myContext?.addLine(to: CGPoint(x: itemWidth * 8.5, y: itemWidth / 2 + itemWidth * CGFloat(i)))
                myContext?.strokePath()
            }

            
            for i in 0 ... 8 {
                if i == 0 || i == 8 {
                    myContext?.beginPath()
                    myContext?.move(to: CGPoint(x: itemWidth / 2 + CGFloat(i) * itemWidth, y: itemWidth / 2))
                    myContext?.addLine(to: CGPoint(x: itemWidth / 2 + CGFloat(i) * itemWidth, y: itemWidth * 9.5))
                    myContext?.strokePath()
                } else {
                    myContext?.beginPath()
                    myContext?.move(to: CGPoint(x: itemWidth / 2 + CGFloat(i) * itemWidth, y: itemWidth / 2))
                    myContext?.addLine(to: CGPoint(x: itemWidth / 2 + CGFloat(i) * itemWidth, y: itemWidth * 4.5))
                    myContext?.strokePath()

                    myContext?.beginPath()
                    myContext?.move(to: CGPoint(x: itemWidth / 2 + CGFloat(i) * itemWidth, y: itemWidth * 5.5))
                    myContext?.addLine(to: CGPoint(x: itemWidth / 2 + CGFloat(i) * itemWidth, y: itemWidth * 9.5))
                    myContext?.strokePath()
                }
            }

      
            myContext?.beginPath()
            myContext?.move(to: CGPoint(x: 3.5 * itemWidth, y: itemWidth * 0.5))
            myContext?.addLine(to: CGPoint(x: itemWidth * 5.5, y: itemWidth * 2.5))
            myContext?.strokePath()

            myContext?.beginPath()
            myContext?.move(to: CGPoint(x: 5.5 * itemWidth, y: itemWidth * 0.5))
            myContext?.addLine(to: CGPoint(x: itemWidth * 3.5, y: itemWidth * 2.5))
            myContext?.strokePath()

            myContext?.beginPath()
            myContext?.move(to: CGPoint(x: 5.5 * itemWidth, y: itemWidth * 0.5))
            myContext?.addLine(to: CGPoint(x: itemWidth * 3.5, y: itemWidth * 2.5))
            myContext?.strokePath()

            myContext?.beginPath()
            myContext?.move(to: CGPoint(x: 3.5 * itemWidth, y: itemWidth * 7.5))
            myContext?.addLine(to: CGPoint(x: itemWidth * 5.5, y: itemWidth * 9.5))
            myContext?.strokePath()

            myContext?.beginPath()
            myContext?.move(to: CGPoint(x: 3.5 * itemWidth, y: itemWidth * 9.5))
            myContext?.addLine(to: CGPoint(x: itemWidth * 5.5, y: itemWidth * 7.5))
            myContext?.strokePath()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addChessItem()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func replay() {
        existsChessKeys.removeAll()
        resetChessItem()
        isRedStep = true
        fromPos = 0
        toPos = 0
    }


    func addChessItem() {
        for (key, title) in allChessTitles {
            let x = (key - 100) % 10
            let y = (key - 100 - x) / 10

            let chessItem = MyChessItem(frame: CGRect(x: itemWidth * CGFloat(x), y: itemWidth * CGFloat(y), width: itemWidth, height: itemWidth))
            chessItem.setTitle(title)
            chessItem.setIsOwn(y >= 5)
            chessItem.tag = key
            chessItem.addTarget(self, action: #selector(itemClickHandler(sender:)), for: UIControl.Event.touchUpInside)
            addSubview(chessItem)

            allChessItems[key] = chessItem
            existsChessKeys[key] = key
        }
    }


    func resetChessItem() {
        for (key, title) in allChessTitles {
            let x = (key - 100) % 10
            let y = (key - 100 - x) / 10

            UIView.animate(withDuration: 0.3) {
                self.allChessItems[key]?.frame = CGRect(x: CGFloat(x) * self.itemWidth, y: CGFloat(y) * self.itemWidth, width: self.itemWidth, height: self.itemWidth)
                self.allChessItems[key]?.setMyIsSelect(false)
            }

            existsChessKeys[key] = key
        }
    }


    @objc func itemClickHandler(sender: MyChessItem) {
        let btnTag = sender.tag

        let filterChessKeys = existsChessKeys.filter { (_: Int, value: Int) in
            value == btnTag
        }
        let pos: Int = filterChessKeys.keys.first ?? 0
        if pos < 100 {
            return
        }

        if btnTag < 150, isRedStep {
            return
        } else if btnTag >= 150, !isRedStep {
            return
        }
        if fromPos >= 100 {
            clearChessTip()
            let preTag = existsChessKeys[fromPos]!
            allChessItems[preTag]?.setMyIsSelect(false)
            fromPos = 0
        }

        if !sender.myIsSelect {
            sender.setMyIsSelect(true)
            fromPos = pos
            showTips(pos)
        } else {
            fromPos = 0
            sender.setMyIsSelect(false)
            clearChessTip()
        }
    }


    func showTips(_ pos: Int) {
        let pos_x = (pos - 100) % 10
        let pos_y = (pos - 100 - pos_x) / 10

        let btnTag = existsChessKeys[pos]!
        let chessItem = allChessItems[btnTag]

        var arr_change: [Int] = []

        if chessItem?.titleLabel!.text == "兵" {
            if pos >= 150 {
                arr_change = [-10]
            } else {
                arr_change = [-10, -1, 1]
            }
        } else if chessItem?.titleLabel!.text == "卒" {
            if pos < 150 {
                arr_change = [10]
            } else {
                arr_change = [10, -1, 1]
            }
        } else if chessItem?.titleLabel!.text == "馬" || chessItem?.titleLabel!.text == "马" {
            if existsChessKeys[pos - 10] == nil {
                arr_change.append(-20 + 1)
                arr_change.append(-20 - 1)
            }
            if existsChessKeys[pos + 1] == nil {
                arr_change.append(-10 + 2)
                arr_change.append(10 + 2)
            }
            if existsChessKeys[pos + 10] == nil {
                arr_change.append(20 + 1)
                arr_change.append(20 - 1)
            }
            if existsChessKeys[pos - 1] == nil {
                arr_change.append(-10 - 2)
                arr_change.append(10 - 2)
            }

        } else if chessItem?.titleLabel!.text == "象" || chessItem?.titleLabel!.text == "相" {
            if existsChessKeys[pos - 10 - 1] == nil, (pos - 20 - 2 < 150) == (chessItem?.titleLabel!.text == "象") {
                arr_change.append(-20 - 2)
            }
            if existsChessKeys[pos - 10 + 1] == nil, (pos - 20 + 2 < 150) == (chessItem?.titleLabel!.text == "象") {
                arr_change.append(-20 + 2)
            }
            if existsChessKeys[pos + 10 + 1] == nil, (pos + 20 + 2 < 150) == (chessItem?.titleLabel!.text == "象") {
                arr_change.append(20 + 2)
            }
            if existsChessKeys[pos + 10 - 1] == nil, (pos + 20 - 2 < 150) == (chessItem?.titleLabel!.text == "象") {
                arr_change.append(20 - 2)
            }
        } else if chessItem?.titleLabel!.text == "士" || chessItem?.titleLabel!.text == "仕" { // 士走斜线， 不出田
            if isInFarmField(pos - 10 - 1) {
                arr_change.append(-10 - 1)
            }
            if isInFarmField(pos - 10 + 1) {
                arr_change.append(-10 + 1)
            }
            if isInFarmField(pos + 10 + 1) {
                arr_change.append(10 + 1)
            }
            if isInFarmField(pos + 10 - 1) {
                arr_change.append(10 - 1)
            }
        } else if chessItem?.titleLabel!.text == "将" || chessItem?.titleLabel!.text == "帥" {
            if isInFarmField(pos - 10) {
                arr_change.append(-10)
            }
            if isInFarmField(pos + 1) {
                arr_change.append(1)
            }
            if isInFarmField(pos + 10) {
                arr_change.append(10)
            }
            if isInFarmField(pos - 1) {
                arr_change.append(-1)
            }
        } else if chessItem?.titleLabel!.text == "車" || chessItem?.titleLabel!.text == "车" {
            if pos_y >= 1 {
                for i in 1 ... pos_y {
                    if existsChessKeys[pos - i * 10] == nil {
                        arr_change.append(-10 * i)
                    } else {
                        arr_change.append(-10 * i)
                        break
                    }
                }
            }
            if pos_x <= 7 {
                for i in 1 ... (8 - pos_x) {
                    if existsChessKeys[pos + i] == nil {
                        arr_change.append(i)
                    } else {
                        arr_change.append(i)
                        break
                    }
                }
            }
            if pos_y <= 8 {
                for i in 1 ... (9 - pos_y) {
                    if existsChessKeys[pos + i * 10] == nil {
                        arr_change.append(10 * i)
                    } else {
                        arr_change.append(10 * i)
                        break
                    }
                }
            }

            if pos_x >= 1 {
                for i in 1 ... pos_x {
                    if existsChessKeys[pos - i] == nil {
                        arr_change.append(-1 * i)
                    } else {
                        arr_change.append(-1 * i)
                        break
                    }
                }
            }

        } else if chessItem?.titleLabel!.text == "炮" {
            var isCrossItem = false
            if pos_y >= 1 {
                for i in 1 ... pos_y {
                    if existsChessKeys[pos - i * 10] == nil, !isCrossItem {
                        arr_change.append(-10 * i)
                    } else if existsChessKeys[pos - i * 10] != nil, !isCrossItem {
                        isCrossItem = true
                        continue
                    } else if existsChessKeys[pos - i * 10] == nil, isCrossItem {
                        continue
                    } else if existsChessKeys[pos - i * 10] != nil, isCrossItem {
                        arr_change.append(-10 * i)
                        break
                    }
                }
            }
            if pos_x <= 7 {
                isCrossItem = false
                for i in 1 ... (8 - pos_x) {
                    if existsChessKeys[pos + i] == nil, !isCrossItem {
                        arr_change.append(i)
                    } else if existsChessKeys[pos + i] != nil, !isCrossItem {
                        isCrossItem = true
                        continue
                    } else if existsChessKeys[pos + i] == nil, isCrossItem {
                        continue
                    } else if existsChessKeys[pos + i] != nil, isCrossItem {
                        arr_change.append(i)
                        break
                    }
                }
            }
            if pos_y <= 8 {
                isCrossItem = false
                for i in 1 ... (9 - pos_y) {
                    if existsChessKeys[pos + i * 10] == nil, !isCrossItem {
                        arr_change.append(10 * i)
                    } else if existsChessKeys[pos + i * 10] != nil, !isCrossItem {
                        isCrossItem = true
                        continue
                    } else if existsChessKeys[pos + i * 10] == nil, isCrossItem {
                        continue
                    } else if existsChessKeys[pos + i * 10] != nil, isCrossItem {
                        arr_change.append(10 * i)
                        break
                    }
                }
            }

            if pos_x >= 1 {
                isCrossItem = false
                for i in 1 ... pos_x {
                    if existsChessKeys[pos - i] == nil, !isCrossItem {
                        arr_change.append(-1 * i)
                    } else if existsChessKeys[pos - i] != nil, !isCrossItem {
                        isCrossItem = true
                        continue
                    } else if existsChessKeys[pos - i] == nil, isCrossItem {
                        continue
                    } else if existsChessKeys[pos - i] != nil, isCrossItem {
                        arr_change.append(-1 * i)
                        break
                    }
                }
            }
        }

        for change_pos in arr_change {
            let x = (pos + change_pos - 100) % 10
            let y = (pos + change_pos - 100 - x) / 10

  
            if !(x >= 0 && x <= 8 && y >= 0 && y <= 9) {
                continue
            }
    
            let targetPos = 100 + 10 * y + x
            if existsChessKeys[targetPos] != nil {
                let targetTag = existsChessKeys[targetPos]!
                if targetTag < 150, !isRedStep {
                    continue
                }
                if targetTag >= 150, isRedStep {
                    continue
                }
            }

            let chessTip = MyChessTip(frame: CGRect(x: itemWidth * CGFloat(x), y: itemWidth * CGFloat(y), width: itemWidth, height: itemWidth))
            chessTip.tag = 200 + 10 * y + x
            chessTip.addTarget(self, action: #selector(handleTipClick(sender:)), for: UIControl.Event.touchUpInside)
            addSubview(chessTip)
            chessTips[100 + 10 * y + x] = chessTip
        }
    }


    @objc func handleTipClick(sender: MyChessTip) {
        toPos = sender.tag - 100
        let x = toPos % 10
        let y = (toPos - 100 - x) / 10
        clearChessTip()

        let chessTag = existsChessKeys[fromPos]!
        let chessItem = allChessItems[chessTag]

        let removeTag = existsChessKeys[toPos] ?? 0
        if removeTag == 104 {
            let alert = UIAlertController(title: "GAME OVER", message: "RED SIDE WIN！", preferredStyle: UIAlertController.Style.alert)
            window?.rootViewController?.present(alert, animated: true, completion: {
                self.replay()
            })
            replay() // ???

            return
        } else if removeTag == 194 {
            let alert = UIAlertController(title: "GAME OVER", message: "GREEN SIDE WIN！", preferredStyle: UIAlertController.Style.alert)
            window?.rootViewController?.present(alert, animated: true, completion: {
                self.replay()
            })
            replay() // ???

            return
        }

        existsChessKeys[toPos] = chessItem?.tag
        existsChessKeys.removeValue(forKey: fromPos)

        isRedStep = !isRedStep

        UIView.animate(withDuration: 0.3) {
            chessItem?.frame = CGRect(x: CGFloat(x) * self.itemWidth, y: CGFloat(y) * self.itemWidth, width: self.itemWidth, height: self.itemWidth)
            chessItem?.setMyIsSelect(false)

      
            if removeTag >= 100 {
                self.allChessItems[removeTag]?.frame = CGRect(x: -21 - 2.0 * self.itemWidth, y: -21 - 2.0 * self.itemWidth, width: self.itemWidth, height: self.itemWidth)
            }
        }

        fromPos = 0
        toPos = 0
    }


    func clearChessTip() {
        for (_, tip) in chessTips {
            tip.removeFromSuperview()
        }
        chessTips.removeAll()
    }


    func isInRedArea(_ pos: Int) -> Bool {
        return pos >= 150
    }


    func isInFarmField(_ pos: Int) -> Bool {
        let x = pos % 10
        let y = (pos - x - 100) / 10
        return x >= 3 && x <= 5 && ((y >= 0 && y <= 2) || (y >= 7 && y <= 9))
    }
}
