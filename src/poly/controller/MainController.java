package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="index")
	public String Index() {
		log.info(this.getClass());
		
		return "/index";
	}

	@RequestMapping(value="toilet_auto")
	public String toilet_auto() {
		log.info(this.getClass());

		return "/toilet/toilet_auto";
	}

	@RequestMapping(value="toilet_manual")
	public String toilet_manual() {
		log.info(this.getClass().getName());

		return "/toilet/toilet_manual";
	}
	
}
