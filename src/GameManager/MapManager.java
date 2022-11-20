package GameManager;

import java.util.List;

import DAO.MapDAO;
import page.Page;
import util.Menu;
import util.Stdin;

public class MapManager extends Page
{
	MapDAO mapDAO = MapDAO.getInstance();

	public MapManager()
	{
		addMenu(new Menu("맵별 발판 조회")
		{
			public void execute()
			{
				System.out.println("1. 북문\n2. 일청담\n3. 센트럴 파크\n4. IT융복합공학관");
				System.out.print("선택하세요 : ");
				int answer = Stdin.getScanner().nextInt();
				Stdin.getScanner().nextLine();

				List<String> baseList = mapDAO.getBaseOfMap(answer);
				System.out.println("총 " + baseList.size() + " 개");
				for (String r : baseList)
					System.out.println(r);
			};
		});

		addMenu(new Menu("일정 시간 이내 클리어한 기록이 있는 맵 조회")
		{
			public void execute()
			{
				System.out.print("클러어 시간을 입력해주세요(초 단위): ");
				int answer = Stdin.getScanner().nextInt();
				Stdin.getScanner().nextLine();

				List<String> countList = mapDAO.getMapClearedUnder(answer);
				for (String r : countList)
					System.out.println(r);
			};
		});

		addMenu(new Menu("데미지가 너무 강하거나 너무 커 피하기 어려운 장애물")
		{
			public void execute()
			{
				List<String> hurdleList = mapDAO.getHardHurdle();
				for (String r : hurdleList)
					System.out.println(r);
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
