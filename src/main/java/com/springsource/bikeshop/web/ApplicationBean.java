package com.springsource.bikeshop.web;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.event.ActionEvent;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.roo.addon.jsf.application.RooJsfApplicationBean;
import org.springframework.security.core.context.SecurityContextHolder;

import com.springsource.bikeshop.web.util.FacesUtil;

@RooJsfApplicationBean
public class ApplicationBean {
	
	private String usuario;
	private String senha;

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getColumnName(String column) {
        if (column == null || column.length() == 0) {
            return column;
        }
        final Pattern p = Pattern.compile("[A-Z][^A-Z]*");
        final Matcher m = p.matcher(Character.toUpperCase(column.charAt(0)) + column.substring(1));
        final StringBuilder builder = new StringBuilder();
        while (m.find()) {
            builder.append(m.group()).append(" ");
        }
        return builder.toString().trim();
    }
    
    public String logar(ActionEvent actionEvent) throws IOException, ServletException {
        ExternalContext context = FacesContext.getCurrentInstance()
                .getExternalContext();
 
        RequestDispatcher dispatcher = ((ServletRequest) context.getRequest())
                .getRequestDispatcher("/j_spring_security_check?j_username=" + usuario
                                + "&j_password=" + senha);
 
        dispatcher.forward((ServletRequest) context.getRequest(),
                (ServletResponse) context.getResponse());
 
        FacesContext.getCurrentInstance().responseComplete();
        String teste = FacesContext.getCurrentInstance().getExternalContext().getRequestContextPath();
        String usuarioLogado = SecurityContextHolder.getContext().getAuthentication().getName();
        return null;
    }
}