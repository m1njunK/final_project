package com.bitc.project.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@PropertySources({
	@PropertySource("classpath:prop/openai.properties")
})
@Controller
public class HomeController {
    
	@Value("${apikey}")
	private String apiKey;
	private static final String ENDPOINT = "https://api.openai.com/v1/chat/completions";
	
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        return "home";
    }
    
    @GetMapping("/getKey")
    @ResponseBody
    public String getKey() {
    	return apiKey+","+ENDPOINT;
    }
}
