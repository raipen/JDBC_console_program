package page;

import util.*;

public class MapControl extends Page
{
	public MapControl()
	{
		addMenu(new Menu("맵 전체 조회")
		{
			public void execute()
			{
				/**
				 * 맵 전체 조회
				 * 맵 선택 시 해당 맵의 오브젝트 전체 표시?
				 */
			}
		});
		
		addMenu(new Menu("맵 조건 조회")
		{
			public void execute()
			{
				/**
				 * 맵 조건 조회
				 */
			}
		});
		
		addMenu(new Menu("오브젝트 전체 조회")
		{
			public void execute()
			{
				/**
				 * 오브젝트 전체 조회
				 */
			}
		});
		
		addMenu(new Menu("오브젝트 조건 조회")
		{
			public void execute()
			{
				/**
				 * 오브젝트 선택 조회
				 */
			}
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
