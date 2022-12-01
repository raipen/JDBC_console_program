<%@ page language="java" contentType="application/json; charset=utf-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="utils.*" %>
<%@ page import="DAO.*"%>
<%@ page import="DTO.*"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONValue" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>

<%
	CharacterDAO characterDAO = CharacterDAO.getInstance();
    AbilityDAO abilityDAO = AbilityDAO.getInstance();
    SkillDAO skillDAO = SkillDAO.getInstance();
    List<SkillDTO> skillList = skillDAO.getSkillList();

	JSONObject requestData = Utils.getJsonFromRequest(request);
	String id = (String)requestData.get("id");
	
	JSONArray objArray = new JSONArray();
	
	List<CharacterDTO_GM> characterList = characterDAO.getCharacterList_GM(id);
	
	if(characterList.size()==0){
		response.setStatus(401);
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("message", "fail");
	}else{
		response.setStatus(200);
		for(CharacterDTO_GM C : characterList)
		{
			HashMap<String, Object> obj = new HashMap<String, Object>();
			obj.put("characterID",C.getCharacterID());
			obj.put("characterName",C.getCharacterName());
			obj.put("lv",C.getLv());
			obj.put("exp",C.getExp());

            HashMap<String, Object> abilityObj = new HashMap<String, Object>();
            AbilityDTO abilityDTO = abilityDAO.getAbility(C);

            abilityObj.put("life",abilityDTO.getLife());
            abilityObj.put("speed",abilityDTO.getSpeed());
            abilityObj.put("coolDown",abilityDTO.getCoolDown());
            obj.put("ablilty",abilityObj);

            for(SkillDTO S:skillList)
            {
                if(S.getSkillName().equals(C.getSkillID()))
                {
                    HashMap<String, Object> skillObj = new HashMap<String, Object>();
                    skillObj.put("skillID", S.getSkillID());
                    skillObj.put("skillName", C.getSkillID());
                    obj.put("skill", skillObj);
                    break;
                }
            }

			objArray.add(obj);
		}
		
	}
	//System.out.println(objArray.toString());
	
	response.getWriter().write(objArray.toString());
%>