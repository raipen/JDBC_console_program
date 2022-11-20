package GameManager;

import java.util.List;

import DAO.RecordDAO;
import page.Page;
import util.Menu;
import util.Stdin;

public class RecordManager extends Page
{
	RecordDAO recordDAO = RecordDAO.getInstance();

	public RecordManager()
	{
		addMenu(new Menu("모든 클리어 기록 조회")
		{
			public void execute()
			{
				List<String> recordList = recordDAO.getClearRecords();
				for (String r : recordList)
					System.out.println(r);
			};
		});

		addMenu(new Menu("계정별 각 맵 클리어 횟수 조회")
		{
			public void execute()
			{
				List<String> countList = recordDAO.getUserClearCounts();
				for (String r : countList)
					System.out.println(r);
			};
		});

		addMenu(new Menu("스킬별 클리어 횟수 조회")
		{
			public void execute()
			{
				List<String> countList = recordDAO.getSkillClearCounts();
				for (String r : countList)
					System.out.println(r);
			};
		});

		addMenu(new Menu("목숨 단 3개로 일정 시간 이내 클리어한 캐릭터 조회")
		{
			public void execute()
			{
				System.out.print("클러어 시간을 입력해주세요(초 단위): ");
				int answer = Stdin.getScanner().nextInt();
				Stdin.getScanner().nextLine();

				List<String> characterList = recordDAO
						.getThreeLifeClearCharacterList(answer);
				System.out.println("총 " + characterList.size() + " 개");
				for (String r : characterList)
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
