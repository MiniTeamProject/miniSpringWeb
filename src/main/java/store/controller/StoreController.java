package store.controller;

import board.bean.BoardDTO;
import image.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import store.bean.StoreDTO;
import store.service.StoreService;
import user.service.UserService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("store")
public class StoreController {
    @Autowired
    private StoreService storeService;

    @Autowired
    private UserService userService;

    @Autowired
    private ImageService imageService;

    @RequestMapping(value = "storeMain", method = RequestMethod.GET)
	public ModelAndView storeMain(@RequestParam(required = false, defaultValue = "1") String pg) {
	   ModelAndView modelAndView = new ModelAndView();
	   Map<String, Object> pagingMap = storeService.getStoreList(Integer.parseInt(pg));

	   List<StoreDTO> checkValue = (List<StoreDTO>) pagingMap.get("storeList");
	   // 각 게시물의 이미지 URL을 저장할 리스트 생성
	   List<String> imgSrcList = new ArrayList<>();

	for (StoreDTO store : checkValue) {
		String description = store.getDescription(); // BoardDTO 객체에서 content 값 추출
		System.out.println("Description: " + description);

		// 정규 표현식을 사용하여 <img ... > 태그를 추출
		Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']([^\"']*)[\"'][^>]*>");
		Matcher matcher = imgPattern.matcher(description);

		if (matcher.find()) {
			String imgSrc = matcher.group(1); // img 태그 안의 src 값 추출
			imgSrcList.add(imgSrc); // 리스트에 이미지 URL 추가
			System.out.println("imgSrc: " + imgSrc);
		} else {
			imgSrcList.add(""); // 이미지가 없을 경우 빈 문자열 추가
		}

	}

	// boardHotList 처리
	List<StoreDTO> hotStoreList = (List<StoreDTO>) pagingMap.get("storeHotList");
	List<String> hotImgSrcList = new ArrayList<>();

	for (StoreDTO store : hotStoreList) {
		String description = store.getDescription(); // BoardDTO 객체에서 content 값 추출
		System.out.println("Hot Description: " + description);

		// 정규 표현식을 사용하여 <img ... > 태그를 추출
		Pattern imgPattern = Pattern.compile("<img[^>]*src=[\"']([^\"']*)[\"'][^>]*>");
		Matcher matcher = imgPattern.matcher(description);

		if (matcher.find()) {
			String imgSrc = matcher.group(1); // img 태그 안의 src 값 추출
			hotImgSrcList.add(imgSrc); // 리스트에 이미지 URL 추가
			System.out.println("Hot imgSrc: " + imgSrc);
		} else {
			hotImgSrcList.add(""); // 이미지가 없을 경우 빈 문자열 추가
		}
	}

	if (checkValue == null || checkValue.isEmpty()) {
		modelAndView.addObject("fail", "fail");
		System.out.println("모델 값 : " + modelAndView.getModel().get("fail"));
	} else {
		modelAndView.addObject("storeList", checkValue);
		modelAndView.addObject("storeHotList", pagingMap.get("storeHotList"));
		modelAndView.addObject("pg", pagingMap.get("pg"));
		modelAndView.addObject("storePaging", pagingMap.get("storePaging"));
		modelAndView.addObject("imgSrcList", imgSrcList); // 리스트를 모델에 추가
		modelAndView.addObject("hotImgSrcList", hotImgSrcList); // boardHotList 이미지 URL 리스트 추가
		modelAndView.setViewName("store/storeMain");
	}

	   return modelAndView;
	}
	@RequestMapping(value = "storeWriteForm", method = RequestMethod.GET)
	public ModelAndView storeWriteForm(/*@RequestParam("id") String id*/) {
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("store/storeWriteForm");

		return modelAndView;
	}
	@RequestMapping(value = "storeWrite", method = RequestMethod.POST)
	@ResponseBody
	public String boardWrite(@RequestParam("name") String name,
							 @RequestParam("description") String description,
							 @RequestParam("price") String price,
							 @RequestParam("category") String category
							 ) {

		// 게시물 저장 로직



		// 이미지 URL을 포함한 게시물 저장 로직 구현
		int result = storeService.storeWrite(name, description, price, category);

		if(result == 0) {
			System.out.println("글작성 실패");
			return "fail";
		}else {
			return "success";
		}
	}
}
