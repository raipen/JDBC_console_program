package GameManager;

import DTO.UserDTO;
import page.*;
import util.*;

public class GameManagerMain extends Page
{
	public GameManagerMain()
	{
		System.out.println("관리자님 환영합니다.");

		addMenu(new Menu("계정 관리")
		{
			public void execute()
			{
				new UserControl().start();
			};
		});

		addMenu(new Menu("맵 관리")
		{
			public void execute()
			{
				new MapControl().start();
			};
		});
		
		addMenu(new Menu("로그아웃", true)
		{
			public void execute()
			{
				System.out.println("로그아웃");
			};
		});
	}

}