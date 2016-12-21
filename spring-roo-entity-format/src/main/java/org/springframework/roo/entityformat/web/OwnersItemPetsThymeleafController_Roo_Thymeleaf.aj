// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.entityformat.web;

import io.springlets.web.NotFoundException;
import io.springlets.web.mvc.util.ControllerMethodLinkBuilderFactory;
import io.springlets.web.mvc.util.MethodLinkBuilderFactory;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.entityformat.domain.Owner;
import org.springframework.roo.entityformat.domain.Pet;
import org.springframework.roo.entityformat.reference.PetType;
import org.springframework.roo.entityformat.service.api.OwnerService;
import org.springframework.roo.entityformat.service.api.PetService;
import org.springframework.roo.entityformat.web.OwnersCollectionThymeleafController;
import org.springframework.roo.entityformat.web.OwnersItemPetsThymeleafController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

privileged aspect OwnersItemPetsThymeleafController_Roo_Thymeleaf {
    
    declare @type: OwnersItemPetsThymeleafController: @Controller;
    
    declare @type: OwnersItemPetsThymeleafController: @RequestMapping(value = "/owners/{owner}/pets", name = "OwnersItemPetsThymeleafController", produces = MediaType.TEXT_HTML_VALUE);
    
    /**
     * TODO Auto-generated attribute documentation
     */
    public MessageSource OwnersItemPetsThymeleafController.messageSource;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private MethodLinkBuilderFactory<OwnersCollectionThymeleafController> OwnersItemPetsThymeleafController.collectionLink;
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param ownerService
     * @param petService
     * @param messageSource
     * @param linkBuilder
     */
    @Autowired
    public OwnersItemPetsThymeleafController.new(OwnerService ownerService, PetService petService, MessageSource messageSource, ControllerMethodLinkBuilderFactory linkBuilder) {
        this.ownerService = ownerService;
        this.petService = petService;
        this.messageSource = messageSource;
        this.collectionLink = linkBuilder.of(OwnersCollectionThymeleafController.class);
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @param id
     * @return Owner
     */
    @ModelAttribute
    public Owner OwnersItemPetsThymeleafController.getOwner(@PathVariable("owner") Long id) {
        Owner owner = ownerService.findOne(id);
        if (owner == null) {
            throw new NotFoundException(String.format("Owner with identifier '%s' not found",id));
        }
        return owner;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void OwnersItemPetsThymeleafController.populateFormats(Model model) {
        model.addAttribute("application_locale", LocaleContextHolder.getLocale().getLanguage());
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void OwnersItemPetsThymeleafController.populateForm(Model model) {
        populateFormats(model);
        model.addAttribute("type", Arrays.asList(PetType.values()));
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param Owner
     * @param model
     * @return ModelAndView
     */
    @GetMapping(value = "/create-form", name = "createForm")
    public ModelAndView OwnersItemPetsThymeleafController.createForm(@ModelAttribute Owner Owner, Model model) {
        populateForm(model);
        
        model.addAttribute(new Pet());
        return new ModelAndView("owners/pets/create");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param owner
     * @param petsToRemove
     * @return ResponseEntity
     */
    @DeleteMapping(name = "removeFromPets", value = "/{petsToRemove}")
    @ResponseBody
    public ResponseEntity<?> OwnersItemPetsThymeleafController.removeFromPets(@ModelAttribute Owner owner, @PathVariable("petsToRemove") Long petsToRemove) {
        ownerService.removeFromPets(owner,Collections.singleton(petsToRemove));
        return ResponseEntity.ok().build();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param owner
     * @param pets
     * @param model
     * @return ModelAndView
     */
    @PostMapping(name = "create")
    public ModelAndView OwnersItemPetsThymeleafController.create(@ModelAttribute Owner owner, @RequestParam("petsIds") List<Long> pets, Model model) {
        // Remove empty values
        for (Iterator<Long> iterator = pets.iterator(); iterator.hasNext();) {
            if (iterator.next() == null) {
                iterator.remove();
            }
        }
        ownerService.setPets(owner,pets);
        return new ModelAndView("redirect:" + collectionLink.to("list").toUriString());
    }
    
}
