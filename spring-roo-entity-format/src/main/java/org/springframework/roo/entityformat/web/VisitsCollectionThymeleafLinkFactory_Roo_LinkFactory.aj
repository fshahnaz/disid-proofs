// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.entityformat.web;

import io.springlets.web.mvc.util.MethodLinkFactory;
import org.springframework.roo.entityformat.web.VisitsCollectionThymeleafController;
import org.springframework.roo.entityformat.web.VisitsCollectionThymeleafLinkFactory;
import org.springframework.stereotype.Component;

privileged aspect VisitsCollectionThymeleafLinkFactory_Roo_LinkFactory {
    
    declare parents: VisitsCollectionThymeleafLinkFactory implements MethodLinkFactory<VisitsCollectionThymeleafController>;
    
    declare @type: VisitsCollectionThymeleafLinkFactory: @Component;

    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return Class
     */
    public Class<VisitsCollectionThymeleafController> VisitsCollectionThymeleafLinkFactory.getControllerClass() {
        return VisitsCollectionThymeleafController.class;
    }
    
}
