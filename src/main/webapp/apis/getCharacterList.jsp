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
	UserDAO userDAO = UserDAO.getInstance();
    AbilityDAO abilityDAO = AbilityDAO.getInstance();
    SkillDAO skillDAO = SkillDAO.getInstance();

	JSONObject requestData = Utils.getJsonFromRequest(request);
	String id = (String)requestData.get("id");
	
	JSONArray objArray = new JSONArray();
	
	List<CharacterDTO> characterList = userDAO.getCharacterList(id);
	
	if(characterList.size()==0){
		response.setStatus(401);
		HashMap<String, Object> obj = new HashMap<String, Object>();
		obj.put("message", "fail");
        objArray.add(obj);
	}else{
		response.setStatus(200);
		for(CharacterDTO C : characterList)
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
            obj.put("ablilty", abilityObj);

            List<SkillDTO> skillList = skillDAO.getSkillList();
            for(SkillDTO S:skillList)
            {
                if(S.getSkillID().equals(C.getSkillID()))
                {
                    HashMap<String, Object> skillObj = new HashMap<String, Object>();
                    skillObj.put("skillID", S.getSkillID());
                    skillObj.put("skillName", S.getSkillName());
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