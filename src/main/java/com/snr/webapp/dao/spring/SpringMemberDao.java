package com.snr.webapp.dao.spring;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import com.snr.webapp.dao.MemberDao;
import com.snr.webapp.entity.Member;

public class SpringMemberDao implements MemberDao {

	@Autowired
	private JdbcTemplate template;
	
	@Override
	public int insert(String id, String string, String name, String phone, String email) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Member get(String id) {
		String sql = "select * from Member where id = ?;";
		
		Member member = template.queryForObject(sql, 
												new Object[] {id},
												BeanPropertyRowMapper.newInstance(Member.class));
		
		return member;
	}

	@Override
	public int insert(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int pointUp(String id) {
		String sql = "update Member set point=point+1 where id=?;";
		
		int result = template.update(sql, id);
		
		return result;
	}

}
