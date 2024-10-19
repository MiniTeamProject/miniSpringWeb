package comment.service;

import java.util.Map;

import org.springframework.stereotype.Component;

import comment.bean.CommentDTO;

@Component
public interface CommentService {

	public Map<String, Object> getCommentView(int seq, int commentpg);

	public boolean writeComment(CommentDTO commentDTO);

	public boolean deleteComment(Map<String, Object> map);
	
}
