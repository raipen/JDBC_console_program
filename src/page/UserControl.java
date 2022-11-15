package page;

import util.*;

public class UserControl extends Page
{
	public UserControl()
	{
		addMenu(new Menu("전체 조회")
		{
			public void execute()
			{
				/**
				 * 전체 아이디 출력 -> 아마 ID조회와 같은 클래스 하나 쓰면 될 듯?
				 * 선택한 아이디에 대한 작없 수행 메뉴 구성(단순 조회 +수정 +삭제)
				 */
			};
		});
		
		addMenu(new Menu("ID 검색")
		{
			public void execute()
			{
				/**
				 * TODO: 아이디 검색 받아서 해당 문자열이 들어있는 아이디 모두 출력, 출력 리스트에서 아이디 선택 가능
				 * 선택한 아이디에 대한 작업 수행 메뉴 구성(단순 조회 +수정 +삭제)
				 */
				
			};
		});
		
		addMenu(new Menu("조건 검색")
		{
			public void execute()
			{
				/**
				 * 조건에 맞춰서 (==query) 조회
				 * 아직 구체적 구현은 안 함
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
