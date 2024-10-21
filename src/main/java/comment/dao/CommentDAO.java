package comment.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import comment.bean.CommentDTO;

@Mapper
public interface CommentDAO {

	public List<CommentDTO> getCommentList(Map<String, Integer> map);

	public int getTotalComments(int ref);

	public int writeComment(CommentDTO commentDTO);

	public boolean deleteComment(Map<String, Object> map);

}
