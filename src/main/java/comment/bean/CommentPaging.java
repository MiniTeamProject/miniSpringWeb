package comment.bean;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class CommentPaging {
    private int currentPage; // 현재 페이지
    private int pageBlock;   // 페이지 블록
    private int pageSize;    // 페이지당 댓글 수
    private int totalA;      // 총 댓글 수
    private int totalPage;   // 총 페이지 수
    private StringBuffer pagingHTML; // 페이징 HTML
    
    public void makePagingHTML() {
        pagingHTML = new StringBuffer();
    
        if (totalA == 0) {
            pagingHTML.append("<span id='noContent'>1</span>");
            totalPage = 1; // 총 댓글 수가 0일 때 페이지 수는 1
            return;
        }
        
        // 총 페이지 수 계산
        totalPage = (totalA + pageSize - 1) / pageSize;
        
        int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if (endPage > totalPage) endPage = totalPage;
        
        if (startPage != 1)
            pagingHTML.append("<span id='movepaging' onclick='commentPaging(" + (startPage - 1) + ")'>이전</span>");    
        
        for (int i = startPage; i <= endPage; i++) {
            if (i == currentPage)
                pagingHTML.append("<span id='currentPaging' onclick='commentPaging(" + i + ")'>" + i + "</span>");   
            else
                pagingHTML.append("<span id='paging' onclick='commentPaging(" + i + ")'>" + i + "</span>");
        }
        
        if (endPage < totalPage)
            pagingHTML.append("<span id='movepaging' onclick='commentPaging(" + (endPage + 1) + ")'>다음</span>");
    }
}
