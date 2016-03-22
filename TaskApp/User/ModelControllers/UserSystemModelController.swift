//
//  UserSystemModelController.swift
//  TaskApp
//
//  Created by Tony Zhang on 3/22/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import AVOSCloud

protocol UserSystemModelControllerProtocol {
    associatedtype UserType: AVUser
    
    var delegate: UserSystemModelControllerDelegate? { get set }
    
    /*!
     * @brief the returned user info after a server-side query
     */
    var currentUser: UserType? { get }
}

protocol UserSystemModelControllerDelegate {
    /*!
     * @brief Called whenever the controller successfully retrives user info (through login, signup etc.)
     */
    func didRetrieveCurrentUserInfo<ModelController: UserSystemModelControllerProtocol>(controller: ModelController)
    
    
    /*!
     * @brief Called whenever an error occurred when retrieving user info.
     */
    func didFailedLoadingUserInfo<ModelController: UserSystemModelControllerProtocol>(controller: ModelController, action: String, errorMsg: String)
    
}
