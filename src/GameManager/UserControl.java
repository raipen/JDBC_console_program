package GameManager;

import page.*;
import util.*;

public class UserControl extends Page
{
	public UserControl()
	{
		addMenu(new Menu("계정 전체 조회")
		{
			public void execute()
			{
				/**
				 * 전체 아이디 출력 -> 아마 ID조회와 같은 클래스 하나 쓰면 될 듯?
				 * 선택한 아이디에 대한 작없 수행 메뉴 구성(단순 조회 +수정 +삭제)
				 */
			};
		});
		
		addMenu(new Menu("뒤로가기", true)
		{
			public void execute()
			{
				System.out.println("뒤로가기");
			};
		});
	}
}
