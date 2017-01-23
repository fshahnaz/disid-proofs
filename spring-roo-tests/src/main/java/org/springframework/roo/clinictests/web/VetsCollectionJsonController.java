package org.springframework.roo.clinictests.web;
import org.springframework.roo.addon.web.mvc.controller.annotations.ControllerType;
import org.springframework.roo.addon.web.mvc.controller.annotations.RooController;
import org.springframework.roo.addon.web.mvc.controller.annotations.responses.json.RooJSON;
import org.springframework.roo.clinictests.domain.Vet;

/**
 * = VetsCollectionJsonController
 *
 * TODO Auto-generated class documentation
 *
 */
@RooController(entity = Vet.class, type = ControllerType.COLLECTION)
@RooJSON
public class VetsCollectionJsonController {
}
