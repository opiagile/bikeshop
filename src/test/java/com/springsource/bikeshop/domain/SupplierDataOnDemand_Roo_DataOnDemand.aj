// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.springsource.bikeshop.domain;

import com.springsource.bikeshop.domain.Supplier;
import com.springsource.bikeshop.domain.SupplierDataOnDemand;
import com.springsource.bikeshop.domain.SupplierRepository;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect SupplierDataOnDemand_Roo_DataOnDemand {
    
    declare @type: SupplierDataOnDemand: @Component;
    
    private Random SupplierDataOnDemand.rnd = new SecureRandom();
    
    private List<Supplier> SupplierDataOnDemand.data;
    
    @Autowired
    SupplierRepository SupplierDataOnDemand.supplierRepository;
    
    public Supplier SupplierDataOnDemand.getNewTransientSupplier(int index) {
        Supplier obj = new Supplier();
        setAddress(obj, index);
        setDescription(obj, index);
        setEmail(obj, index);
        setInceptionDate(obj, index);
        setName(obj, index);
        setSupplierNumber(obj, index);
        return obj;
    }
    
    public void SupplierDataOnDemand.setAddress(Supplier obj, int index) {
        String address = "address_" + index;
        if (address.length() > 100) {
            address = address.substring(0, 100);
        }
        obj.setAddress(address);
    }
    
    public void SupplierDataOnDemand.setDescription(Supplier obj, int index) {
        String description = "description_" + index;
        obj.setDescription(description);
    }
    
    public void SupplierDataOnDemand.setEmail(Supplier obj, int index) {
        String email = "foo" + index + "@bar.com";
        obj.setEmail(email);
    }
    
    public void SupplierDataOnDemand.setInceptionDate(Supplier obj, int index) {
        Date inceptionDate = new Date(new Date().getTime() - 10000000L);
        obj.setInceptionDate(inceptionDate);
    }
    
    public void SupplierDataOnDemand.setName(Supplier obj, int index) {
        String name = "name_" + index;
        if (name.length() > 25) {
            name = name.substring(0, 25);
        }
        obj.setName(name);
    }
    
    public void SupplierDataOnDemand.setSupplierNumber(Supplier obj, int index) {
        int supplierNumber = index;
        if (supplierNumber < 1 || supplierNumber > 99) {
            supplierNumber = 99;
        }
        obj.setSupplierNumber(supplierNumber);
    }
    
    public Supplier SupplierDataOnDemand.getSpecificSupplier(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Supplier obj = data.get(index);
        Long id = obj.getId();
        return supplierRepository.findOne(id);
    }
    
    public Supplier SupplierDataOnDemand.getRandomSupplier() {
        init();
        Supplier obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return supplierRepository.findOne(id);
    }
    
    public boolean SupplierDataOnDemand.modifySupplier(Supplier obj) {
        return false;
    }
    
    public void SupplierDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = supplierRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Supplier' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Supplier>();
        for (int i = 0; i < 10; i++) {
            Supplier obj = getNewTransientSupplier(i);
            try {
                supplierRepository.save(obj);
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            supplierRepository.flush();
            data.add(obj);
        }
    }
    
}
