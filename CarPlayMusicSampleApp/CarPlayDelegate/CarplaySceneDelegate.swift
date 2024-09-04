//
//  CarplaySceneDelegate.swift
//  CarPlayMusicSampleApp
//
//  Created by Polepalli, Venkatesh on 30/01/24.
//

import Foundation
import CarPlay

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {

    let carPlayController = CarPlayController()
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        carPlayController.interfaceController = interfaceController
        carPlayController.setupRemoteCommandCenterTargets()
        carPlayController.setRootTemplate()
    }
    
    private func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnect interfaceController: CPInterfaceController) {
        carPlayController.interfaceController = nil
    }
}
