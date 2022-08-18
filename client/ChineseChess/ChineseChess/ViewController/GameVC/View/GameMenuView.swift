//
//  GameMenuView.swift
//  ChineseChess
//
//  Created by Cheryl on 2022/6/1.
//
//

import UIKit

class GameMenuView: MenuView {
		
	public override func initDataSource() {
		self.dataSource.append(("reverse", "reverse chessboard", UserPreference.shared.game.reverse.chinese))
		self.dataSource.append(("opposite", "opposite chess", UserPreference.shared.game.opposite.chinese))
		self.dataSource.append(("history", "history", nil))
		self.dataSource.append(("put", "put", nil))
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.allowsSelection = false
		defer {
			tableView.allowsSelection = true
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.row == 0 {
			WavHandler.playVoice(state: .normal)
			self.dataSource[indexPath.row].status = UserPreference.shared.game.reverse.reverse().chinese
			tableView.reloadRows(at: [indexPath], with: .automatic)
		} else if indexPath.row == 1 {
			WavHandler.playVoice(state: .normal)
			self.dataSource[indexPath.row].status = UserPreference.shared.game.opposite.reverse().chinese
			tableView.reloadRows(at: [indexPath], with: .automatic)
		}
		
		self.delegate?.menuView(self, didSelectRowAt: indexPath.row)
	}
	
}

extension Bool {
	
	fileprivate var chinese: String {
		return self ? "yes" : "no"
	}
	
}
