package com.snr.webapp.controller.admin;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import java.util.Calendar;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.snr.webapp.dao.MemberDao;
import com.snr.webapp.dao.NoticeDao;
import com.snr.webapp.dao.NoticeFileDao;
import com.snr.webapp.entity.Notice;
import com.snr.webapp.entity.NoticeFile;
import com.snr.webapp.entity.NoticeView;
import com.snr.webapp.service.admin.BoardService;

@Controller
@RequestMapping("/admin/board/*")
public class BoardController {

	@Autowired
	private BoardService service;
	
	/*@Autowired
	private NoticeDao noticeDao;

	@Autowired
	private NoticeFileDao noticefileDao;
	
	@Autowired
	private MemberDao memberDao;*/

	@RequestMapping("notice")
	public String notice(@RequestParam(value = "p", defaultValue = "1") Integer page,
			@RequestParam(value = "f", defaultValue = "title") String field,
			@RequestParam(value = "q", defaultValue = "") String query, Model model) {

		List<NoticeView> list = service.getNoticeList();
		
		model.addAttribute("list", list);

		return "admin.board.notice.list";
	}

	@RequestMapping("notice/{id}")
	public String noticeDetail(@PathVariable("id") String id, Model model) {

		model.addAttribute("n", service.getNotice(id));
		model.addAttribute("prev", service.getNoticePrev(id));
		model.addAttribute("next", service.getNoticeNext(id));

		return "admin.board.notice.detail";
	}

	@RequestMapping(value = "notice/reg", method = RequestMethod.GET)
	public String noticeReg() {
		return "admin.board.notice.reg";
	}

	@RequestMapping(value = "notice/reg", method = RequestMethod.POST)
	public String noticeReg(Notice notice, MultipartFile file, HttpServletRequest request, Principal principal) throws IOException {

		String nextId = service.getNoticeNextId();

		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);

		ServletContext ctx = request.getServletContext();
		String path = ctx.getRealPath(String.format("/resource/customer/notice/%s/%s", year, nextId));

		System.out.println(path);

		File f = new File(path);
		if (!f.exists()) {
			if (!f.mkdirs())
				System.out.println("년도 디렉토리 생성 불가");
		}

		path += File.separator + file.getOriginalFilename();
		File f2 = new File(path);

		InputStream fis = file.getInputStream();
		OutputStream fos = new FileOutputStream(f2);

		byte[] buf = new byte[1024];

		int size = 0;
		while ((size = fis.read(buf)) > 0)
			fos.write(buf, 0, size);

		fos.close();
		fis.close();

		String fileName = file.getOriginalFilename();

		String writerId = "robin";
		notice.setWriterId(writerId);

		System.out.println(notice.getTitle());

		// noticeDao.insert(title, content, writerId);
		// 업무명
		int row = service.insertAndPointup(notice);
		//memberDao.pointUp(principal.getName());

		// noticefileDao.insert(new NoticeFile(null, fileName, nextId));

		return "redirect:../notice";
	}
}
