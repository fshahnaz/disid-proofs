// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.entityformat.web;

import io.springlets.web.mvc.util.MethodLinkFactory;
import org.springframework.roo.entityformat.web.OwnersCollectionThymeleafController;
import org.springframework.roo.entityformat.web.OwnersCollectionThymeleafLinkFactory;
import org.springframework.stereotype.Component;

privileged aspect OwnersCollectionThymeleafLinkFactory_Roo_LinkFactory {
    
    declare parents: OwnersCollectionThymeleafLinkFactory implements MethodLinkFactory<OwnersCollectionThymeleafController>;
    
    declare @type: OwnersCollectionThymeleafLinkFactory: @Component;
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return Class
     */
    public Class<OwnersCollectionThymeleafController> OwnersCollectionThymeleafLinkFactory.getControllerClass() {
        return OwnersCollectionThymeleafController.class;
    }
    
}
