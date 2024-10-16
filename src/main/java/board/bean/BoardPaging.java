package board.bean;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class BoardPaging {
    private int currentPage;
    private int pageBlock;
    private int pageSize;
    private int totalA;
    private StringBuffer pagingHTML;
    
    public void makePagingHTML() {
        pagingHTML = new StringBuffer();
    
        if (totalA == 0) {
            pagingHTML.append("<span id='noContent'>1</span>");
            return;
        }
        
        int totalP = (totalA + pageSize - 1) / pageSize;
        
        int startPage = (currentPage- 1 ) / pageBlock * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;
        if(endPage > totalP) endPage = totalP;
        
        if(startPage != 1)
            pagingHTML.append("<span id='movepaging' onclick='boardPaging(" + (startPage-1) + ")'>이전</span>");    
        
        for(int i=startPage; i<=endPage; i++) {
            if(i == currentPage)
                pagingHTML.append("<span id='currentPaging' onclick='boardPaging(" + i + ")'>" + i + "</span>");   
            else
                pagingHTML.append("<span id='paging' onclick='boardPaging(" + i + ")'>" + i + "</span>");
        }
        
        if(endPage < totalP)
            pagingHTML.append("<span id='movepaging' onclick='boardPaging(" + (endPage+1) + ")'>다음</span>");
    }
}