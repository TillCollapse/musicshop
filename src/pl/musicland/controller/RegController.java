package pl.musicland.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pl.musicland.model.User;
import pl.musicland.service.AuthoritiesManager;
import pl.musicland.service.UserManager;

@Controller
@RequestMapping("/register")
public class RegController {
	
	@Autowired
	UserManager userManager;
	@Autowired
	AuthoritiesManager authoritiesManager;
	
	//Wysyła za pomocą model informacje o klasie user w celu odwzorowania odpowiednich pól formularza
	@RequestMapping(method = RequestMethod.GET, produces = "text/html; charset=UTF-8") 
	public String viewRegistration(Model model)	{
		User user = new User();
		model.addAttribute("user", user);
		return "regForm";
	}
	//Przetwarza formularza
	//@Valid informuje o konieczności walidacji obiektu User, który zostanie przekazany dopiero
	//po pozytywnym przejsciu walidacji
	@RequestMapping(method = RequestMethod.POST, produces = "text/html; charset=UTF-8")
	public String regProcess(@Valid User user, BindingResult result) {
		if (result.hasErrors()) {
			return "regForm";
		} else {
			userManager.insertUser(user);
			authoritiesManager.insertAthorityForUser(user.getEmail());
			return "redirect:/";
		}
		
	}
}
