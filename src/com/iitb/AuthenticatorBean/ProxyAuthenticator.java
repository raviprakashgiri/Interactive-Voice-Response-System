package com.iitb.AuthenticatorBean;

import java.net.Authenticator;
import java.net.PasswordAuthentication;

public class ProxyAuthenticator extends Authenticator {
	// Taken from http://stackoverflow.com/questions/14113341/http-407-proxy-authentication-required-how-to-handle-in-java-code
	    private String user, password;

	    public ProxyAuthenticator(String user, String password) {
	        this.user = user;
	        this.password = password;
	    }

	    protected PasswordAuthentication getPasswordAuthentication() {
	        return new PasswordAuthentication(user, password.toCharArray());
	    }
	}
