// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.springframework.roo.entityformat.web;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.builders.ColumnBuilderException;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
import io.springlets.data.domain.GlobalSearch;
import io.springlets.web.mvc.util.ControllerMethodLinkBuilderFactory;
import io.springlets.web.mvc.util.MethodLinkBuilderFactory;
import java.io.IOException;
import java.util.Date;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.roo.entityformat.domain.Owner;
import org.springframework.roo.entityformat.service.api.OwnerService;
import org.springframework.roo.entityformat.web.OwnersCollectionThymeleafController;
import org.springframework.roo.entityformat.web.OwnersItemThymeleafController;
import org.springframework.roo.entityformat.web.reports.JasperReportsCsvExporter;
import org.springframework.roo.entityformat.web.reports.JasperReportsExporter;
import org.springframework.roo.entityformat.web.reports.JasperReportsPdfExporter;
import org.springframework.roo.entityformat.web.reports.JasperReportsXlsExporter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;

privileged aspect OwnersCollectionThymeleafController_Roo_Thymeleaf {
    
    declare @type: OwnersCollectionThymeleafController: @Controller;
    
    declare @type: OwnersCollectionThymeleafController: @RequestMapping(value = "/owners", name = "OwnersCollectionThymeleafController", produces = MediaType.TEXT_HTML_VALUE);
    
    /**
     * TODO Auto-generated attribute documentation
     */
    public MessageSource OwnersCollectionThymeleafController.messageSource;
    
    /**
     * TODO Auto-generated attribute documentation
     */
    private MethodLinkBuilderFactory<OwnersItemThymeleafController> OwnersCollectionThymeleafController.itemLink;
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param ownerService
     * @param messageSource
     * @param linkBuilder
     */
    @Autowired
    public OwnersCollectionThymeleafController.new(OwnerService ownerService, MessageSource messageSource, ControllerMethodLinkBuilderFactory linkBuilder) {
        this.ownerService = ownerService;
        this.messageSource = messageSource;
        this.itemLink = linkBuilder.of(OwnersItemThymeleafController.class);
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     * @return ModelAndView
     */
    @GetMapping(name = "list")
    @ResponseBody
    public ModelAndView OwnersCollectionThymeleafController.list(Model model) {
        return new ModelAndView("/owners/list");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param dataBinder
     */
    @InitBinder("owner")
    public void OwnersCollectionThymeleafController.initOwnerBinder(WebDataBinder dataBinder) {
        dataBinder.setDisallowedFields("id");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void OwnersCollectionThymeleafController.populateFormats(Model model) {
        model.addAttribute("application_locale", LocaleContextHolder.getLocale().getLanguage());
        model.addAttribute("birthDay_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void OwnersCollectionThymeleafController.populateForm(Model model) {
        populateFormats(model);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param owner
     * @param result
     * @param model
     * @return ModelAndView
     */
    @PostMapping(name = "create")
    public ModelAndView OwnersCollectionThymeleafController.create(@Valid @ModelAttribute Owner owner, BindingResult result, Model model) {
        if (result.hasErrors()) {
            populateForm(model);
            
            return new ModelAndView("/owners/create");
        }
        Owner newOwner = ownerService.save(owner);
        UriComponents showURI = itemLink.to("show").with("owner", newOwner.getId()).toUri();
        return new ModelAndView("redirect:" + showURI.toUriString());
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     * @return ModelAndView
     */
    @GetMapping(value = "/create-form", name = "createForm")
    public ModelAndView OwnersCollectionThymeleafController.createForm(Model model) {
        populateForm(model);
        
        model.addAttribute(new Owner());
        return new ModelAndView("owners/create");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param search
     * @param pageable
     * @param datatablesColumns
     * @param response
     * @param exporter
     * @param fileName
     * @throws JRException
     * @throws IOException
     * @throws ColumnBuilderException
     * @throws ClassNotFoundException
     */
    public void OwnersCollectionThymeleafController.export(GlobalSearch search, @PageableDefault(size = 2147483647) Pageable pageable, String[] datatablesColumns, HttpServletResponse response, JasperReportsExporter exporter, String fileName) throws JRException, IOException, ColumnBuilderException, ClassNotFoundException {
        // Obtain the filtered and ordered elements
        Page<Owner> owners = ownerService.findAll(search, pageable);
        
        // Prevent generation of reports with empty data
        if (owners == null || owners.getContent().isEmpty()) {
            throw new RuntimeException("ERROR: Not available data to generate a report.");
        }
        
        // Creates a new ReportBuilder using DynamicJasper library
        FastReportBuilder builder = new FastReportBuilder();
        
        // IMPORTANT: By default, this application uses "export_default.jrxml"
        // to generate all reports. If you want to customize this specific report,
        // create a new ".jrxml" template and customize it. (Take in account the 
        // DynamicJasper restrictions: 
        // http://dynamicjasper.com/2010/10/06/how-to-use-custom-jrxml-templates/)
        builder.setTemplateFile("templates/reports/export_default.jrxml");
        
        // The generated report will display the same columns as the Datatables component.
        // However, this is not mandatory. You could edit this code if you want to ignore
        // the provided datatablesColumns
        if (datatablesColumns != null) {
            for (String column : datatablesColumns) {
                // Delegates in addColumnToReportBuilder to include each datatables column
                // to the report builder
                addColumnToReportBuilder(column, builder);
            }
        }
        
        // This property resizes the columns to use full width page.
        // Set false value if you want to use the specific width of each column.
        builder.setUseFullPageWidth(true);
        
        // Creates a new Jasper Reports Datasource using the obtained elements
        JRDataSource ds = new JRBeanCollectionDataSource(owners.getContent());
        
        // Generates the JasperReport
        JasperPrint jp = DynamicJasperHelper.generateJasperPrint(builder.build(), new ClassicLayoutManager(), ds);
        
        // Converts the JaspertReport element to a ByteArrayOutputStream and
        // write it into the response stream using the provided JasperReportExporter
        exporter.export(jp, fileName, response);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param search
     * @param pageable
     * @param datatablesColumns
     * @param response
     * @return ResponseEntity
     * @throws JRException
     * @throws IOException
     * @throws ColumnBuilderException
     * @throws ClassNotFoundException
     */
    @GetMapping(name = "exportCsv", value = "/export/csv")
    @ResponseBody
    public ResponseEntity<?> OwnersCollectionThymeleafController.exportCsv(GlobalSearch search, @PageableDefault(size = 2147483647) Pageable pageable, @RequestParam("datatablesColumns") String[] datatablesColumns, HttpServletResponse response) throws JRException, IOException, ColumnBuilderException, ClassNotFoundException {
        export(search, pageable, datatablesColumns, response, new JasperReportsCsvExporter(), "owners_report.csv");
        return ResponseEntity.ok().build();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param search
     * @param pageable
     * @param datatablesColumns
     * @param response
     * @return ResponseEntity
     * @throws JRException
     * @throws IOException
     * @throws ColumnBuilderException
     * @throws ClassNotFoundException
     */
    @GetMapping(name = "exportPdf", value = "/export/pdf")
    @ResponseBody
    public ResponseEntity<?> OwnersCollectionThymeleafController.exportPdf(GlobalSearch search, @PageableDefault(size = 2147483647) Pageable pageable, @RequestParam("datatablesColumns") String[] datatablesColumns, HttpServletResponse response) throws JRException, IOException, ColumnBuilderException, ClassNotFoundException {
        export(search, pageable, datatablesColumns, response, new JasperReportsPdfExporter(), "owners_report.pdf");
        return ResponseEntity.ok().build();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param search
     * @param pageable
     * @param datatablesColumns
     * @param response
     * @return ResponseEntity
     * @throws JRException
     * @throws IOException
     * @throws ColumnBuilderException
     * @throws ClassNotFoundException
     */
    @GetMapping(name = "exportXls", value = "/export/xls")
    @ResponseBody
    public ResponseEntity<?> OwnersCollectionThymeleafController.exportXls(GlobalSearch search, @PageableDefault(size = 2147483647) Pageable pageable, @RequestParam("datatablesColumns") String[] datatablesColumns, HttpServletResponse response) throws JRException, IOException, ColumnBuilderException, ClassNotFoundException {
        export(search, pageable, datatablesColumns, response, new JasperReportsXlsExporter(), "owners_report.xls");
        return ResponseEntity.ok().build();
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param columnName
     * @param builder
     * @throws ColumnBuilderException
     * @throws ClassNotFoundException
     */
    public void OwnersCollectionThymeleafController.addColumnToReportBuilder(String columnName, FastReportBuilder builder) throws ColumnBuilderException, ClassNotFoundException {
        if (columnName.equals("id")) {
            builder.addColumn("Id", "id", Long.class.getName(), 50);
        }
        else if (columnName.equals("version")) {
            builder.addColumn("Version", "version", Integer.class.getName(), 100);
        }
        else if (columnName.equals("firstName")) {
            builder.addColumn("FirstName", "firstName", String.class.getName(), 100);
        }
        else if (columnName.equals("lastName")) {
            builder.addColumn("LastName", "lastName", String.class.getName(), 100);
        }
        else if (columnName.equals("address")) {
            builder.addColumn("Address", "address", String.class.getName(), 100);
        }
        else if (columnName.equals("city")) {
            builder.addColumn("City", "city", String.class.getName(), 100);
        }
        else if (columnName.equals("telephone")) {
            builder.addColumn("Telephone", "telephone", String.class.getName(), 100);
        }
        else if (columnName.equals("homePage")) {
            builder.addColumn("HomePage", "homePage", String.class.getName(), 100);
        }
        else if (columnName.equals("email")) {
            builder.addColumn("Email", "email", String.class.getName(), 100);
        }
        else if (columnName.equals("birthDay")) {
            builder.addColumn("BirthDay", "birthDay", Date.class.getName(), 100);
        }
    }
    
}
