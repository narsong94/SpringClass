package com.snr.webapp.dao.spring;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.snr.webapp.dao.NoticeDao;
import com.snr.webapp.entity.Notice;
import com.snr.webapp.entity.NoticeView;

public class SpringNoticeDao implements NoticeDao {
	
	@Autowired
	private JdbcTemplate template;
	
	/*	Transaction 贸府 规过 1
	 *  TransactionManager 流立 荤侩
	 * 
	 * @Autowired
	private PlatformTransactionManager transactionManager;*/
	
	/*Transaction 贸府 规过 2
	 *  TransactionTemplate 荤侩
	 * 
	 * @Autowired
	private TransactionTemplate transactionTemplate;*/

	@Override
	public List<NoticeView> getList(int page, String field, String query) {
		
		String sql = "select * from NoticeView where "+field+" like ? order by regDate DESC limit ?,10";

		List<NoticeView> list = template.query(sql, 
				new Object[] {"%"+query+"%", (page-1)*10},
				BeanPropertyRowMapper.newInstance(NoticeView.class));

		return list;
	}

	@Override
	public int getCount() {
		String sql = "select count(id) `count` from Notice";
		int count = template.queryForObject(sql, Integer.class);
		return count;
	}

	@Override
	public NoticeView get(String id) {
		String sql = "select * from Notice where id = ?";

		NoticeView notice = template.queryForObject(sql, 
													new Object[] {id},
													BeanPropertyRowMapper.newInstance(NoticeView.class));

		/*NoticeView notice = template.queryForObject(sql, 
				new Object[] {id},
				new RowMapper<NoticeView>() {

					@Override
					public NoticeView mapRow(ResultSet rs, int rowNum) throws SQLException {
						
						NoticeView notice = new NoticeView();
						notice.setId(rs.getString("id"));
						notice.setTitle(rs.getString("title") + "扼绊 茄促");
						notice.setWriterId(rs.getString("writerId"));
						notice.setContent(rs.getString("content"));
						notice.setHit(0);
						
						return null;
					}
			
		});*/
		
		/*DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.mysql.jdbc.Driver");
		dataSource.setUrl("jdbc:mysql://211.238.142.247/newlecture?autoReconnect=true&useSSL=false&useUnicode=true&characterEncoding=utf8");
		dataSource.setUsername("sist");
		dataSource.setPassword("cclass");

		template.setDataSource(dataSource);*/
			
		return notice;
	}

	@Override
	public int update(String id, String title, String content) {
		
		String sql = "update Notice set title = ?, content = ? where id = ?;";

		int result = template.update(sql, title, content, id);
		
		return result;
	}

	@Override
	public int insert(String title, String content, String writerId) {
		
		return insert(new Notice(title, content, writerId));
	}
	
	// Transaction 贸府 规过 3苞 4(Annotation-Transactional)
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public int insert(Notice notice) {
		
		String sql = "insert into Notice(id, title, content, writerId) values(?, ?, ?, ?);";
		String sql1 = "update Member set point=point+1 where id=?;";
		
		int result = template.update(sql, 
						getNextId(), 
						notice.getTitle(), 
						notice.getContent(), 
						notice.getWriterId());	

		result += template.update(sql1,notice.getWriterId());
				
		return result;
	}

	/*	Transaction 贸府 规过 2
	 *  TransactionTemplate 荤侩
	 *  
	 * @Override
	public int insert(Notice notice) {
		
		String sql = "insert into Notice(id, title, content, writerId) values(?, ?, ?, ?);";
		String sql1 = "update Member set point=point+1 where id=?;";
		int result = 0;
		
		result = (int) transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus arg0) {
				template.update(sql, 
						getNextId(), 
						notice.getTitle(), 
						notice.getContent(), 
						notice.getWriterId());	

				template.update(sql1,notice.getWriterId());
			}
		});
		
		return result;
	}*/
	
	/*	Transaction 贸府 规过 1
	 *  TransactionManager 流立 荤侩
	 * 
	 * @Override
	public int insert(Notice notice) {
		int result = 0;
		String sql = "insert into Notice(id, title, content, writerId) values(?, ?, ?, ?);";
		String sql1 = "update Member set point=point+1 where id=?;";

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus state = transactionManager.getTransaction(def);
		
		try {
			result = template.update(sql, 
									getNextId(), 
									notice.getTitle(), 
									notice.getContent(), 
									notice.getWriterId());	
	
			result += template.update(sql1,notice.getWriterId());
		
			transactionManager.commit(state);
			
			return result;
			
		}catch(Exception e){
			transactionManager.rollback(state);
			throw e;
		}
	}*/

	@Override
	public NoticeView getPrev(String id) {
		
		String sql = "select * from NoticeView where id < CAST(? as UNSIGNED) order by regDate DESC limit 1";
		
		NoticeView notice = template.queryForObject(sql, 
													new Object[] {id},
													BeanPropertyRowMapper.newInstance(NoticeView.class));
		
		return notice;
	}

	@Override
	public NoticeView getNext(String id) {
		
		String sql = "select * from NoticeView where id > CAST(? as UNSIGNED) order by regDate ASC limit 1";

		NoticeView notice = template.queryForObject(sql, 
													new Object[] {id},
													BeanPropertyRowMapper.newInstance(NoticeView.class));
		
		return notice;
	}

	@Override
	public String getNextId() {
		String sql = "select ifnull(MAX(CAST(id as unsigned)),0)+1 from Notice";
		
		String nextId = template.queryForObject(sql, String.class);
		System.out.println(nextId);
		
		return nextId;
	}

}
