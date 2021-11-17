package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ssafy.happyhouse.model.UserDto;
import com.ssafy.happyhouse.model.service.UserService;

@Controller
@CrossOrigin("*")
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@PostMapping("/register")
	public String register(UserDto userDto) throws Exception {
		userService.registerMember(userDto);
		return "redirect:/";
	}

	@GetMapping("/login")
	public String login() {
		return "/";
	}

	@PostMapping("/login")
	public String login(@RequestParam Map<String, String> map, Model model, HttpSession session,
			HttpServletResponse response) throws Exception {
		UserDto userDto = userService.login(map);
		if (userDto != null) {
			session.setAttribute("userinfo", userDto);
//			Cookie cookie = new Cookie("user_id", map.get("userId"));
//			cookie.setPath("/");
//			if ("saveok".equals(map.get("idsave"))) {
//				cookie.setMaxAge(60 * 60 * 24 * 365 * 40);
//			} else {
//				cookie.setMaxAge(0);
//			}
//			response.addCookie(cookie);
		} else {
			model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 다시 로그인하세요!");
		}
		return "redirect:/";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/delete/{id}")
	public String delete(@PathVariable("id") String id, HttpSession session) throws Exception {
		System.out.println(id);
		userService.delete(id);
		logout(session);
		return "redirect:/";
	}

	@PostMapping("/update")
	public String update(UserDto userDto, HttpSession session) throws Exception {
		userService.updateUser(userDto);
		session.setAttribute("userinfo", userDto);
		return "redirect:/";
	}

//	@PostMapping("/find")
//	public String find(@RequestParam Map<String, String> map, RedirectAttributes redirectAttributes) throws Exception {
////		ModelAndView mav = new ModelAndView();
//		String password = userService.findPassword(map);
//		if(password==null) {
////			mav.addObject("msg","회원이 존재하지 않습니다");
//			redirectAttributes.addFlashAttribute("msg", "회원이 존재하지 않습니다");
//		} else {
////			mav.addObject("msg","비밀번호는 " + password+" 입니다.");
//			redirectAttributes.addFlashAttribute("msg", "비밀번호는 " + password+" 입니다.");
//		}
////		mav.setViewName("user/find");
//		return "redirect:/";
//	}

	@GetMapping("/find")
//	@ResponseBody
	public @ResponseBody String find(@RequestParam("id") String id, @RequestParam("name") String name)
			throws Exception {
		String password = userService.findPassword(id, name);
		System.out.println(password);
		JSONObject json = new JSONObject();
		if (password == null) {
			json.put("msg", "회원이 존재하지 않습니다");
		} else {
			json.put("msg", "비밀번호는 " + password + " 입니다.");
		}
		return json.toString();
	}

	@GetMapping("/list")
	public String list() throws Exception {
		return "userList";
	}
	
	@GetMapping("/userlist")
	@ResponseBody
	public ResponseEntity<List<UserDto>> listUser() throws Exception {
		List<UserDto> list = userService.userList();
		if (list != null && !list.isEmpty()) {
			return new ResponseEntity<List<UserDto>>(list, HttpStatus.OK);
		} else { // 데이터 없음
			return new ResponseEntity<List<UserDto>>(HttpStatus.NO_CONTENT);
		}
	}
	
	@GetMapping("/userlist/{keyId}")
	@ResponseBody
	public ResponseEntity<List<UserDto>> searchListUser(@PathVariable("keyId") String keyId) throws Exception {
		System.out.println(keyId);
		List<UserDto> list = userService.searchListUser(keyId);
		if (list != null && !list.isEmpty()) {
			return new ResponseEntity<List<UserDto>>(list, HttpStatus.OK);
		} else { // 데이터 없음
			return new ResponseEntity<List<UserDto>>(HttpStatus.NO_CONTENT);
		}
	}
}
